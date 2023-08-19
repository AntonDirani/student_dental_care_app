// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:student_care_app/resources/constants_manager.dart';
import 'package:student_care_app/models/university_model.dart';

class UniversityController extends ChangeNotifier {
  List<University> _unis = [];
  Future<bool> getUnis() async {
    try {
      var url = '${AppConstants.mainUrl}/list_of_universities';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final data = jsonDecode(response.body) as List<dynamic>;
      print(data);
      final List<University> loadedUnis = [];
      for (int j = 0; j < data.length; j++) {
        loadedUnis
            .add(University(uniId: data[j]['id'], uniName: data[j]['name']));
      }

      _unis = loadedUnis;
      print(_unis);
      /*unPackUnisNames(_unis);
      unPackUnisIds(_unis);*/
      // print(_unisNames);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  List<University> get unis => _unis;
}
