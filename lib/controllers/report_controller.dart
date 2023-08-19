import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:student_care_app/models/report_model.dart';

import '../resources/constants_manager.dart';
import 'package:http/http.dart' as http;

class ReportController extends ChangeNotifier {
  List<ReportItem> _reportItems = [
    ReportItem(
        reportItemId: 1, reportItemName: 'نشر محتوى خارج نطاق طب الأسنان')
  ];
  Future<bool> fetchReportsItems() async {
    try {
      var url = '${AppConstants.mainUrl}/show_reports_reasons';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final data = jsonDecode(response.body) as List<dynamic>;
      print(data);
      final List<ReportItem> loadedReportItems = [];
      for (int j = 0; j < data.length; j++) {
        loadedReportItems.add(ReportItem(
            reportItemId: data[j]['id'], reportItemName: data[j]['report']));
      }

      _reportItems = loadedReportItems;
      print(loadedReportItems);
      /*unPackUnisNames(_unis);
      unPackUnisIds(_unis);*/
      // print(_unisNames);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  List<ReportItem> get reportItems => _reportItems;
}
