import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:student_care_app/resources/styles_manager.dart';
import 'package:student_care_app/resources/values_manager.dart';

import 'color_manager.dart';
import 'font_manager.dart';

class ComponentManager {
  static Container mainGradientButton(
      {required String text, Function? onPressed}) {
    return Container(
      height: AppSize.s7_5,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s20),
          gradient: LinearGradient(colors: [
            ColorManager.darkPrimary,
            ColorManager.primary,
            ColorManager.lightPrimary
          ])),
      child: ElevatedButton(
        onPressed: () {
          onPressed;
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        child: Text(
          text,
          style: TextStyles.getTextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeightManager.medium,
            color: ColorManager.white,
          ),
        ),
      ),
    );
  }
}
