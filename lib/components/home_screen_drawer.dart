import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:student_care_app/resources/assets_manager.dart';
import 'package:student_care_app/resources/color_manager.dart';
import 'package:student_care_app/resources/styles_manager.dart';

import '../screens/login_and_register/student/register_student_reply.dart';
import '../screens/profiles/patient_profile.dart';

class HomeScreenDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
            padding: EdgeInsets.all(0),
            child: Container(
              color: ColorManager.primary,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PatientProfile()),
                        );
                      },
                      child: CircleAvatar(
                        radius: 4.5.h,
                        child: Image.asset(ImageAssetsManager.profileImage),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'شادي حكيمي',
                      style: StylesManager.medium18White(),
                    )
                  ],
                ),
              ),
            )),
        ListTile(
          subtitle: Text(
            'تسجيل الخروج من التطبيق',
            style: StylesManager.regular13(),
            textAlign: TextAlign.end,
          ),
          trailing: Icon(
            Icons.logout,
            color: ColorManager.grey,
            size: 4.5.h,
          ),
          title: Text(
            'تسجيل الخروج',
            textAlign: TextAlign.end,
            style: StylesManager.bold17Black(),
          ),
          onTap: () {
            //Navigator.pushReplacementNamed(context, Trips.id);
          },
        ),
      ],
    ));
  }
}
