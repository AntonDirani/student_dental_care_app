// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_care_app/resources/constants_manager.dart';

import '../models/patient_model.dart';

class PatientController extends ChangeNotifier {
  String? _token;
  Patient? _patientInfo;
  bool _isApiInProgressAppointment = false;
  bool _isApiSuccessfulAppointment = false;
  String _apiResponseAppointment = '';

  bool _isApiInProgressReport = false;
  bool _isApiSuccessfulReport = false;
  String _apiResponseReport = '';

  bool get isApiInProgress => _isApiInProgressAppointment;
  String get apiResponse => _apiResponseAppointment;
  bool get isApiSuccessful => _isApiSuccessfulAppointment;

  bool get isApiInProgressReport => _isApiInProgressReport;
  String get apiResponseReport => _apiResponseReport;
  bool get isApiSuccessfulReport => _isApiSuccessfulReport;

  Future<bool> patientDataEntry({
    required int locationId,
    required String dateOfBirth,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token');
      var url = '${AppConstants.mainUrl}/patient_data_entry';
      final response = await http.post(Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "date_of_birth": dateOfBirth,
            "location_id": locationId,
          }));

      final body = jsonDecode(response.body);
      print(body);

      //_patientInfo?.patientLocationGovernorate = locationId;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> patientShowProfile({
    required int patientId,
  }) async {
    try {
      var url = '${AppConstants.mainUrl}/patient_data_entry';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final body = jsonDecode(response.body);
      _patientInfo?.patientLocationGovernorate = body[1]['location_id'];
      _patientInfo?.patientPhoneNumber = body[0]['phone_number'];
      _patientInfo?.patientDateOfBirth = body[1]['date_of_birth'];

      print(body);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> makeAppointment(String date, int postId) async {
    try {
      _isApiInProgressAppointment = true;
      notifyListeners();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token');
      var url = '${AppConstants.mainUrl}/date/$postId';

      final response = await http.post(Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "date": date,
          }));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('POST request successful');
        print(data);
        _apiResponseAppointment = data[0];
        bool isSuccess = true; // Replace with your API logic
        _isApiSuccessfulAppointment = isSuccess;
        notifyListeners();
        return true;
      } else {
        print('Error: ${response.statusCode}');
        print('Response: $date');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    } finally {
      _isApiInProgressAppointment = false;
      notifyListeners();
    }
  }

  Future<bool> reportPost({required int reportId, required int postId}) async {
    try {
      _isApiInProgressReport = true;
      notifyListeners();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token');
      print(postId);
      var url = '${AppConstants.mainUrl}/report_post/$postId';

      final response = await http.post(Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "report_id": reportId,
          }));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        //print('POST request successful');
        print(data);
        //_apiResponseReport = data[0];
        bool isSuccess = true; // Replace with your API logic
        _isApiSuccessfulReport = isSuccess;
        notifyListeners();
        return true;
      } else {
        _isApiSuccessfulReport = false;
        _apiResponseReport = data['message'];
        print('Error: ${response.statusCode}');
        print('Response: $data');
        return false;
      }
    } catch (e) {
      print(e);
      _apiResponseReport = e.toString();
      return false;
    } finally {
      _isApiInProgressReport = false;
      notifyListeners();
    }
  }
}
