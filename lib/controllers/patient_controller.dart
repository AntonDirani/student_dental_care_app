// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_care_app/resources/constants_manager.dart';

import '../models/patient_model.dart';

class PatientController extends ChangeNotifier {
  String? _token;
  Patient? _patientinfo;

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
      _patientinfo?.patientLocationId = body[1]['location_id'];
      _patientinfo?.patientPhoneNumber = body[0]['phone_number'];
      _patientinfo?.patientDateOfBirth = body[1]['date_of_birth'];

      print(body);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
