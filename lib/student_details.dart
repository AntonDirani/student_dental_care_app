import 'package:flutter/material.dart';
import 'package:student_care_app/resources/color_manager.dart';
import 'package:student_care_app/resources/styles_manager.dart';

class StudentProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              radius: 80,
              backgroundImage: AssetImage('assets/student_picture.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              'الياس فهد الخير',
              style: StylesManager.bold20Black(),
            ),
            Text(
              'طالب طب أسنان',
              style: StylesManager.regular16Grey(),
            ),
            SizedBox(height: 20),
            ProfileInfoCard(
              icon: Icons.school,
              text: 'جامعة دمشق',
            ),
            ProfileInfoCard(
              icon: Icons.calendar_today,
              text: 'السنة الرابعة',
            ),
            ProfileInfoCard(
              icon: Icons.phone,
              text: '+963 935487558',
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
        borderRadius: BorderRadius.circular(30),
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
