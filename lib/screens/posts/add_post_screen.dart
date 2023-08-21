import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:student_care_app/controllers/student_controller.dart';
import 'package:student_care_app/resources/assets_manager.dart';
import 'package:student_care_app/resources/color_manager.dart';
import 'package:student_care_app/screens/student_screens/home_screen_student.dart';
import '../../controllers/treatment_controller.dart';
import '../../models/treatment_model.dart';
import '../../resources/components_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _descriptionController = TextEditingController();
  bool _isSecondDateSelected = false;
  bool _isFirstDateSelected = false;
  bool _isSecondTimeSelected = false;
  bool _isFirstTimeSelected = false;

  bool _descriptionSubmitted = false;

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  late Future<List<Treatment>> _treatments;

  @override
  void initState() {
    _treatments = Provider.of<TreatmentController>(context, listen: false)
        .getTreatmentsList();
    super.initState();
  }

  // Function to copy default asset images to files

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList = selectedImages;
    }
    setState(() {});
  }

  int? _selectedTreatmentId;
  String? finalDate1;
  String? finalDate2;
  DateTime? pickedDate1;
  TimeOfDay? pickedTime1;
  DateTime? pickedDate2;
  TimeOfDay? pickedTime2;
  // Function to simulate the API request

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: (_selectedTreatmentId != null &&
                    _descriptionSubmitted &&
                    _isFirstDateSelected &&
                    _isSecondDateSelected &&
                    _isFirstTimeSelected &&
                    _isSecondTimeSelected)
                ? FloatingActionButton.small(
                    child: Icon(Icons.done),
                    onPressed: () async {
                      if (pickedDate1 != null &&
                          pickedTime1 != null &&
                          pickedDate1 != null &&
                          pickedTime1 != null) {
                        String iso8601DateTime1 =
                            "${pickedDate1!.toIso8601String().split('T')[0]}T${pickedTime1!.hour.toString().padLeft(2, '0')}:${pickedTime1!.minute.toString().padLeft(2, '0')}:00";
                        String iso8601DateTime2 =
                            "${pickedDate2!.toIso8601String().split('T')[0]}T${pickedTime2!.hour.toString().padLeft(2, '0')}:${pickedTime2!.minute.toString().padLeft(2, '0')}:00";
                        // Handle appointment booking logic with the iso8601DateTime
                        finalDate1 = iso8601DateTime1;
                        finalDate2 = iso8601DateTime2;
                        print(iso8601DateTime1);
                        print(iso8601DateTime2);
                      }
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return Consumer<StudentController>(
                            builder: (context, studentController, _) {
                              if (studentController.isApiInProgress) {
                                return const Dialog(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        LinearProgressIndicator(),
                                      ],
                                    ),
                                  ),
                                );
                              } else if (studentController.isApiSuccessful) {
                                _selectedTreatmentId = null;
                                return Dialog(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeScreenStudent()),
                                              );
                                            },
                                            child: Text(
                                              'العودة',
                                              style: StylesManager
                                                  .semiBold16Primary(),
                                            )),
                                        Text(
                                          '!تمت الإضافة بنجاح',
                                          style: StylesManager.medium16Black(),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'حدث خطأ ما',
                                          style: StylesManager.medium16Black(),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Close'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      );

                      await Provider.of<StudentController>(context,
                              listen: false)
                          .addPost(
                              description: _descriptionController.value.text,
                              treatmentId: _selectedTreatmentId,
                              imageFileList: imageFileList,
                              firstDate: finalDate1!,
                              lastDate: finalDate2!);
                      ();
                    })
                : SizedBox.shrink(),
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              title: Text(
                'إضافة معالجة جديدة',
                style: StylesManager.medium18White(),
              ),
            ),
            body: SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height - 80),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Text(
                                  'اختر الحالة الطبية',
                                  textAlign: TextAlign.right,
                                  style: StylesManager.medium18Black(),
                                ),
                              ),
                              FutureBuilder<List<Treatment>>(
                                future:
                                    _treatments, // Replace with your future method that fetches treatments
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Treatment>> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return Text('No data available.');
                                  } else {
                                    List<Treatment> treatments = snapshot.data!;
                                    return SizedBox(
                                      height: 150,
                                      child: ListView.separated(
                                        reverse: true,
                                        padding: EdgeInsets.all(8.0),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: treatments.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final treatment = treatments[index];
                                          return GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                _selectedTreatmentId =
                                                    treatment.treatmentId;
                                                print(_selectedTreatmentId);
                                                treatments.forEach((treatment) {
                                                  treatment.isSelected = false;
                                                });
                                                treatment.isSelected = true;
                                              });
                                            },
                                            child: Container(
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: treatment.isSelected ??
                                                        false
                                                    ? Colors.blue
                                                    : ColorManager.lightGrey,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SvgPicture.asset(
                                                      treatment.treatmentImage!,
                                                      width: 40,
                                                      color: treatment
                                                                  .isSelected ??
                                                              false
                                                          ? Colors.white
                                                          : null,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            90,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 2),
                                                    child: Text(
                                                      treatment.treatmentName!,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            FontConstants
                                                                .fontFamily,
                                                        fontSize: 14,
                                                        color: treatment
                                                                    .isSelected ??
                                                                false
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(width: 10);
                                        },
                                      ),
                                    );
                                  }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                child: GestureDetector(
                                  onTap: () {
                                    selectImages();
                                  },
                                  child: imageFileList.isEmpty
                                      ? Container(
                                          height: 120,
                                          decoration: BoxDecoration(
                                              color: ColorManager.lightGrey,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(AppSize.s4))),
                                          child: Center(
                                            child: Text(
                                              'اضغط لإختيار الصور',
                                              style: StylesManager.medium16(),
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          height: 120,
                                          child: GridView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: imageFileList.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Image.file(
                                                  File(imageFileList[index]
                                                      .path),
                                                  fit: BoxFit.cover,
                                                );
                                              }),
                                        ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: ComponentManager.descriptionTextField(
                                      onChanged: (value) => setState(() {
                                            _descriptionSubmitted = true;
                                          }),
                                      controller: _descriptionController,
                                      label: 'تفاصيل المعالجة'),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ComponentManager.myTextField(
                                      suffixIcon:
                                          ImageAssetsManager.calendarImage,
                                      readOnly: true,
                                      label: 'التاريخ الاول',
                                      onTap: () async {
                                        pickedDate2 = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2024),
                                        );

                                        if (pickedDate2 != null) {
                                          setState(() {
                                            _isSecondDateSelected = true;
                                          }); // Trigger a rebuild to display the selected date
                                        }
                                      },
                                      controller: TextEditingController(
                                        text: pickedDate2
                                                ?.toIso8601String()
                                                .split('T')[0] ??
                                            '',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: ComponentManager.myTextField(
                                      suffixIcon:
                                          ImageAssetsManager.calendarImage,
                                      readOnly: true,
                                      label: 'التاريخ الاول',
                                      onTap: () async {
                                        pickedDate1 = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2024),
                                        );

                                        if (pickedDate1 != null) {
                                          setState(() {
                                            _isFirstDateSelected = true;
                                          }); // Trigger a rebuild to display the selected date
                                        }
                                      },
                                      controller: TextEditingController(
                                        text: pickedDate1
                                                ?.toIso8601String()
                                                .split('T')[0] ??
                                            '',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              /* TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(labelText: 'Time'),
                                onTap: () async {
                                  pickedTime1 = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );

                                  if (pickedTime1 != null) {
                                    setState(
                                        () {}); // Trigger a rebuild to display the selected time
                                  }
                                },
                                controller: TextEditingController(
                                  text: pickedTime1 != null
                                      ? "${pickedTime1!.hour}:${pickedTime!.minute}"
                                      : '',
                                ),
                              ),*/
                              Row(children: [
                                Expanded(
                                  child: ComponentManager.myTextField(
                                    suffixIcon:
                                        ImageAssetsManager.calendarImage,
                                    readOnly: true,
                                    label: 'الوقت الثاني',
                                    onTap: () async {
                                      pickedTime2 = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );

                                      if (pickedTime2 != null) {
                                        setState(() {
                                          _isSecondTimeSelected = true;
                                        }); // Trigger a rebuild to display the selected time
                                      }
                                    },
                                    controller: TextEditingController(
                                      text: pickedTime2 != null
                                          ? "${pickedTime2!.hour}:${pickedTime2!.minute}"
                                          : '',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: ComponentManager.myTextField(
                                    suffixIcon:
                                        ImageAssetsManager.calendarImage,
                                    readOnly: true,
                                    label: 'الوقت الأول',
                                    onTap: () async {
                                      pickedTime1 = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );

                                      if (pickedTime1 != null) {
                                        setState(() {
                                          _isFirstTimeSelected = true;
                                        }); // Trigger a rebuild to display the selected time
                                      }
                                    },
                                    controller: TextEditingController(
                                      text: pickedTime1 != null
                                          ? "${pickedTime1!.hour}:${pickedTime1!.minute}"
                                          : '',
                                    ),
                                  ),
                                )
                              ])
                            ]))))));
  }
}
