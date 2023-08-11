// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:student_care_app/resources/constants_manager.dart';
import 'package:student_care_app/models/university_model.dart';

class UniveristyController extends ChangeNotifier {
  List<University> _unis =
      []; /*
  final List<String> _unisNames = [
    'اختر الجامعة الخاصة بك...',
  ];
  final List<int> _unisIds = [0];*/
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

  /*void unPackUnisNames(List<University> unis) {
    for (int i = 0; i < unis.length; i++) {
      _unisIds.add(unis[i].uniId!);
    }
  }

  void unPackUnisIds(List<University> unis) {
    for (int i = 0; i < unis.length; i++) {
      _unisNames.add(unis[i].uniName.toString());
    }
  }*/

  List<University> get unis => _unis;

  //List<String> get unisNames => _unisNames;
}
