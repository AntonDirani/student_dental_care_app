import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_care_app/providers/validation_manager.dart';
import 'package:student_care_app/resources/components_manager.dart';
import 'package:student_care_app/resources/values_manager.dart';
import 'package:student_care_app/screens/login_and_register/signup_choose_role.dart';
import '../../resources/assets_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          onChanged: (_) => setState(() {
                                _submitted = true;
                              }),
                          errorText: _submitted
                              ? ValidationManager.validateMobile(
                                  _controller.value.text)
                              : null,
                          controller: _controller,
                          label: AppStrings.emailText,
                          suffixIcon: ImageAssetsManager.emailIcon),
                      ComponentManager.myTextField(
                          label: AppStrings.passwordText,
                          suffixIcon: ImageAssetsManager.passwordIcon),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: ComponentManager.mainGradientButton(
                          onPressed: () {
                            _controller.value.text.isNotEmpty ? _submit : null;
                          },
                          text: AppStrings.logInText,
                        ),
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
                ),
              ))),
    ));
  }

  void _submit() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpChooseScreen()),
    );
  }
}
