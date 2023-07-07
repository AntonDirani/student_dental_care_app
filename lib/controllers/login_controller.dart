import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:student_care_app/resources/constants_manager.dart';

class LoginController extends ChangeNotifier {
  String? _token;

  Future<void> logIn(String email, String pass) async {
    try {
      var url = 'http://10.0.2.2:8000/api/login';
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
    } catch (e) {
      print(e);
    }
  }
}
