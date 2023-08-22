// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_care_app/models/appointment_model.dart';
import 'package:student_care_app/models/student_model.dart';

import '../models/post_model.dart';
import '../resources/assets_manager.dart';
import '../resources/constants_manager.dart';

class StudentController extends ChangeNotifier {
  late List<Appointment> _currentPostAppointments;
  List<Student> _studentsFiltered = [];
  Student _student = Student();
  late Student _studentSearchProfile;
  String _apiResponseDelete = '';

  Student get studentSearchProfile => _studentSearchProfile;

  Student get student => _student;

  String get apiResponse => _apiResponseDelete;

  String? _token;
  bool _isApiInProgress = false;
  bool _isApiSuccessful = false;

  bool get isApiInProgress => _isApiInProgress;
  bool get isApiSuccessful => _isApiSuccessful;

  bool _isApiInProgressDelete = false;
  bool _isApiSuccessfulDelete = false;

  bool get isApiInProgressDelete => _isApiInProgressDelete;
  bool get isApiSuccessfulDelete => _isApiSuccessfulDelete;

  List<Post> _myPosts = [];

  Future<bool> getMyPosts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token');
      print(_token);
      var url = '${AppConstants.mainUrl}/my_posts';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final data = jsonDecode(response.body) as List<dynamic>;
      print(data);

      final List<String> loadedImages = [];

      List<String> ourImageArray = [];

      final List<Post> loadedPosts = [];

