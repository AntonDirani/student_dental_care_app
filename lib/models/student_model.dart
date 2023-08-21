import 'dart:io';

import 'package:student_care_app/models/user_model.dart';

class Student extends User {
  String? profileImage;
  File? idImage;
  String? studentYear;
  int? studentUniversityId;
  String? studentPhoneNumber;

  Student(
      {this.studentPhoneNumber,
      this.profileImage,
      this.idImage,
      this.studentYear,
      this.studentUniversityId});

  @override
  String? get userRole => 'Student';
}
