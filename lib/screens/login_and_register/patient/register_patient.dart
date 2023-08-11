// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:student_care_app/controllers/register_controller.dart';
import 'package:student_care_app/screens/login_and_register/patient/register_patient_followup.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/components_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/validation_manager.dart';
import '../../../resources/values_manager.dart';

class PatientRegisterScreen extends StatefulWidget {
  const PatientRegisterScreen({super.key});

  @override
  State<PatientRegisterScreen> createState() => _PatientRegisterScreenState();
}

class _PatientRegisterScreenState extends State<PatientRegisterScreen> {
  bool isPasswordVisible = true;
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();
  final _phoneController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _secondNameController = TextEditingController();
  bool _emailSubmitted = false;
  bool _password1Submitted = false;
  bool _password2Submitted = false;
  bool _firstNameSubmitted = false;
  bool _secondNameSubmitted = false;
  bool _phoneSubmitted = false;
  bool _success = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RegisterController>(context, listen: false);

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - AppPadding.p24),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p33),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: SvgPicture.asset(
                      ImageAssetsManager.patientRegisterVector,
                      alignment: Alignment.topRight,
                    ),
                  ),
                ),
                Text(
                  AppStrings.welcomePatientText,
                  style: StylesManager.medium20(),
                ),
                Text(
                  AppStrings.enterInfoText,
                  style: StylesManager.light18Black(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                        child: ComponentManager.myTextFieldNoSuffix(
                          onChanged: (_) => setState(() {
                            _secondNameSubmitted = true;
                          }),
                          errorText: _secondNameSubmitted
                              ? ValidationManager.validateName(
                                  _secondNameController.value.text)
                              : null,
                          controller: _secondNameController,
                          label: AppStrings.enterYourSecondNameText,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                        child: ComponentManager.myTextFieldNoSuffix(
                          onChanged: (_) => setState(() {
                            _firstNameSubmitted = true;
                          }),
                          errorText: _firstNameSubmitted
                              ? ValidationManager.validateName(
                                  _firstNameController.value.text)
                              : null,
                          controller: _firstNameController,
                          label: AppStrings.enterYourFirstNameText,
                        ),
                      ),
                    ),
                  ],
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
                    inputType: TextInputType.emailAddress,
                    label: AppStrings.emailText,
                    suffixIcon: ImageAssetsManager.emailIcon),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      height: AppSize.s7_5,
                      child: TextFormField(
                        onChanged: (_) => setState(() {
                          _password1Submitted = true;
                        }),
                        controller: _password1Controller,
                        decoration: InputDecoration(
                          errorStyle: StylesManager.regular14(),
                          errorText: _password1Submitted
                              ? ValidationManager.validatePassword(
                                  _password1Controller.value.text)
                              : null,
                          suffixIconConstraints:
                              const BoxConstraints(maxWidth: 35, maxHeight: 20),
                          prefixIcon: IconButton(
                            icon: isPasswordVisible
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.grey,
                                  ),
                            onPressed: () => setState(
                                () => isPasswordVisible = !isPasswordVisible),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                            child: Image.asset(ImageAssetsManager.passwordIcon),
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
                        obscureText: isPasswordVisible,
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      height: AppSize.s7_5,
                      child: TextFormField(
                        onChanged: (_) => setState(() {
                          _password2Submitted = true;
                        }),
                        controller: _password2Controller,
                        decoration: InputDecoration(
                          errorStyle: StylesManager.regular14(),
                          errorText: _password2Submitted
                              ? ValidationManager.validatePasswordMatch(
                                  _password2Controller.value.text,
                                  _password1Controller.value.text)
                              : null,
                          suffixIconConstraints:
                              const BoxConstraints(maxWidth: 35, maxHeight: 20),
                          prefixIcon: IconButton(
                            icon: isPasswordVisible
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.grey,
                                  ),
                            onPressed: () => setState(
                                () => isPasswordVisible = !isPasswordVisible),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                            child: Image.asset(ImageAssetsManager.passwordIcon),
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
                        obscureText: isPasswordVisible,
                      ),
                    )),
                ComponentManager.myTextField(
                  onChanged: (_) => setState(() {
                    _phoneSubmitted = true;
                  }),
                  errorText: _phoneSubmitted
                      ? ValidationManager.validateMobile(
                          _phoneController.value.text)
                      : null,
                  controller: _phoneController,
                  label: AppStrings.enterYourPhoneText,
                  suffixIcon: ImageAssetsManager.phoneIcon,
                  inputType: TextInputType.phone,
                ),
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
                                          _password1Controller.value.text) ==
                                      null &&
                                  ValidationManager.validateName(
                                          _firstNameController.value.text) ==
                                      null &&
                                  ValidationManager.validateName(
                                          _secondNameController.value.text) ==
                                      null &&
                                  ValidationManager.validateMobile(
                                          _phoneController.value.text) ==
                                      null
                              ? () async {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  _success = await provider.register(
                                    pass: _password1Controller.value.text,
                                    email: _emailController.value.text,
                                    firstName: _firstNameController.value.text,
                                    secondName:
                                        _secondNameController.value.text,
                                    phoneNumber: _phoneController.value.text,
                                    role: 'Patient',
                                  );
                                  print(_success.toString());
                                  if (_success == true) {
                                    _isLoading = false;
                                    if (!mounted) return;
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PatientRegisterScreenFollowUp()),
                                    );
                                  } else {
                                    Future.delayed(const Duration(seconds: 4),
                                        () {
                                      // <-- Delay here
                                      setState(() {
                                        _isLoading =
                                            false; // <-- Code run after delay
                                      });
                                      AlertDialog alert = AlertDialog(
                                        title: Text(
                                          "!انتباه",
                                          style: StylesManager.bold18Black(),
                                          textAlign: TextAlign.right,
                                        ),
                                        content: Text(
                                          "عذرا حدث خطأ ما, يرجى إعادة المحاولة",
                                          style: StylesManager.medium18Grey(),
                                          textAlign: TextAlign.right,
                                        ),
                                        actions: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: TextButton(
                                              child: Text(
                                                "رجوع",
                                                style: StylesManager.bold16(),
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
                          text: AppStrings.continueText,
                        ),
                      ),
              ]),
        ),
      ),
    )));
  }
}
