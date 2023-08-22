// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_care_app/resources/constants_manager.dart';
import '../models/user_model.dart';

class LoginController extends ChangeNotifier {
  String? _token;
  User? _user;

  Future<bool> logIn(String email, String pass) async {
    try {
      var url = '${AppConstants.mainUrl}/login';

      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "email": email,
            "password": pass,
          }));

      final body = jsonDecode(response.body);

      _token = await body['The Token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      print(prefs.getString('token'));
      var userDetails = await body['User Details'];
      print(userDetails);
      _user = User(
          userEmail: userDetails['email'],
          userId: userDetails['id'],
          userRole: userDetails['role'],
          userName: userDetails['name']);
      await prefs.setString('userRole', _user!.userRole!);
      await prefs.setInt('userId', _user!.userId!);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> isStudent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theRole = prefs.getString('userRole');
    if (theRole == 'Student') {
      print('you are a student');
      return true;
    } else {
      return false;
    }
  }
}
