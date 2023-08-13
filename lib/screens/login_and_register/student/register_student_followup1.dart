// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_care_app/controllers/student_controller.dart';
import 'package:student_care_app/models/university_model.dart';
import 'package:student_care_app/models/year_model.dart';
import 'package:student_care_app/resources/color_manager.dart';
import 'package:student_care_app/resources/components_manager.dart';
import 'package:student_care_app/resources/values_manager.dart';
import 'package:student_care_app/screens/login_and_register/student/register_student_reply.dart';

import '../../../controllers/university_controller.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';

class StudentRegisterFirstFollowupScreen extends StatefulWidget {
  const StudentRegisterFirstFollowupScreen({super.key});

  @override
  State<StudentRegisterFirstFollowupScreen> createState() =>
      _StudentRegisterFirstFollowupScreenState();
}

List<University> _dropDownUnis = [];
List<Year> dropDownList2 = [
  Year(yearId: 4, yearName: 'السنة الرابعة'),
  Year(yearId: 5, yearName: 'السنة الخامسة')
];

class _StudentRegisterFirstFollowupScreenState
    extends State<StudentRegisterFirstFollowupScreen> {
  File? _profileImage;
  File? _idImage;
  bool _isChecked = false;
  bool _isLoading = false;
  @override
  void initState() {
    _dropDownUnis =
        Provider.of<UniveristyController>(context, listen: false).unis;
    super.initState();
  }

  Future pickIdImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        _idImage = imageTemporary;
        _isUploaded2 = true;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future pickProfileImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        _profileImage = imageTemporary;
        _isUploaded1 = true;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  bool _success = false;
  University? _value1;
  Year? _value2;
  bool _isUploaded1 = false;
  bool _isUploaded2 = false;
  int? _dropDownValue1;
  int? _dropDownValue2;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<StudentController>(context, listen: false);

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
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 4, 0),
                      child: GestureDetector(
                        onTap: pickIdImage,
                        child: Container(
                          height: AppSize.s20,
                          decoration: BoxDecoration(
                              color: ColorManager.lightGrey,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(AppSize.s4))),
                          child: _isUploaded2
                              ? _doneMethod(
                                  image: ImageAssetsManager.checkImage,
                                  text: AppStrings.doneSelectText)
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 12, 0, 0),
                                        child: Image.asset(
                                            ImageAssetsManager.uploadImage),
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
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 8, 0, 0),
                      child: GestureDetector(
                        onTap: pickProfileImage,
                        child: Container(
                          height: AppSize.s20,
                          decoration: BoxDecoration(
                              color: ColorManager.lightGrey,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(AppSize.s4))),
                          child: _isUploaded1
                              ? _doneMethod(
                                  image: ImageAssetsManager.checkImage,
                                  text: AppStrings.doneSelectText)
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 12, 0, 0),
                                        child: Image.asset(
                                            ImageAssetsManager.userImage),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      child: Text(
                                        AppStrings
                                            .clickToUploadProfilePhotoText,
                                        style: StylesManager.medium16(),
                                        textAlign: TextAlign.center,
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
              ComponentManager.myDropDown(
                  value: _value1,
                  dropDownList: _dropDownUnis,
                  dropDownValue: _dropDownValue1,
                  hint: 'اختر اسم جامعتك..',
                  onChanged: (University? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      _dropDownValue1 = value?.uniId;
                      _value1 = value;
                      print(value);
                    });
                  }),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    height: AppSize.s7_5,
                    decoration: ShapeDecoration(
                      color: ColorManager.lightGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppSize.s2_5)),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: DropdownButton(
                          value: _value2,
                          hint: Text(
                            'ادخل عامك الدراسة..',
                            style: StylesManager.regular16Grey(),
                          ),
                          style: StylesManager.medium16Black(),
                          underline: const SizedBox(),
                          dropdownColor: ColorManager.lightGrey,
                          iconEnabledColor: ColorManager.costumeBlack,
                          isExpanded: true,
                          items: dropDownList2
                              .map<DropdownMenuItem<Year>>((Year year) {
                            return DropdownMenuItem<Year>(
                              value: year,
                              child: Text(year.yearName.toString()),
                            );
                          }).toList(),
                          onChanged: (Year? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              _dropDownValue2 = value?.yearId;
                              _value2 = value;
                              print(value);
                            });
                          }),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: RichText(
                          textDirection: TextDirection.rtl,
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'إستخدامك ل',
                                style: StylesManager.light16()),
                            TextSpan(
                                text: '  Student Care ',
                                style: StylesManager.bold16()),
                            TextSpan(
                                text: 'يعني موافقتك على ',
                                style: StylesManager.light16()),
                            TextSpan(
                                text: 'الشروط و الأحكام ',
                                style: StylesManager.semiBold16Underlined())
                          ])),
                    ),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: Checkbox(
                            value: _isChecked,
                            activeColor: ColorManager.primary,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                          ),
                        )),
                  ],
                ),
              ),
              _isLoading
                  ? const Center(
                      child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: CircularProgressIndicator(),
                    ))
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: ComponentManager.mainGradientButton(
                          onPressed: _isUploaded1 &&
                                  _isUploaded2 &&
                                  _dropDownValue1 != null &&
                                  _dropDownValue2 != null &&
                                  _isChecked
                              ? () async {
                                  setState(() {});
                                  _isLoading = true;
                                  _success = await provider.studentDataEntry(
                                      uniId: _dropDownValue1!,
                                      idImage: _idImage!,
                                      profileImage: _profileImage!,
                                      studyYear: _dropDownValue2!);

                                  print(_success.toString());
                                  if (_success == true) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterStudentReply()),
                                    );
                                  } else {
                                    Future.delayed(const Duration(seconds: 4),
                                        () {
                                      // <-- Delay here
                                      setState(() {
                                        // <-- Code run after delay
                                        _isLoading = false;
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
                          icon: Icons.arrow_back_ios),
                    ),
            ],
          ),
        ),
      ),
    ))));
  }

  Column _doneMethod({
    String? image,
    String? text,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: Image.asset(image!),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            text!,
            style: StylesManager.medium16(),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
