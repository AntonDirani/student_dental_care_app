import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class AppointmentInfoCard extends StatelessWidget {
  final String text;

  AppointmentInfoCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: ColorManager.lightGrey,
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Text('data'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                //  values[index].postUniName!,
                'ايا شي ',
                style: StylesManager.semiBold16Primary(),
                //textAlign: TextAlign.right,
                //  textDirection: TextDirection.rtl,
              ),
              const SizedBox(
                width: 3,
              ),
              Icon(
                Icons.calendar_month,
                size: 15,
                color: ColorManager.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
