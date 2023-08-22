import 'dart:io';

import 'package:student_care_app/models/user_model.dart';

class Student extends User {
  int? studentId;
  String? profileImage;
  File? idImage;
  String? studentYear;
  int? studentUniversityId;
  String? studentPhoneNumber;
  String? studentName;
  String? studentEmail;
  Student(
      {this.studentId,
      this.studentEmail,
      this.studentName,
      this.studentPhoneNumber,
      this.profileImage,
      this.idImage,
      this.studentYear,
      this.studentUniversityId});

  @override
  String? get userRole => 'Student';
}
