import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_care_app/resources/assets_manager.dart';
import 'package:student_care_app/resources/color_manager.dart';
import 'package:student_care_app/resources/styles_manager.dart';
import 'package:student_care_app/screens/login_and_register/login.dart';
import 'package:student_care_app/screens/login_and_register/patient/choose_treatment.dart';

class HomeScreenDrawer extends StatelessWidget {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChooseTreatment()),
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
        /* ListTile(
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
            SharedPreferences preferences =
                await SharedPreferences.getInstance();

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StudentMyPosts()),
            );
          },
        ),*/
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
