import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for TextEditingController
import 'package:provider/provider.dart';
import 'package:student_care_app/models/post_model.dart';
import 'package:student_care_app/resources/styles_manager.dart';
import '../controllers/patient_controller.dart';

class BookingDialog extends StatefulWidget {
  final int postId;
  final Post post;
  const BookingDialog({required this.postId, super.key, required this.post});

  @override
  State<BookingDialog> createState() => _BookingDialogState(postId, post);
}

class _BookingDialogState extends State<BookingDialog> {
  final Post myPost;
  final int myPostId;
  DateTime firstDate;
  DateTime lastDate;
  _BookingDialogState(this.myPostId, this.myPost)
      : firstDate = DateTime.parse(myPost.postFirstDate!),
        lastDate = DateTime.parse(myPost.postLastDate!);

  DateTime? pickedDate;
  TimeOfDay? pickedTime;
  String? finalDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'املأ المعلومات التالية',
        textAlign: TextAlign.right,
        style: StylesManager.medium18Black(),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              label: Align(
                alignment: Alignment.centerRight,
                child: Text('تاريخ الموعد', style: StylesManager.medium16()),
              ),
            ),
            onTap: () async {
              pickedDate = await showDatePicker(
                context: context,
                initialDate: firstDate,
                firstDate: firstDate,
                lastDate: lastDate,
              );

              if (pickedDate != null) {
                setState(
                    () {}); // Trigger a rebuild to display the selected date
              }
            },
            controller: TextEditingController(
              text: pickedDate?.toIso8601String().split('T')[0] ?? '',
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              label: Align(
                alignment: Alignment.centerRight,
                child: Text('الوقت', style: StylesManager.medium16()),
              ),
            ),
            onTap: () async {
              pickedTime = await showTimePicker(
                  context: context,
                  helpText: 'اختر الوقت المناسب للموعد',
                  initialTime: TimeOfDay.now(),
                  initialEntryMode: TimePickerEntryMode.dialOnly);
              if (pickedTime != null) {
                setState(
                    () {}); // Trigger a rebuild to display the selected time
              }
            },
            controller: TextEditingController(
              text: pickedTime != null
                  ? "${pickedTime!.hour}:${pickedTime!.minute}"
                  : '',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (pickedDate != null && pickedTime != null) {
              String iso8601DateTime =
                  "${pickedDate!.toIso8601String().split('T')[0]}T${pickedTime!.hour.toString().padLeft(2, '0')}:${pickedTime!.minute.toString().padLeft(2, '0')}:00";

              // Handle appointment booking logic with the iso8601DateTime
              finalDate = iso8601DateTime;
              print(iso8601DateTime);
            }
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return Consumer<PatientController>(
                  builder: (context, patientController, _) {
                    if (patientController.isApiInProgress) {
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
                    } else if (patientController.isApiSuccessful) {
                      return Dialog(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'العودة',
                                      style: StylesManager.semiBold16Primary(),
                                    )),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  //'!تمت الإضافة بنجاح',
                                  patientController.apiResponse,
                                  style: StylesManager.medium16Black(),
                                ),
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
            await Provider.of<PatientController>(context, listen: false)
                .makeAppointment(finalDate!, myPostId);
          },
          child: Text(
            'تثبيت الموعد',
            style: StylesManager.semiBold16Primary(),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'تراجع',
            style: StylesManager.medium16Black(),
          ),
        ),
      ],
    );
  }
}
