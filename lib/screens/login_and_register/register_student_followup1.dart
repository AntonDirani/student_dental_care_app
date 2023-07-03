import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_care_app/resources/color_manager.dart';
import 'package:student_care_app/resources/components_manager.dart';
import 'package:student_care_app/resources/values_manager.dart';
import 'package:student_care_app/screens/login_and_register/signup_choose_role.dart';
import '../../resources/assets_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';

class StudentRegisterFirstFollowupScreen extends StatefulWidget {
  const StudentRegisterFirstFollowupScreen({super.key});

  @override
  State<StudentRegisterFirstFollowupScreen> createState() =>
      _StudentRegisterFirstFollowupScreenState();
}

class _StudentRegisterFirstFollowupScreenState
    extends State<StudentRegisterFirstFollowupScreen> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('d');
    }
  }

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: SvgPicture.asset(
                    ImageAssetsManager.idVector,
                  ),
                ),
              ),
              Text(
                AppStrings.verifyText,
                style: StylesManager.medium20(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    height: AppSize.s20,
                    decoration: BoxDecoration(
                        color: ColorManager.lightGrey,
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppSize.s4))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                            child: Image.asset(ImageAssetsManager.uploadImage),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Text(
                            AppStrings.clickToUploadText,
                            style: StylesManager.medium16(),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ))));
  }
}
