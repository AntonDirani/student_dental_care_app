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

  static TextStyle medium23(){

    return StylesManager.getTextStyle(
      fontSize: FontSize.s23,
      fontWeight: FontWeightManager.medium,
      color: ColorManager.costumeBlack,
      height: 1.8,
    );
  }

}
