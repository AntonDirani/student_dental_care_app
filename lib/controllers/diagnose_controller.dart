import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_care_app/models/questions_model.dart';
import 'package:student_care_app/models/result_model.dart';
import 'package:student_care_app/resources/constants_manager.dart';

class DiagnoseController extends ChangeNotifier {
  String? token;

  //! get all questions
  Future<List<Question>> fetchQuestions() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token');
      print("TOKEN: $token");
      var url = '${AppConstants.mainUrl}/question_tree';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final List questions = jsonDecode(response.body);
        return questions.map((e) => Question.fromJson(e)).toList();
      } else {
        print('Failed to load questions');
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  //! get results
  Future<Result?> getResult(int id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token');
      print("TOKEN: $token");
      var url = '${AppConstants.mainUrl}/select_treatment_from_questions';
      final response = await http.post(Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "question_id": id,
          }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        final result = Result.fromJson(res);
        return result;
      } else {
        print('Failed to load result');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
