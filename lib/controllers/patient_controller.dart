// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_care_app/resources/constants_manager.dart';

class PatientController extends ChangeNotifier {
  String? _token;

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
}
