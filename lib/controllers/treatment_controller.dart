import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/treatment_model.dart';
import '../resources/constants_manager.dart';

class TreatmentController extends ChangeNotifier {
  List<Treatment> _treatments = [];
  List<String> images = [];

  Future<bool> fetchTreatments() async {
    try {
      var url = '${AppConstants.mainUrl}/show_treatments';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final data = jsonDecode(response.body) as List<dynamic>;
      print(data);
      final List<Treatment> loadedTreatments = [];

      for (int j = 0; j < data.length; j++) {
        final details = data[j]['details'][0];
        print('Hererererrerreerer');
        print(details);
        loadedTreatments.add(Treatment(
            treatmentId: details['id'],
            treatmentName: details['name'],
            treatmentDescription: details['description'],
            treatmentImage: data[j]['photo']));
      }
      _treatments = loadedTreatments;
      print(_treatments);
      print('Hererererrerreerer');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Treatment>> getTreatmentsList() async {
    return _treatments;
  }
}
