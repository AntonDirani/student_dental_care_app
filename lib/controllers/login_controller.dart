// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student_care_app/resources/constants_manager.dart';

class LoginController extends ChangeNotifier {
  String? _token;

  Future<bool> logIn(String email, String password) async {
    try {
      var url = '${AppConstants.mainUrl}/login';

      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "email": email,
            "password": password,
          }));

      final body = jsonDecode(response.body);

      _token = await body['The Token'];
      //print(_token);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
