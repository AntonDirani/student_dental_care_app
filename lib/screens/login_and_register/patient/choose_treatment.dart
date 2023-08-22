import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:student_care_app/home_screen.dart';
import 'package:student_care_app/resources/components_manager.dart';
import 'package:student_care_app/screens/diagnose/diagnose.dart';
import '../../../controllers/treatment_controller.dart';
import '../../../models/treatment_model.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';

class ChooseTreatment extends StatefulWidget {
  const ChooseTreatment({super.key});

  @override
  State<ChooseTreatment> createState() => _ChooseTreatmentState();
}

class _ChooseTreatmentState extends State<ChooseTreatment> {
  late Future<List<Treatment>> _treatments;
  int selectedIndex = -1;

  @override
  void initState() {
    _treatments = Provider.of<TreatmentController>(context, listen: false)
        .getTreatmentsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: SvgPicture.asset(
                  ImageAssetsManager.chooseTreatmentVector,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Text(
                AppStrings.chooseTreatmentText,
                style: StylesManager.medium20(),
              ),
            ),
            FutureBuilder<List>(
              future: _treatments,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<Treatment> values = snapshot.data;
                  return Column(
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: values.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: selectedIndex == index
                                      ? ColorManager.primary
                                      : ColorManager.lightGrey,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      values[index].treatmentImage!,
                                      width: 35,
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 95,
                                  ),
                                  Text(
                                    values[index].treatmentName!,
                                    style: StylesManager.regular14Black(),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ).build(context),
                      selectedIndex != -1
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ComponentManager.mainGradientButton(
                                text: 'متابعة',
                                onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(
                                      selectedTreatment:
                                          values[selectedIndex].treatmentName!,
                                      selectedIndex: selectedIndex,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        'في حال عدم معرفة المشكلة حاليا يمكنك اللجوء الى نظام ',
                    style: StylesManager.light16(),
                  ),
                  TextSpan(
                    text: 'التشخيص الذاتي ',
                    style: StylesManager.semiBold16Underlined()
                        .copyWith(color: Colors.green),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Diagnose(),
                          ),
                        );
                      },
                  ),
                  TextSpan(
                    text: 'الخاص بنا او ',
                    style: StylesManager.light16(),
                  ),
                  TextSpan(
                    text: 'التخطي',
                    style: StylesManager.semiBold16Underlined().copyWith(
                      color: Colors.red,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
