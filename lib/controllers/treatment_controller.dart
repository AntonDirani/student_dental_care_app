import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:student_care_app/resources/assets_manager.dart';
import '../models/treatment_model.dart';

class TreatmentController extends ChangeNotifier {
  List<Treatment> _treatments = [
    Treatment(
        treatmentName: 'نخور',
        treatmentIcon: '',
        treatmentImage: ImageAssetsManager.cavityVector),
    Treatment(
        treatmentName: 'تقليح و تسوية جذور',
        treatmentIcon: '',
        treatmentImage: ImageAssetsManager.rootsImage),
    Treatment(
        treatmentName: 'تيجان',
        treatmentIcon: '',
        treatmentImage: ImageAssetsManager.crownsVector),
    Treatment(
        treatmentName: 'أطفال',
        treatmentIcon: '',
        treatmentImage: ImageAssetsManager.kidsImage),
    Treatment(
        treatmentName: 'بدلات',
        treatmentIcon: '',
        treatmentImage: ImageAssetsManager.dentureImage),
    Treatment(
        treatmentName: 'سحب عصب',
        treatmentIcon: '',
        treatmentImage: ImageAssetsManager.neuroImage),
    Treatment(
        treatmentName: 'حشوات',
        treatmentIcon: '',
        treatmentImage: ImageAssetsManager.fillImage),
    Treatment(
        treatmentName: 'جسور ثابتة',
        treatmentIcon: '',
        treatmentImage: ImageAssetsManager.bridgesImage),
    Treatment(
        treatmentName: 'قلع عادي',
        treatmentIcon: '',
        treatmentImage: ImageAssetsManager.extractImage),
  ];

/*  Future<bool> getTreatments() async {
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
      */ /*unPackUnisNames(_unis);
      unPackUnisIds(_unis);*/ /*
      // print(_unisNames);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }*/
  Future<List<Treatment>> getTreatmentsList() async {
    return _treatments;
  }
}
