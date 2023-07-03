import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_care_app/resources/components_manager.dart';
import 'package:student_care_app/resources/values_manager.dart';
import 'package:student_care_app/screens/login_and_register/signup_choose_role.dart';
import '../../resources/assets_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight:
                      MediaQuery.of(context).size.height - AppPadding.p24),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p33),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: SvgPicture.asset(
                          ImageAssetsManager.loginVector,
                        ),
                      ),
                    ),
                    Text(
                      AppStrings.logInText,
                      style: StylesManager.medium20(),
                    ),
                    Text(
                      AppStrings.logInSecondaryText,
                      style: StylesManager.light18Black(),
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
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  AppStrings.registerNowText,
                                  style: StylesManager.semibold18Primary(),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpChooseScreen()),
                                );
                              },
                            ),
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
              ))),
    ));
  }
}
