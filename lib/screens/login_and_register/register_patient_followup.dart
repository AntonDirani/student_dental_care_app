import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:student_care_app/controllers/login_controller.dart';
import 'package:student_care_app/screens/login_and_register/signup_choose_role.dart';
import 'package:intl/intl.dart';
import '../../controllers/patient_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/components_manager.dart';
import '../../resources/home_screen.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/validation_manager.dart';
import '../../resources/values_manager.dart';

class PatientRegisterScreenFollowUp extends StatefulWidget {
  List<String> dropDownList1 = <String>[
    'اختر الجامعة الخاصة بك...',
    'Two',
    'Three',
    'Four'
  ];
  @override
  State<PatientRegisterScreenFollowUp> createState() =>
      _PatientRegisterScreenFollowUpState();
}

List<String> dropDownList1 = <String>[
  'اختر الجامعة الخاصة بك...',
  'Two',
  'Three',
  'Four'
];

class _PatientRegisterScreenFollowUpState
    extends State<PatientRegisterScreenFollowUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dateController = TextEditingController();
  bool _emailSubmitted = false;
  bool _passwordSubmitted = false;
  bool _success = false;
  bool _isLoading = false;
  bool _isPasswordHidden = true;
  String dropDownValue1 = dropDownList1.first;
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<LoginController>(context, listen: false);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight:
                      MediaQuery.of(context).size.height - AppPadding.p24),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p33),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: SvgPicture.asset(
                            ImageAssetsManager.informationVector,
                          ),
                        ),
                      ),
                      Text(
                        AppStrings.oneLastInfoText,
                        style: StylesManager.medium22(),
                      ),
                      Text(
                        AppStrings.weAreCloseToFinishText,
                        style: StylesManager.light18Black(),
                      ),
                      ComponentManager.myDropDown(
                          dropDownList: dropDownList1,
                          dropDownValue: dropDownValue1,
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropDownValue1 = value!;
                              print(value);
                            });
                          }),
                      ComponentManager.myTextField(
                        suffixIcon: ImageAssetsManager.calendarImage,
                        controller: _dateController,
                        onChanged: (value) {},
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2008),
                              firstDate: DateTime(1940),
                              lastDate: DateTime(2008));
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy/MM/dd').format(pickedDate);
                            setState(() {
                              _dateController.text = formattedDate;
                            });
                          }
                        },
                        label: '..الرجاء إدخال تاريخ الولادة الخاصة بك',
                      ),
                      _isLoading
                          ? const Center(
                              child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: CircularProgressIndicator(),
                            ))
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: ComponentManager.mainGradientButton(
                                onPressed: ValidationManager.validateEmail(
                                                _emailController.value.text) ==
                                            null &&
                                        ValidationManager.validatePassword(
                                                _passwordController
                                                    .value.text) ==
                                            null
                                    ? () async {
                                        setState(() {
                                          _isLoading = true;
                                        });

                                        _success = await _provider.logIn(
                                            _emailController.value.text,
                                            _passwordController.value.text);
                                        print(_success.toString());
                                        if (_success == true) {
                                          _isLoading = false;
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen()),
                                          );
                                        } else {
                                          Future.delayed(Duration(seconds: 4),
                                              () {
                                            // <-- Delay here
                                            setState(() {
                                              _isLoading =
                                                  false; // <-- Code run after delay
                                            });
                                            AlertDialog alert = AlertDialog(
                                              title: Text(
                                                "!انتباه",
                                                style:
                                                    StylesManager.bold18Black(),
                                                textAlign: TextAlign.right,
                                              ),
                                              content: Text(
                                                "عذرا حدث خطأ ما, يرجى إعادة المحاولة",
                                                style: StylesManager
                                                    .medium18Grey(),
                                                textAlign: TextAlign.right,
                                              ),
                                              actions: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: TextButton(
                                                    child: Text(
                                                      "رجوع",
                                                      style: StylesManager
                                                          .bold16(),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );

                                            // show the dialog
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return alert;
                                              },
                                            );
                                          });
                                        }
                                      }
                                    : null,
                                text: AppStrings.logInText,
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    AppStrings.registerNowText,
                                    style: StylesManager.semibold18Primary(),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpChooseScreen()),
                                  );
                                },
                              ),
                              Text(
                                AppStrings.youDontHaveAnAccountText,
                                style: StylesManager.light18(),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ))),
    ));
  }
}
