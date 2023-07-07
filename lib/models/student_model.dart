import 'dart:io';

import 'package:student_care_app/models/user_model.dart';

class Student extends User {
  File? profileImage;
  File? idImage;
  String? studentYear;
  String? studentUniversity;

  @override
  String? get userRole => 'Student';
}
