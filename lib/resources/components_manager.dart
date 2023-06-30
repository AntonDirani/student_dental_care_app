import 'package:flutter/material.dart';
import 'package:student_care_app/resources/styles_manager.dart';
import 'package:student_care_app/resources/values_manager.dart';
import 'color_manager.dart';
import 'font_manager.dart';

class ComponentManager {
  static Container mainGradientButton(
      {required String text,
      Widget? navigate,
      required BuildContext context,
      IconData? icon}) {
    return Container(
      height: AppSize.s8,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s3_5),
          gradient: LinearGradient(colors: [
            ColorManager.darkPrimary,
            ColorManager.primary,
            ColorManager.lightPrimary
          ])),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => navigate!),
          );
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
            ),
            Text(
              text,
              style: StylesManager.getTextStyle(
                fontSize: 22,
                fontWeight: FontWeightManager.medium,
                color: ColorManager.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Container secondaryGradientButton(
      {required String text,
      Widget? navigate,
      required BuildContext context,
      IconData? icon}) {
    return Container(
      height: AppSize.s8,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s3_5),
          gradient: LinearGradient(colors: [
            ColorManager.darkSecondary,
            ColorManager.lightSecondary
          ])),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => navigate!),
          );
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
            ),
            Text(
              text,
              style: StylesManager.getTextStyle(
                fontSize: 22,
                fontWeight: FontWeightManager.medium,
                color: ColorManager.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Container outlinedButton(
      {required String text,
      Widget? navigate,
      required BuildContext context,
      IconData? icon}) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: AppSize.s8,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => navigate!),
          );
        },
        style: ElevatedButton.styleFrom(
            side: BorderSide(width: 1.5, color: ColorManager.costumeBlack),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s3_5)),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
            ),
            Text(
              text,
              style: StylesManager.getTextStyle(
                fontSize: 22,
                fontWeight: FontWeightManager.medium,
                color: ColorManager.costumeBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Padding myTextField(
      {required String label,
      String? suffixIcon,
      TextEditingController? controller}) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            suffixIconConstraints: BoxConstraints(maxWidth: 35),
            suffixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: Image.asset(
                suffixIcon!,
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorManager.lightGrey),
                borderRadius: BorderRadius.circular(AppSize.s3_5)),
            label: Align(
              alignment: Alignment.topRight,
              child: Text(label, style: StylesManager.medium18()),
            ),
            filled: true,
          ),
        ));
  }
}
