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
import 'package:student_care_app/screens/home_screen_student.dart';
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
  final _firstDateController = TextEditingController();
  final _secondDateController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isSecondDateSelected = false;
  bool _isFirstDateSelected = false;

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
                    _isSecondDateSelected)
                ? FloatingActionButton.small(
                    child: Icon(Icons.done),
                    onPressed: () async {
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
                                                  .medium14Primary(),
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
                              firstDate: _firstDateController.value.text,
                              lastDate: _secondDateController.value.text);
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
                                itemBuilder: (BuildContext context, int index) {
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
                                        color: treatment.isSelected ?? false
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              treatment.treatmentImage!,
                                              width: 40,
                                              color:
                                                  treatment.isSelected ?? false
                                                      ? Colors.white
                                                      : null,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                90,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2),
                                            child: Text(
                                              treatment.treatmentName!,
                                              style: TextStyle(
                                                fontFamily:
                                                    FontConstants.fontFamily,
                                                fontSize: 14,
                                                color: treatment.isSelected ??
                                                        false
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              textAlign: TextAlign.center,
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
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: imageFileList.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Image.file(
                                          File(imageFileList[index].path),
                                          fit: BoxFit.cover,
                                        );
                                      }),
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: ComponentManager.descriptionTextField(
                            onChanged: (value) => setState(() {
                                  _descriptionSubmitted = true;
                                }),
                            controller: _descriptionController,
                            label: 'تفاصيل المعالجة'),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ComponentManager.myTextField(
                              suffixIcon: ImageAssetsManager.calendarImage,
                              controller: _secondDateController,
                              onChanged: (value) {},
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(2023),
                                    firstDate: DateTime(2023),
                                    lastDate: DateTime(2024));
                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  setState(() {
                                    _secondDateController.text = formattedDate;
                                    _isSecondDateSelected = true;
                                    print(_secondDateController.value.text);
                                  });
                                }
                              },
                              label: 'اليوم الاخير للعلاج',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ComponentManager.myTextField(
                              suffixIcon: ImageAssetsManager.calendarImage,
                              controller: _firstDateController,
                              onChanged: (value) {},
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(2023),
                                    firstDate: DateTime(2023),
                                    lastDate: DateTime(2024));
                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  setState(() {
                                    _firstDateController.text = formattedDate;
                                    _isFirstDateSelected = true;
                                    print(_firstDateController.value.text);
                                  });
                                }
                              },
                              label: 'اليوم الاول للعلاج',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
