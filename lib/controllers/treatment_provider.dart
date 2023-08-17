import 'package:flutter/material.dart';

import '../models/treatment_model.dart';

class TreatmentSelectionState extends ChangeNotifier {
  Treatment? _selectedTreatment;

  Treatment? get selectedTreatment => _selectedTreatment;

  void selectTreatment(Treatment treatment) {
    _selectedTreatment = treatment;
    notifyListeners();
  }
}
