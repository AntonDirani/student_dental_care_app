import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_care_app/controllers/student_controller.dart';

import 'package:student_care_app/resources/color_manager.dart';
import 'package:student_care_app/resources/styles_manager.dart';
import 'package:student_care_app/screens/login_and_register/login.dart';
import 'package:student_care_app/screens/login_and_register/patient/choose_treatment.dart';
import '../models/student_model.dart';
import '../screens/student_screens/my_posts.dart';

class HomeScreenStudentDrawer extends StatefulWidget {
  /* HomeScreenStudentDrawer(Student student) : _student = student;

  Student _student;*/
  @override
  State<HomeScreenStudentDrawer> createState() =>
      _HomeScreenStudentDrawerState(/*_student*/);
}

class _HomeScreenStudentDrawerState extends State<HomeScreenStudentDrawer> {
  _HomeScreenStudentDrawerState(/*Student student*/) /*: _student = student*/;
  late Student _student;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          padding: const EdgeInsets.all(0),
          child: Container(
              color: ColorManager.primary,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FutureBuilder<Student>(
                  future: Provider.of<StudentController>(context, listen: false)
                      .getStudent(),
                  builder:
                      (BuildContext context, AsyncSnapshot<Student> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData) {
                      return const Text('No data available.');
                    } else {
                      Student _theStudent = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChooseTreatment()),
                              );
                            },
                            child: CircleAvatar(
                              radius: 4.5.h,
                              backgroundImage:
                                  NetworkImage(_theStudent.profileImage!),
                            ),
                          ),
                          Text(
                            _theStudent.studentName!,
                            style: StylesManager.medium18White(),
                          ),
                          Text(
                            _theStudent.studentEmail!,
                            style: StylesManager.regular16White(),
                          )
                        ],
                      );
                    }
                  },
                ),
              )),
        ),
        ListTile(
          subtitle: Text(
            'رؤية الحالات الطبية التى قمت بنشرها',
            style: StylesManager.regular14Grey(),
            textAlign: TextAlign.end,
          ),
          trailing: Icon(
            Icons.table_rows,
            color: ColorManager.primary,
            size: 4.5.h,
          ),
          title: Text(
            'منشوراتي',
            textAlign: TextAlign.end,
            style: StylesManager.bold17Black(),
          ),
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StudentMyPosts()),
            );
          },
        ),
        ListTile(
          subtitle: Text(
            'تسجيل الخروج من التطبيق',
            style: StylesManager.regular14Grey(),
            textAlign: TextAlign.end,
          ),
          trailing: Icon(
            Icons.logout,
            color: ColorManager.primary,
            size: 4.5.h,
          ),
          title: Text(
            'تسجيل الخروج',
            textAlign: TextAlign.end,
            style: StylesManager.bold17Black(),
          ),
          onTap: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.clear();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
      ],
    ));
  }
}
