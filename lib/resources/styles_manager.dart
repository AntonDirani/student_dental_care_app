import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';

class StylesManager {
  static TextStyle getTextStyle(
      {required double fontSize,
      required FontWeight fontWeight,
      required Color color,
      double? height,
      TextDecoration? tDec}) {
    return TextStyle(
        decoration: tDec,
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

  static TextStyle medium19() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s19,
      fontWeight: FontWeightManager.medium,
      color: ColorManager.costumeBlack,
    );
  }

  static TextStyle medium22() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s22,
      fontWeight: FontWeightManager.medium,
      color: ColorManager.costumeBlack,
      height: 1.8,
    );
  }

  static TextStyle light18Black() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s18,
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

  static TextStyle bold16Red() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s16,
      fontWeight: FontWeightManager.bold,
      color: ColorManager.red,
    );
  }

  static TextStyle medium18White() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s18,
      fontWeight: FontWeightManager.medium,
      color: ColorManager.white,
    );
  }

  static TextStyle medium16White() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s16,
      fontWeight: FontWeightManager.medium,
      color: ColorManager.white,
    );
  }

  static TextStyle medium16Black() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s16,
      fontWeight: FontWeightManager.medium,
      color: ColorManager.costumeBlack,
    );
  }

  static TextStyle medium17Black() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s17,
      fontWeight: FontWeightManager.medium,
      color: ColorManager.costumeBlack,
    );
  }

  static TextStyle semiBold17Black() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s17,
      fontWeight: FontWeightManager.semiBold,
      color: ColorManager.costumeBlack,
    );
  }

  static TextStyle bold18Black() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s18,
      fontWeight: FontWeightManager.bold,
      color: ColorManager.costumeBlack,
    );
  }

  static TextStyle bold20Black() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s20,
      fontWeight: FontWeightManager.bold,
      color: ColorManager.costumeBlack,
    );
  }

  static TextStyle regular13() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s13,
      fontWeight: FontWeightManager.regular,
      color: ColorManager.grey,
    );
  }

  static TextStyle regular14Black() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s15,
      fontWeight: FontWeightManager.regular,
      color: ColorManager.costumeBlack,
    );
  }

  static TextStyle regular16Black() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s16,
      fontWeight: FontWeightManager.regular,
      color: ColorManager.costumeBlack,
    );
  }

  static TextStyle regular18() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s18,
      fontWeight: FontWeightManager.regular,
      color: ColorManager.grey,
    );
  }

  static TextStyle bold16() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s16,
      fontWeight: FontWeightManager.medium,
      color: ColorManager.primary,
    );
  }

  static TextStyle bold17Black() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s17,
      fontWeight: FontWeightManager.bold,
      color: ColorManager.costumeBlack,
    );
  }

  static TextStyle medium18Black() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s18,
      fontWeight: FontWeightManager.medium,
      color: ColorManager.costumeBlack,
    );
  }

  static TextStyle semiBold18Primary() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s18,
      fontWeight: FontWeightManager.semiBold,
      color: ColorManager.primary,
    );
  }

  static TextStyle medium18Grey() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s18,
      fontWeight: FontWeightManager.medium,
      color: ColorManager.grey,
    );
  }

  static TextStyle regular14() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeightManager.regular,
      color: ColorManager.costumeBlack,
    );
  }

  static TextStyle regular14Grey() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeightManager.regular,
      color: ColorManager.grey,
    );
  }

  static TextStyle regular15Grey() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s15,
      fontWeight: FontWeightManager.regular,
      color: ColorManager.grey,
    );
  }

  static TextStyle semiBold16Primary() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s16,
      fontWeight: FontWeightManager.semiBold,
      color: ColorManager.primary,
    );
  }

  static TextStyle regular16Grey() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s16,
      fontWeight: FontWeightManager.regular,
      color: ColorManager.grey,
    );
  }

  static TextStyle regular16White() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s16,
      fontWeight: FontWeightManager.regular,
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

  static TextStyle light16() {
    return StylesManager.getTextStyle(
      fontSize: FontSize.s16,
      fontWeight: FontWeightManager.light,
      color: ColorManager.costumeBlack,
    );
  }

  static TextStyle semiBold16Underlined() {
    return StylesManager.getTextStyle(
        fontSize: FontSize.s16,
        fontWeight: FontWeightManager.semiBold,
        color: ColorManager.costumeBlack,
        tDec: TextDecoration.underline);
  }
}