      for (int j = 0; j < data.length; j++) {
        final imageArray = data[j]['post_photos'] as List<dynamic>;

        List<String> loadedImages = []; // Initialize image list for each post

        for (int k = 0; k < imageArray.length; k++) {
          // Extracting the image URL from the innermost array
          List<dynamic> imageList = imageArray[k][0];
          String imageUrl = imageList[0];
          loadedImages.add('${AppConstants.mainUrl}/show_image/$imageUrl');
        }

        String firstDateTimeString = data[j]['first_date'];
        String secondDateTimeString = data[j]['last_date'];
        // Parse the string into a DateTime object
        DateTime firstDateTime = DateTime.parse(firstDateTimeString);
        DateTime lastDateTime = DateTime.parse(secondDateTimeString);
        // Extract the date in 'yyyy-MM-dd' format
        String date1 =
            "${firstDateTime.year}-${firstDateTime.month.toString().padLeft(2, '0')}-${firstDateTime.day.toString().padLeft(2, '0')}";

        // Extract the time in 'HH:mm' format
        String time1 =
            "${firstDateTime.hour.toString().padLeft(2, '0')}:${firstDateTime.minute.toString().padLeft(2, '0')}";

        String date2 =
            "${lastDateTime.year}-${lastDateTime.month.toString().padLeft(2, '0')}-${lastDateTime.day.toString().padLeft(2, '0')}";

        print(data[j]['post_id']);
        // Extract the time in 'HH:mm' format
        String time2 =
            "${lastDateTime.hour.toString().padLeft(2, '0')}:${lastDateTime.minute.toString().padLeft(2, '0')}";

        final userIdPost = data[j]['user_id'];
        var urlStudent =
            '${AppConstants.mainUrl}/view_student_profile/$userIdPost';
        final responseStudent = await http.get(
          Uri.parse(urlStudent),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        final dataStudent = jsonDecode(responseStudent.body);
        print(dataStudent);
        final Student tempPostStudent;

        final info0Student = dataStudent['0'] as List<dynamic>;
        final info1Student = dataStudent['1'] as List<dynamic>;
        final imageStudentName = dataStudent['profile_photo'];
        tempPostStudent = Student(
            profileImage:
                '${AppConstants.mainUrl}/show_image/$imageStudentName',
            studentPhoneNumber: info0Student[0]['phone_number'],
            studentUniversityId: info1Student[0]['university_id'],
            studentYear: info1Student[0]['studying_year']);

        loadedPosts.add(Post(
            postStudentCreator: tempPostStudent,
            postId: data[j]['post_id'],
            postDescription: data[j]['description'],
            postImages: loadedImages,
            postFirstDate: date1,
            postFirstTime: time1,
            postLastDate: date2,
            postLastTime: time2,
            postStudentName: data[j]['student_name'],
            postAvgRate: data[j]['\$avg_rate'],
            postUniName: data[j]['university'],
            postTreatmentName: data[j]['treatment_name'],
            postTreatmentDescription: data[j]['treatment_description']));
      }

      _myPosts = loadedPosts;
      print('object');
      print(_myPosts);
      print('object');
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Appointment>> getCurrentPostAppointmentsList() async {
    notifyListeners();
    return _currentPostAppointments;
  }

  Future<Student> getStudent() async {
    notifyListeners();
    return _student;
  }

  Future<List<Post>> getMyPostsList() async {
    notifyListeners();
    return _myPosts;
  }

  Future<List<Student>> getStudentsByNameList() async {
    notifyListeners();
    return _studentsFiltered;
  }

  Future<bool> studentDataEntry({
    required int uniId,
    required File idImage,
    required File profileImage,
    required int studyYear,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token');
      var url = Uri.parse(
          '${AppConstants.mainUrl}/student_data_entry'); // Replace with your actual URL.

      var request = http.MultipartRequest('POST', url);

      // Add the images as MultipartFile parts.
      request.files.add(
        await http.MultipartFile.fromPath('card', idImage.path),
      );
      request.files.add(
        await http.MultipartFile.fromPath('file', profileImage.path),
      );
      request.headers['Authorization'] = 'Bearer $_token';
      // Add the IDs as fields.
      request.fields['studying_year'] = studyYear.toString();
      request.fields['university_id'] = uniId.toString();

      var response = await request.send();
      String responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        print('POST request successful');
        //print(await response.stream.bytesToString());
        print('true');
        return true;
      } else {
        print('Error: ${response.statusCode}');
        print('Response: $responseBody');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addPost({
    required String description,
    required int? treatmentId,
    required List<XFile> imageFileList,
    required String firstDate,
    required String lastDate,
  }) async {
    try {
      _isApiInProgress = true;
      notifyListeners();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token');
      var url = Uri.parse('${AppConstants.mainUrl}/add_post');

      var request = http.MultipartRequest('POST', url);

      for (var imageFile in imageFileList) {
        File? file = File(imageFile.path);

        request.files.add(
          await http.MultipartFile.fromPath('files[]', file.path),
        );
      }

      request.headers['Authorization'] = 'Bearer $_token';
      request.fields['description'] = description;
      request.fields['treatment_id'] = treatmentId.toString();
      request.fields['first_date'] = firstDate;
      request.fields['last_date'] = lastDate;

      var response = await request.send();
      if (response.statusCode == 200) {
        print('POST request successful');
        print(await response.stream.bytesToString());
        bool isSuccess = true; // Replace with your API logic
        _isApiSuccessful = isSuccess;
        notifyListeners();
        return true;
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${await response.stream.bytesToString()}');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    } finally {
      _isApiInProgress = false;
      notifyListeners();
    }
  }

  Future<bool> fetchStudentProfile({required int userId}) async {
    try {
      var urlStudent = '${AppConstants.mainUrl}/view_student_profile/$userId';
      final response = await http.get(
        Uri.parse(urlStudent),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final dataStudent = jsonDecode(response.body);
      print(dataStudent);
      final Student tempPostStudent;

      final info0Student = dataStudent['0'] as List<dynamic>;
      final info1Student = dataStudent['1'] as List<dynamic>;

      tempPostStudent = Student(
          profileImage: dataStudent['profile_photo'],
          studentPhoneNumber: info0Student[0]['phone_number'],
          studentUniversityId: info1Student[0]['university_id'],
          studentYear: info1Student[0]['studying_year']);
      /*print(info0);
      print(info1);
      print(int.parse(tempPostStudent.studentYear!)); */
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deletePost({required int postId}) async {
    try {
      _isApiInProgressDelete = true;
      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token');
      print(_token);
      var url = '${AppConstants.mainUrl}/delete_post/$postId';
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final body = jsonDecode(response.body);
      print(body);
      if (response.statusCode == 200) {
        print('POST request successful');
        bool isSuccess = true; // Replace with your API logic
        _isApiSuccessfulDelete = isSuccess;
        notifyListeners();
        return true;
      } else {
        print('Error: ${response.statusCode}');
        print('Response: $body ');
        _apiResponseDelete = body;
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    } finally {
      _isApiInProgressDelete = false;
      notifyListeners();
    }
  }

  Future<bool> getPostAppointments(int postId) async {
    try {
      print('hereee');
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'GET', Uri.parse('${AppConstants.mainUrl}/show_posts_dates'));
      request.body = json.encode({"post_id": postId});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
// Convert the response to a String
      String responseBody = await response.stream.bytesToString();

// Parse the response JSON
      Map<String, dynamic> jsonResponse = json.decode(responseBody);

// Extract the values
      int count = jsonResponse['count'];
      final data = jsonResponse['data'] as List<dynamic>;
      print('object');
      print(data);
      List<Appointment> loadedAppointments = [];
// Iterate through the data list to extract id and patient_name

      for (var item in data) {
        int id = item['id'];
        String patientName = item['patient_name'];
        loadedAppointments.add(Appointment(
            appointmentId: id, appointmentPatientName: patientName));
        print('ID: $id, Patient Name: $patientName');
      }

      /*String responseBody = await response.stream.bytesToString();
      print(responseBody);
      final data = responseBody["data"];
      print(data);
      List<Appointment> loadedAppointments = [];*/

      /*  for (int j = 0; j < data.length; j++) {
        loadedAppointments.add(Appointment(
            appointmentId: data[j]['id'],
            appointmentPatientName: data[j]['id']));
      }*/

      _currentPostAppointments = loadedAppointments;
      print(_currentPostAppointments);
      notifyListeners();
      /*unPackUnisNames(_unis);
      unPackUnisIds(_unis);*/
      // print(_unisNames);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getStudentProfile() async {
    try {
      print('Its workinsgg');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final studentId = await prefs.getInt('userId');
      var urlStudent =
          '${AppConstants.mainUrl}/view_student_profile/$studentId';
      final responseStudent = await http.get(
        Uri.parse(urlStudent),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final dataStudent = jsonDecode(responseStudent.body);
      print(dataStudent);
      if (responseStudent.statusCode == 200) {
        final Student tempStudent;
        final info0Student = dataStudent['0'] as List<dynamic>;
        final info1Student = dataStudent['1'] as List<dynamic>;
        final imageStudentName = dataStudent['profile_photo'];
        tempStudent = Student(
            studentEmail: info0Student[0]['email'],
            studentName: info0Student[0]['name'],
            profileImage:
                '${AppConstants.mainUrl}/show_image/$imageStudentName',
            studentPhoneNumber: info0Student[0]['phone_number'],
            studentUniversityId: info1Student[0]['university_id'],
            studentYear: info1Student[0]['studying_year']);
        _student = tempStudent;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getStudentsByName(String studentName) async {
    try {
      print('Here');
      var urlStudent = '${AppConstants.mainUrl}/search_by_student_name';

      final responseStudent = await http.post(Uri.parse(urlStudent),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "name": studentName,
          }));

      print('Heresssssss');
      print(responseStudent.body);
      final dataStudent = jsonDecode(responseStudent.body) as List<dynamic>;
      print(dataStudent);
      if (responseStudent.statusCode == 200) {
        List<Student> tempStudentsList = [];
        for (int i = 0; i < dataStudent.length; i++) {
          tempStudentsList.add(Student(
            profileImage: dataStudent[i]['photo_name'],
            studentId: dataStudent[i]['student']['id'],
            studentName: dataStudent[i]['student']['name'],
          ));
        }

        _studentsFiltered = tempStudentsList;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> viewStudentProfile(int studentId) async {
    try {
      var urlStudent =
          '${AppConstants.mainUrl}/view_student_profile/$studentId';
      final responseStudent = await http.get(
        Uri.parse(urlStudent),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final dataStudent = jsonDecode(responseStudent.body);
      print(dataStudent);
      final Student tempPostStudent;

      final info0Student = dataStudent['0'] as List<dynamic>;
      final info1Student = dataStudent['1'] as List<dynamic>;
      final imageStudentName = dataStudent['profile_photo'];
      tempPostStudent = Student(
          studentName: info0Student[0]['name'],
          profileImage: '${AppConstants.mainUrl}/show_image/$imageStudentName',
          studentPhoneNumber: info0Student[0]['phone_number'],
          studentUniversityId: info1Student[0]['university_id'],
          studentYear: info1Student[0]['studying_year']);

      _studentSearchProfile = tempPostStudent;
      return true;
    } catch (e) {
      return false;
    }
  }
}
