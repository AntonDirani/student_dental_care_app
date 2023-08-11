// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:student_care_app/controllers/location_controller.dart';
import 'package:student_care_app/controllers/patient_controller.dart';

import 'package:intl/intl.dart';
import '../../../models/location_model.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/components_manager.dart';
import '../../../home_screen.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';

class PatientRegisterScreenFollowUp extends StatefulWidget {
  PatientRegisterScreenFollowUp({super.key});
  @override
  State<PatientRegisterScreenFollowUp> createState() =>
      _PatientRegisterScreenFollowUpState();
}

List<Governorate> _dropDownLocations = [];

class _PatientRegisterScreenFollowUpState
    extends State<PatientRegisterScreenFollowUp> {
  @override
  void initState() {
    _dropDownLocations =
        Provider.of<LocationController>(context, listen: false).locations;

    super.initState();
  }

  final _dateController = TextEditingController();
  bool _success = false;
  bool _isLoading = false;
  bool _isDateSelected = false;
  Governorate? _value1;
  int? _dropDownValue1Location;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PatientController>(context, listen: false);
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: SvgPicture.asset(
                          ImageAssetsManager.informationVector,
                        ),
                      ),
                    ),
                    Text(
                      AppStrings.oneLastInfoText,
                      style: StylesManager.medium22(),
                    ),
                    Text(
                      AppStrings.weAreCloseToFinishText,
                      style: StylesManager.light18Black(),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Directionality(
                        textDirection: ui.TextDirection.rtl,
                        child: Container(
                          height: AppSize.s8,
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
                                value: _value1,
                                hint: Text(
                                  'ادخل المحافظة الخاصة بك..',
                                  style: StylesManager.regular16Grey(),
                                ),
                                style: StylesManager.medium16Black(),
                                underline: const SizedBox(),
                                dropdownColor: ColorManager.lightGrey,
                                iconEnabledColor: ColorManager.costumeBlack,
                                isExpanded: true,
                                items: _dropDownLocations
                                    .map<DropdownMenuItem<Governorate>>(
                                        (Governorate location) {
                                  return DropdownMenuItem<Governorate>(
                                    value: location,
                                    child: Text(
                                        location.governorateName.toString()),
                                  );
                                }).toList(),
                                onChanged: (Governorate? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    _dropDownValue1Location =
                                        value?.governorateId;
                                    _value1 = value;
                                    print(value);
                                  });
                                }),
                          ),
                        ),
                      ),
                    ),
                    ComponentManager.myTextField(
                      suffixIcon: ImageAssetsManager.calendarImage,
                      controller: _dateController,
                      onChanged: (value) {},
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2008),
                            firstDate: DateTime(1940),
                            lastDate: DateTime(2008));
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            _dateController.text = formattedDate;
                            _isDateSelected = true;
                            print(_dateController.value.text);
                          });
                        }
                      },
                      label: '..الرجاء إدخال تاريخ الولادة الخاصة بك',
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
                              onPressed: _isDateSelected &&
                                      _dropDownValue1Location != null
                                  ? () async {
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      _success =
                                          await provider.patientDataEntry(
                                        locationId: _dropDownValue1Location!,
                                        dateOfBirth: _dateController.text!,
                                      );
                                      print(_success.toString());
                                      if (_success == true) {
                                        _isLoading = false;
                                        if (!mounted) return;
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()),
                                        );
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
                                              style:
                                                  StylesManager.medium18Grey(),
                                              textAlign: TextAlign.right,
                                            ),
                                            actions: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: TextButton(
                                                  child: Text(
                                                    "رجوع",
                                                    style:
                                                        StylesManager.bold16(),
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
                  ],
                ),
              ))),
    ));
  }
}
