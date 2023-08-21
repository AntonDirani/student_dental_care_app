// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_care_app/resources/constants_manager.dart';

class StudentController extends ChangeNotifier {
  String? _token;

  Future<bool> studentDataEntry({
    required int uniId,
    required File idImage,
    required File profileImage,
    required int studyYear,
  }) async {
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
  }
}
