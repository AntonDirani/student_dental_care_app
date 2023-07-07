import 'package:flutter/cupertino.dart';

class ValidationManager {
  static String? validateMobile(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return 'الرجاء إدخال رقم هاتف';
    } else if (!regExp.hasMatch(value)) {
      return 'الرجاء إدخال رقم هاتف صحيح';
    }
    return null;
  }
}
