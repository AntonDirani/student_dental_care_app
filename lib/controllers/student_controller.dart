import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:student_care_app/resources/constants_manager.dart';

class StudentController extends ChangeNotifier {
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
      print(body);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
