import 'package:student_care_app/models/location_model.dart';

class Patient {
  int? patientId;
  String? patientPhoneNumber;
  Governorate? patientLocationId;
  String? patientDateOfBirth;

  Patient(
      {this.patientId,
      this.patientPhoneNumber,
      this.patientLocationId,
      this.patientDateOfBirth});
}
