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

  static String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return 'الرجاء إدخال بريد إلكتروني';
    } else if (!regExp.hasMatch(value)) {
      return 'الرجاء إدخال بريد ألكتروني صحيح';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    var passNonNullValue = value ?? "";
    if (passNonNullValue.isEmpty) {
      return ("الرجاء إدخال كلمة مرور");
    } else if (passNonNullValue.length < 8) {
      return ("كلمة المرور يجب ان تكون 8 محارف أو اكثر");
    } else if (!regex.hasMatch(passNonNullValue)) {
      return ("كلمة المرور يجب ان تحتوي على حرف كبير و حرف صغير و أرقام");
    }
    return null;
  }
}
