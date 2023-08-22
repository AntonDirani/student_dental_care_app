import 'package:flutter/material.dart';
import 'package:student_care_app/models/university_model.dart';
import 'package:student_care_app/resources/styles_manager.dart';

import 'package:student_care_app/resources/values_manager.dart';
import 'color_manager.dart';

class ComponentManager {
  static Container mainGradientButton(
      {required String text, VoidCallback? onPressed, IconData? icon}) {
    return Container(
      height: AppSize.s8,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s3_5),
        gradient: LinearGradient(
          colors: [
            ColorManager.darkPrimary,
            ColorManager.primary,
            ColorManager.lightPrimary
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s3_5),
            ),
            disabledBackgroundColor: ColorManager.grey,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: StylesManager.medium18White()),
            const SizedBox(width: 4),
            Icon(
              icon,
              color: ColorManager.white,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  static Container secondaryGradientButton(
      {required String text, VoidCallback? onPressed, IconData? icon}) {
    return Container(
      height: AppSize.s8,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s3_5),
        gradient: LinearGradient(
          colors: [
            ColorManager.darkSecondary,
            ColorManager.lightSecondary,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
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
            Text(text, style: StylesManager.medium18White()),
          ],
        ),
      ),
    );
  }

  static Container outlinedButton(
      {required String text, VoidCallback? onPressed, IconData? icon}) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: AppSize.s8,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
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
            Text(text, style: StylesManager.medium18Black()),
          ],
        ),
      ),
    );
  }

  static Padding myTextField(
      {bool readOnly = false,
      required String label,
      String? suffixIcon,
      TextEditingController? controller,
      Function(String)? onChanged,
      TextInputType? inputType,
      String? errorText,
      TextInputAction? action,
      void Function()? onTap}) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: TextFormField(
          textInputAction: action,
          onChanged: onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // validator: validatorFunction,
          keyboardType: inputType,
          readOnly: readOnly,
          controller: controller,
          onTap: onTap,
          decoration: InputDecoration(
            errorText: errorText,
            errorStyle: StylesManager.regular14(),
            prefixIconConstraints:
                const BoxConstraints(maxWidth: 35, maxHeight: 20),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 10, left: 5),
              child: Image.asset(
                suffixIcon!,
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorManager.lightGrey),
                borderRadius: BorderRadius.circular(AppSize.s3_5)),
            label: Align(
              alignment: Alignment.centerRight,
              child: Text(label, style: StylesManager.medium16()),
            ),
            filled: true,
          ),
        ));
  }

  static SizedBox descriptionTextField({
    required String label,
    TextEditingController? controller,
    Function(String)? onChanged,
    String? errorText,
  }) {
    return SizedBox(
      height: 140,
      child: Column(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                errorText: errorText,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.lightGrey),
                    borderRadius: BorderRadius.circular(AppSize.s3_5)),
                label: Align(
                  alignment: Alignment.center,
                  child: Text(label, style: StylesManager.medium16()),
                ),
                filled: true,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              expands: true,
            ),
          ),
        ],
      ),
    );
  }

  static Padding myTextFieldNoSuffix({
    required String label,
    TextEditingController? controller,
    Function(String)? onChanged,
    String? errorText,
    TextInputAction? action,
    TextInputType? type,
  }) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: SizedBox(
          height: AppSize.s7_5,
          child: TextFormField(
            textInputAction: action,
            onChanged: onChanged,
            keyboardType: type,
            textDirection: TextDirection.rtl,
            controller: controller,
            decoration: InputDecoration(
              errorText: errorText,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.lightGrey),
                  borderRadius: BorderRadius.circular(AppSize.s3_5)),
              label: Align(
                alignment: Alignment.center,
                child: Text(label, style: StylesManager.medium16()),
              ),
              filled: true,
            ),
          ),
        ));
  }

  static Padding myDropDown({
    University? value,
    String? hint,
    int? dropDownValue,
    List<University>? dropDownList,
    void Function(University?)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: AppSize.s7_5,
          decoration: ShapeDecoration(
            color: ColorManager.lightGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s2_5)),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: DropdownButton<University>(
                value: value,
                hint: Text(
                  hint!,
                  style: StylesManager.regular16Grey(),
                ),
                style: StylesManager.medium16Black(),
                underline: const SizedBox(),
                dropdownColor: ColorManager.lightGrey,
                iconEnabledColor: ColorManager.costumeBlack,
                isExpanded: true,
                items: dropDownList
                    ?.map<DropdownMenuItem<University>>((University uni) {
                  return DropdownMenuItem<University>(
                    value: uni,
                    child: Text(uni.uniName.toString()),
                  );
                }).toList(),
                onChanged: onChanged),
          ),
        ),
      ),
    );
  }
}
