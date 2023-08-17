// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_care_app/models/user_model.dart';
import 'package:student_care_app/resources/constants_manager.dart';

class RegisterController extends ChangeNotifier {
  String? _token;
  User? _user;
  Future<bool> register({
    required String email,
    required String pass,
    required String firstName,
    required String secondName,
    required String phoneNumber,
    required String role,
  }) async {
    try {
      var url = '${AppConstants.mainUrl}/register';
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "name": '$firstName $secondName',
            "email": email,
            "password": pass,
            "phone_number": phoneNumber,
            "role": role
          }));

      final body = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _token = await body['The Token'];
      await prefs.setString('token', _token!);
      var userDetails = await body['User Details :'];

      _user = User(
          userEmail: userDetails['email'],
          userId: userDetails['id'],
          userRole: userDetails['role'],
          userPhone: userDetails['phone_number'],
          userName: userDetails['name']);
      await prefs.setString('userRole', _user!.userRole!);
      await prefs.setInt('userId', _user!.userId!);
      print(prefs.getInt('userId'));
      print(prefs.getString('userRole'));
      print(prefs.getString('token'));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  String? get token => _token;
}
