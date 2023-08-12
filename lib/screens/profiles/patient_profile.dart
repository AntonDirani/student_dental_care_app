import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:student_care_app/resources/assets_manager.dart';
import 'package:student_care_app/resources/components_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({super.key});

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

TextEditingController? _nameController;

class _PatientProfileState extends State<PatientProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 10.h,
                child: Image.asset(ImageAssetsManager.profileImage),
              ),
              SizedBox(
                height: 20,
              ),
              ComponentManager.myTextFieldNoSuffix(label: 'الاسم'),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: TextFormField(
                    onChanged: (_) => setState(() {
                      // _nameSubmitted = true;
                    }),
                    controller: _nameController,
                    decoration: InputDecoration(
                      errorStyle: StylesManager.regular14(),
                      /* errorText: _passwordSubmitted
                          ? ValidationManager.validatePassword(
                          _passwordController.value.text)
                          : null,*/
                      /*suffixIconConstraints: const BoxConstraints(
                          maxWidth: 35, maxHeight: 20),*/
                      /*prefixIcon: IconButton(
                        icon: _isPasswordHidden
                            ? const Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: Colors.grey,
                              ),
                        onPressed: () => setState(
                            () => _isPasswordHidden = !_isPasswordHidden),
                      ),*/ /*
                      suffixIcon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                        child: Image.asset(ImageAssetsManager.passwordIcon),
                      ),*/
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorManager.lightGrey),
                          borderRadius: BorderRadius.circular(AppSize.s3_5)),
                      label: Align(
                        alignment: Alignment.centerRight,
                        child: Text(AppStrings.passwordText,
                            style: StylesManager.medium16()),
                      ),
                      filled: true,
                    ),
                    textInputAction: TextInputAction.done,
                    /*obscureText: _isPasswordHidden,*/
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
