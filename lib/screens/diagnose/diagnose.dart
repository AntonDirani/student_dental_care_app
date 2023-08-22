// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:student_care_app/controllers/diagnose_controller.dart';
import 'package:student_care_app/models/questions_model.dart';
import 'package:student_care_app/models/result_model.dart';
import 'package:student_care_app/resources/color_manager.dart';
import 'package:student_care_app/resources/styles_manager.dart';
import 'package:student_care_app/screens/diagnose/diagnose_result.dart';

class Diagnose extends StatefulWidget {
  const Diagnose({super.key});

  @override
  State<Diagnose> createState() => _DiagnoseState();
}

enum Answers {
  yes,
  no,
}

class _DiagnoseState extends State<Diagnose> {
  bool isNotAnswered = false;
  int currentPageIndex = 0;
  List<Question> questions = [];
  Answers? answers;
  late PageController controller;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: Provider.of<DiagnoseController>(context, listen: false)
            .fetchQuestions(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            questions = snapshot.data!;
            return PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  isNotAnswered = false;
                  answers = null;
                });
              },
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              pageSnapping: false,
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.sizeOf(context).height * 0.2),
                  //?main column
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //! question text
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                '${index + 1}- ${questions[currentPageIndex].question!}',
                                style: StylesManager.medium20(),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //! yes / no answers
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.2,
                                child: RadioListTile(
                                  title: Text(
                                    'لا',
                                    style: StylesManager.medium16Black(),
                                  ),
                                  value: Answers.no,
                                  groupValue: answers,
                                  onChanged: (value) {
                                    setState(() {
                                      answers = value!;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.3,
                                child: RadioListTile(
                                  title: Text(
                                    'نعم',
                                    style: StylesManager.medium16Black(),
                                  ),
                                  value: Answers.yes,
                                  groupValue: answers,
                                  onChanged: (value) {
                                    setState(() {
                                      answers = value!;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: 48,
                                height: 48,
                                child: CachedNetworkImage(
                                  imageUrl: questions[currentPageIndex].icon!,
                                ),
                              ),
                            ],
                          ),
                          isNotAnswered
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Animate(
                                        effects: const [ShakeEffect()],
                                        child: Text(
                                          'يجب اختيار اجابة',
                                          style:
                                              StylesManager.medium16().copyWith(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: TextButton(
                              onPressed: () async {
                                //? no answer
                                if (answers == null) {
                                  setState(() {
                                    isNotAnswered = true;
                                  });
                                  return;
                                }
                                //? if Answer is Yes
                                if (answers == Answers.yes) {
                                  if (questions[currentPageIndex].rightChild! <
                                      12) {
                                    currentPageIndex =
                                        questions[currentPageIndex]
                                                .rightChild! -
                                            1;
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => const Center(
                                          child: CircularProgressIndicator()),
                                    );
                                    Result? r =
                                        await Provider.of<DiagnoseController>(
                                                context,
                                                listen: false)
                                            .getResult(
                                                questions[currentPageIndex]
                                                    .rightChild!);
                                    Navigator.pop(context);
                                    showDialog(
                                        barrierDismissible: true,
                                        barrierColor: ColorManager.lightPrimary
                                            .withOpacity(0.1),
                                        context: context,
                                        builder: (context) {
                                          return DiagnoseResult(r: r!);
                                        });
                                    return;
                                  }
                                  //? if Answer is No
                                } else if (answers == Answers.no) {
                                  if (questions[currentPageIndex].leftChild! <
                                      12) {
                                    currentPageIndex =
                                        questions[currentPageIndex].leftChild! -
                                            1;
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => const Center(
                                          child: CircularProgressIndicator()),
                                    );
                                    Result? r =
                                        await Provider.of<DiagnoseController>(
                                                context,
                                                listen: false)
                                            .getResult(
                                                questions[currentPageIndex]
                                                    .leftChild!);
                                    Navigator.pop(context);

                                    showDialog(
                                        barrierDismissible: true,
                                        barrierColor: ColorManager.lightPrimary
                                            .withOpacity(0.1),
                                        context: context,
                                        builder: (context) {
                                          return DiagnoseResult(r: r!);
                                        });
                                    return;
                                  }
                                }
                                controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              child: Text(
                                'متابعة',
                                style: StylesManager.medium18Black().copyWith(
                                  color: ColorManager.lightPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
