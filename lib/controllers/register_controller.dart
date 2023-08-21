// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_care_app/models/user_model.dart';
import 'package:student_care_app/resources/constants_manager.dart';

class RegisterController extends ChangeNotifier {
  late String token;
  late User user;

  Future<User?> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
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
            "name": '$firstName $lastName',
            "email": email,
            "password": password,
            "phone_number": phoneNumber,
            "role": role
          }));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final userDetails = jsonResponse['User Details :'];
        user = User.fromJson(userDetails);
        final token = jsonResponse['The Token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        print(prefs.getString('token'));
      }
      return user;
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE " + '$e');
    }
  }

  // String? get token => _token;
}
