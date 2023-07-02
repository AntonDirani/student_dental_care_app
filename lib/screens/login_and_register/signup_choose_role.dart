import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:student_care_app/screens/login_and_register/register_student.dart';

import '../../resources/assets_manager.dart';
import '../../resources/components_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class SignUpChooseScreen extends StatelessWidget {
  const SignUpChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Row(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p33),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                      child: SvgPicture.asset(
                        ImageAssetsManager.chooseYourRoleVector,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Text(AppStrings.registerText,
                        style: StylesManager.medium20(),
                        textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                    child: ComponentManager.mainGradientButton(
                        text: AppStrings.registerAsStudentText,
                        navigate: const StudentRegisterScreen(),
                        context: context),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 1.h, 0, 4.h),
                    child: ComponentManager.secondaryGradientButton(
                        text: AppStrings.registerAsPatientText,
                        navigate: const SignUpChooseScreen(),
                        context: context),
                  ),
                ]),
          ),
        ),
      ]),
    ));
  }
}
