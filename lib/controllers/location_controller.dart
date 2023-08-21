// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student_care_app/models/location_model.dart';
import 'package:student_care_app/resources/constants_manager.dart';

class LocationController extends ChangeNotifier {
  List<Governorate> _locations = [];

  Future<bool> fetchLocations() async {
    try {
      var url = '${AppConstants.mainUrl}/list_of_locations';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final data = jsonDecode(response.body) as List<dynamic>;
      print(data);
      final List<Governorate> loadedLocations = [
        Governorate(governorateId: 0, governorateName: 'جميع المحافظات')
      ];
      for (int j = 0; j < data.length; j++) {
        loadedLocations.add(Governorate(
            governorateId: data[j]['id'],
            governorateName: data[j]['location_name']));
      }

      _locations = loadedLocations;
      print(_locations);
      /*unPackUnisNames(_unis);
      unPackUnisIds(_unis);*/
      // print(_unisNames);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Governorate>> getLocationsList() async {
    return _locations;
  }

  List<Governorate> get locations => _locations;
}
