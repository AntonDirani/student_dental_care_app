import 'package:flutter/material.dart';

import 'font_manager.dart';

class TextStyles {
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
}
