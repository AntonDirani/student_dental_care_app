// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:student_care_app/resources/color_manager.dart';
import 'package:student_care_app/resources/styles_manager.dart';

import '../../home_screen.dart';
import '../../models/result_model.dart';

class DiagnoseResult extends StatelessWidget {
  Result r;
  DiagnoseResult({
    Key? key,
    required this.r,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 280,
        child: Center(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        ColorManager.lightPrimary.withOpacity(0.95),
                        ColorManager.darkSecondary.withOpacity(0.95),
                      ]),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    width: double.infinity,
                    height: 210,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 70, left: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                r.patientName!,
                                style: StylesManager.medium18Grey()
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                'الاسم',
                                style: StylesManager.medium18Grey().copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Divider(
                            color: Colors.white,
                            thickness: 1.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 70, left: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                r.treatmentName!,
                                style: StylesManager.medium18Grey()
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                'الحالة',
                                style: StylesManager.medium18Grey().copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 200,
                right: 2,
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    // color: ColorManager.darkSecondary.withOpacity(0.7),
                    color: Colors.white,
                    border:
                        Border.all(color: ColorManager.lightPrimary, width: 4),
                    borderRadius: BorderRadius.circular(48),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        'التشخيص',
                        style: StylesManager.medium16().copyWith(
                          color: ColorManager.lightPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: (MediaQuery.sizeOf(context).width - 100) * 0.5,
                top: 230,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ));
                      },
                      child: Container(
                        width: 100,
                        height: 45,
                        decoration: BoxDecoration(
                          color: ColorManager.darkSecondary.withOpacity(1),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'عودة',
                            style: StylesManager.medium16().copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
