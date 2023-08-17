// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/constants_manager.dart';

class StudentController extends ChangeNotifier {
  String? _token;
  bool _isApiInProgress = false;
  bool _isApiSuccessful = false;

  bool get isApiInProgress => _isApiInProgress;
  bool get isApiSuccessful => _isApiSuccessful;

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
}
