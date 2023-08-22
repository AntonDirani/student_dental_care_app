import 'package:flutter/material.dart';
import 'package:student_care_app/controllers/university_controller.dart';
import 'package:student_care_app/resources/color_manager.dart';
import 'package:student_care_app/resources/styles_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'models/post_model.dart';
import 'models/student_model.dart';

class StudentProfileScreenStudent extends StatelessWidget {
  StudentProfileScreenStudent(Student student) : _student = student;

  final Student _student;
  void _launchPhoneDialer() async {
    final phoneNumber = _student.studentPhoneNumber;
    final url = 'tel:$phoneNumber';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_student);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'الملف الشخصي',
          style: StylesManager.medium18White(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(_student.profileImage!),
              radius: 80,
            ),
            SizedBox(height: 20),
            Text(
              _student.studentName!,
              style: StylesManager.bold20Black(),
            ),
            Text(
              'طالب طب أسنان',
              style: StylesManager.regular16Grey(),
            ),
            SizedBox(height: 20),
            ProfileInfoCard(
              icon: Icons.school,
              text: '_student.studentUniversityId.toString()',
            ),
            ProfileInfoCard(
              icon: Icons.calendar_today,
              text: UniversityController
                  .yearString[int.parse(_student.studentYear!)],
            ),
            GestureDetector(
              onTap: () {
                _launchPhoneDialer();
              },
              child: ProfileInfoCard(
                icon: Icons.phone,
                text: ' _student.studentName!',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final IconData icon;
  final String text;

  ProfileInfoCard({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: ColorManager.lightGrey,
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        trailing: Icon(
          icon,
          color: ColorManager.primary,
        ),
        title: Text(
          text,
          textAlign: TextAlign.right,
          style: StylesManager.medium17Black(),
        ),
      ),
    );
  }
}
