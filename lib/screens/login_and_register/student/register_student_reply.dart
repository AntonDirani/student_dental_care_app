import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:student_care_app/controllers/register_controller.dart';
import 'package:student_care_app/home_screen.dart';
import 'package:student_care_app/screens/home_screen_student.dart';
import 'package:student_care_app/screens/login_and_register/signup_choose_role.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/components_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';

class RegisterStudentReply extends StatelessWidget {
  RegisterStudentReply({super.key});

  bool _isStudent = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RegisterController>(context, listen: false);
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p33),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: SvgPicture.asset(
                ImageAssetsManager.approveVector,
              ),
            ),
          ),
          Text(AppStrings.successStudentUploadText,
              style: StylesManager.medium20(), textAlign: TextAlign.center),
          Text(AppStrings.notifyStudentUploadText,
              style: StylesManager.regular18(), textAlign: TextAlign.center),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Container(
                // height: AppSize.s18,
                decoration: BoxDecoration(
                    color: ColorManager.lightGrey,
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppSize.s4))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                      child: Text(
                        AppStrings.attentionText,
                        style: StylesManager.bold16Red(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                      child: Text(
                        AppStrings.attentionSecondText,
                        style: StylesManager.medium16(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 3.h, 0, 1.h),
            child: ComponentManager.mainGradientButton(
              onPressed: () async {
                _isStudent = await provider.isStudent();

                if (_isStudent) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreenStudent()),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }
              },
              text: AppStrings.continueText,
            ),
          ),
        ]),
      ),
    ));
  }
}
