import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:student_care_app/resources/components_manager.dart';
import 'package:student_care_app/resources/values_manager.dart';
import 'package:student_care_app/screens/signup_choose_role.dart';
import '../resources/assets_manager.dart';
import '../resources/string_manager.dart';
import '../resources/styles_manager.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth:
                        MediaQuery.of(context).size.width - AppPadding.p35,
                    minHeight:
                        MediaQuery.of(context).size.height - AppPadding.p35,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: SvgPicture.asset(
                            ImageAssetsManager.loginVector,
                          ),
                        ),
                        Text(
                          AppStrings.logInText,
                          style: StylesManager.medium23(),
                        ),
                        Text(
                          AppStrings.logInSecondaryText,
                          style: StylesManager.light20(),
                        ),
                        ComponentManager.myTextField(
                            label: AppStrings.emailText,
                            suffixIcon: ImageAssetsManager.emailIcon),
                        ComponentManager.myTextField(
                            label: AppStrings.passwordText,
                            suffixIcon: ImageAssetsManager.passwordIcon),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: ComponentManager.mainGradientButton(
                              text: AppStrings.logInText, context: context),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpChooseScreen()),
                                      );
                                    },
                                    child: Text(
                                      AppStrings.registerNowText,
                                      style: StylesManager.bold18Primary(),
                                    )),
                                Text(
                                  AppStrings.youDontHaveAnAccountText,
                                  style: StylesManager.light18(),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
