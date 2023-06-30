import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:student_care_app/screens/login.dart';
import 'package:student_care_app/screens/signup_choose_role.dart';
import '../resources/assets_manager.dart';
import '../resources/components_manager.dart';
import '../resources/string_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class DoYouHaveAnAccount extends StatelessWidget {
  const DoYouHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Row(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p35),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                      child: SvgPicture.asset(
                        ImageAssetsManager.doYouHaveAnAccountVector,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Text(AppStrings.doYouHaveAnAccountText,
                        style: StylesManager.medium23(),
                        textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                    child: ComponentManager.mainGradientButton(
                        text: AppStrings.logInText,
                        navigate: const LoginScreen(),
                        context: context),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 1.h, 0, 4.h),
                    child: ComponentManager.outlinedButton(
                        text: AppStrings.signUpText,
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
