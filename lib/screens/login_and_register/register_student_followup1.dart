import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_care_app/resources/color_manager.dart';
import 'package:student_care_app/resources/components_manager.dart';
import 'package:student_care_app/resources/values_manager.dart';

import '../../resources/assets_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';
import 'do_you_have_an_account.dart';

class StudentRegisterFirstFollowupScreen extends StatefulWidget {
  const StudentRegisterFirstFollowupScreen({super.key});

  @override
  State<StudentRegisterFirstFollowupScreen> createState() =>
      _StudentRegisterFirstFollowupScreenState();
}

List<String> dropDownList1 = <String>[
  'اختر الجامعة الخاصة بك...',
  'Two',
  'Three',
  'Four'
];
List<String> dropDownList2 = <String>[
  'ادخل عامك الدراسي..',
  'Two',
  'Three',
  'Four'
];
List<String> dropDownList3 = <String>[
  'ادخل الفصل الحالي...',
  'Two',
  'Three',
  'Four'
];

class _StudentRegisterFirstFollowupScreenState
    extends State<StudentRegisterFirstFollowupScreen> {
  File? _profileImage;
  File? _idImage;
  bool? _isChecked = false;

  Future pickIdImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        _idImage = imageTemporary;
        _isUploaded2 = true;
      });
    } on PlatformException catch (e) {}
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
    } on PlatformException catch (e) {}
  }

  bool _isUploaded1 = false;
  bool _isUploaded2 = false;
  String dropDownValue1 = dropDownList1.first;
  String dropDownValue2 = dropDownList2.first;
  String dropDownValue3 = dropDownList3.first;
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
                  dropDownList: dropDownList1,
                  dropDownValue: dropDownValue1,
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropDownValue1 = value!;
                      print(value);
                    });
                  }),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 4, 0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          height: AppSize.s7_5,
                          decoration: ShapeDecoration(
                            color: ColorManager.lightGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(AppSize.s2_5)),
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: DropdownButton(
                              style: StylesManager.medium16(),
                              value: dropDownValue3,
                              underline: SizedBox(),
                              dropdownColor: ColorManager.lightGrey,
                              iconEnabledColor: ColorManager.costumeBlack,
                              isExpanded: true,
                              items: dropDownList3
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      value,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropDownValue3 = value!;
                                  print(value);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 10, 0, 0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          height: AppSize.s7_5,
                          decoration: ShapeDecoration(
                            color: ColorManager.lightGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(AppSize.s2_5)),
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: DropdownButton(
                              style: StylesManager.medium16(),
                              value: dropDownValue2,
                              underline: SizedBox(),
                              dropdownColor: ColorManager.lightGrey,
                              iconEnabledColor: ColorManager.costumeBlack,
                              isExpanded: true,
                              items: dropDownList2
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      value,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropDownValue2 = value!;
                                  print(value);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                                style: StylesManager.semibold16Underlined())
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
                                _isChecked = value;
                              });
                            },
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: ComponentManager.mainGradientButton(
                    onPressed: () {},
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
