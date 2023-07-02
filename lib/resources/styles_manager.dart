import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';

class StylesManager {
  static TextStyle getTextStyle(
      {required double fontSize,
      required FontWeight fontWeight,
      required Color color,
      double? height}) {
    return TextStyle(
        height: height,
        fontSize: fontSize,
        fontFamily: FontConstants.fontFamily,
        color: color,
        fontWeight: fontWeight);
  }

  static TextStyle medium20() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s20,
      fontWeight: FontWeightManager.medium,
      color: ColorManager.costumeBlack,
      height: 1.8,
    );
  }

  static TextStyle light20() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s20,
      fontWeight: FontWeightManager.light,
      color: ColorManager.costumeBlack,
    );
  }

  static TextStyle medium16() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s16,
      fontWeight: FontWeightManager.medium,
      color: ColorManager.grey,
    );
  }

  static TextStyle medium18Black() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s18,
      fontWeight: FontWeightManager.medium,
      color: ColorManager.costumeBlack,
    );
  }

  static TextStyle medium18White() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s18,
      fontWeight: FontWeightManager.medium,
      color: ColorManager.white,
    );
  }

  static TextStyle light18() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s18,
      fontWeight: FontWeightManager.light,
      color: ColorManager.costumeBlack,
    );
  }

  static TextStyle semibold18Primary() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s18,
      fontWeight: FontWeightManager.semiBold,
      color: ColorManager.primary,
    );
  }
}
