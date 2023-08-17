// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:student_care_app/controllers/login_controller.dart';
import 'package:student_care_app/resources/validation_manager.dart';
import 'package:student_care_app/resources/components_manager.dart';
import 'package:student_care_app/home_screen.dart';
import 'package:student_care_app/resources/values_manager.dart';
import 'package:student_care_app/screens/home_screen_student.dart';
import 'package:student_care_app/screens/login_and_register/signup_choose_role.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _emailSubmitted = false;
  bool _passwordSubmitted = false;
  bool _success = false;
  bool _isStudent = false;
  bool _isLoading = false;
  bool _isPasswordHidden = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoginController>(context, listen: false);

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
                                _emailSubmitted = true;
                              }),
                          errorText: _emailSubmitted
                              ? ValidationManager.validateEmail(
                                  _emailController.value.text)
                              : null,
                          controller: _emailController,
                          label: AppStrings.emailText,
                          suffixIcon: ImageAssetsManager.emailIcon),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: TextFormField(
                            onChanged: (_) => setState(() {
                              _passwordSubmitted = true;
                            }),
                            controller: _passwordController,
                            decoration: InputDecoration(
                              errorStyle: StylesManager.regular14(),
                              errorText: _passwordSubmitted
                                  ? ValidationManager.validatePassword(
                                      _passwordController.value.text)
                                  : null,
                              suffixIconConstraints: const BoxConstraints(
                                  maxWidth: 35, maxHeight: 20),
                              prefixIcon: IconButton(
                                icon: _isPasswordHidden
                                    ? const Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                onPressed: () => setState(() =>
                                    _isPasswordHidden = !_isPasswordHidden),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: Image.asset(
                                    ImageAssetsManager.passwordIcon),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorManager.lightGrey),
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s3_5)),
                              label: Align(
                                alignment: Alignment.centerRight,
                                child: Text(AppStrings.passwordText,
                                    style: StylesManager.medium16()),
                              ),
                              filled: true,
                            ),
                            textInputAction: TextInputAction.done,
                            obscureText: _isPasswordHidden,
                          )),
                      _isLoading
                          ? const Center(
                              child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: CircularProgressIndicator(),
                            ))
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: ComponentManager.mainGradientButton(
                                onPressed: ValidationManager.validateEmail(
                                                _emailController.value.text) ==
                                            null &&
                                        ValidationManager.validatePassword(
                                                _passwordController
                                                    .value.text) ==
                                            null
                                    ? () async {
                                        setState(() {
                                          _isLoading = true;
                                        });

                                        _success = await provider.logIn(
                                            _emailController.value.text,
                                            _passwordController.value.text);
                                        _isStudent = await provider.isStudent();
                                        print(_success.toString());
                                        if (_success == true) {
                                          _isLoading = false;
                                          if (!mounted) return;
                                          if (_isStudent) {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreenStudent()),
                                            );
                                          } else {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen()),
                                            );
                                          }
                                        } else {
                                          Future.delayed(
                                              const Duration(seconds: 4), () {
                                            // <-- Delay here
                                            setState(() {
                                              _isLoading =
                                                  false; // <-- Code run after delay
                                            });
                                            AlertDialog alert = AlertDialog(
                                              title: Text(
                                                "!انتباه",
                                                style:
                                                    StylesManager.bold18Black(),
                                                textAlign: TextAlign.right,
                                              ),
                                              content: Text(
                                                "عذرا حدث خطأ ما, يرجى إعادة المحاولة",
                                                style: StylesManager
                                                    .medium18Grey(),
                                                textAlign: TextAlign.right,
                                              ),
                                              actions: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: TextButton(
                                                    child: Text(
                                                      "رجوع",
                                                      style: StylesManager
                                                          .bold16(),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );

                                            // show the dialog
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return alert;
                                              },
                                            );
                                          });
                                        }
                                      }
                                    : null,
                                text: AppStrings.logInText,
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    AppStrings.registerNowText,
                                    style: StylesManager.semiBold18Primary(),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushReplacement(
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

/*
  void _submit(Future<void> func) {
    func;
}
*/
}
