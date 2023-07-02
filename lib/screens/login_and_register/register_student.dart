import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../resources/assets_manager.dart';
import '../../resources/components_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import 'login.dart';

class StudentRegisterScreen extends StatelessWidget {
  const StudentRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p33),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SvgPicture.asset(
                    ImageAssetsManager.studentRegisterVector,
                    alignment: Alignment.topRight,
                  ),
                ),
                Text(
                  AppStrings.welcomeStudentText,
                  style: StylesManager.medium20(),
                ),
                Text(
                  AppStrings.enterInfoText,
                  style: StylesManager.light20(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: ComponentManager.myTextFieldNoSuffix(
                          label: AppStrings.enterYourFirstNameText,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: ComponentManager.myTextFieldNoSuffix(
                          label: AppStrings.enterYourSecondNameText,
                        ),
                      ),
                    ),
                  ],
                ),
                ComponentManager.myTextField(
                    label: AppStrings.emailText,
                    suffixIcon: ImageAssetsManager.emailIcon),
                ComponentManager.myTextField(
                    label: AppStrings.emailText,
                    suffixIcon: ImageAssetsManager.emailIcon),
                ComponentManager.myTextField(
                    label: AppStrings.emailText,
                    suffixIcon: ImageAssetsManager.emailIcon),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 1.h),
                  child: ComponentManager.mainGradientButton(
                      text: AppStrings.registerAsStudentText,
                      navigate: const LoginScreen(),
                      context: context),
                ),
              ]),
        ),
      ),
    ));
  }
}
