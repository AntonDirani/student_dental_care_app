import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_care_app/screens/login_and_register/register_student_followup1.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/components_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class StudentRegisterScreen extends StatefulWidget {
  const StudentRegisterScreen({super.key});

  @override
  State<StudentRegisterScreen> createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
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
                      ImageAssetsManager.studentRegisterVector,
                      alignment: Alignment.topRight,
                    ),
                  ),
                ),
                Text(
                  AppStrings.welcomeStudentText,
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
                          label: AppStrings.enterYourSecondNameText,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                        child: ComponentManager.myTextFieldNoSuffix(
                          label: AppStrings.enterYourFirstNameText,
                        ),
                      ),
                    ),
                  ],
                ),
                ComponentManager.myTextField(
                    inputType: TextInputType.emailAddress,
                    label: AppStrings.emailText,
                    suffixIcon: ImageAssetsManager.emailIcon),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      height: AppSize.s7_5,
                      child: TextFormField(
                        decoration: InputDecoration(
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
                        decoration: InputDecoration(
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
                  label: AppStrings.enterYourPhoneText,
                  suffixIcon: ImageAssetsManager.phoneIcon,
                  inputType: TextInputType.emailAddress,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: ComponentManager.mainGradientButton(
                    text: AppStrings.continueText,
                    icon: Icons.arrow_back_ios,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                StudentRegisterFirstFollowupScreen()),
                      );
                    },
                  ),
                ),
              ]),
        ),
      ),
    )));
  }
}
