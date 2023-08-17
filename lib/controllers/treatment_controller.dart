import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:student_care_app/resources/assets_manager.dart';
import '../models/treatment_model.dart';
import '../resources/constants_manager.dart';

class TreatmentController extends ChangeNotifier {
  List<Treatment> _treatments = [];
  List<String> images = [
    ImageAssetsManager.crownsVector,
    ImageAssetsManager.crownsVector,
    ImageAssetsManager.crownsVector,
    ImageAssetsManager.crownsVector,
    ImageAssetsManager.crownsVector,
    ImageAssetsManager.crownsVector,
    ImageAssetsManager.crownsVector,
    ImageAssetsManager.crownsVector,
    ImageAssetsManager.crownsVector,
  ];

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
      for (int j = 0; j < 9; j++) {
        loadedTreatments.add(Treatment(
            treatmentId: data[j]['id'],
            treatmentName: data[j]['name'],
            treatmentDescription: data[j]['description'],
            treatmentImage: images[j]));
      }
      _treatments = loadedTreatments;
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
