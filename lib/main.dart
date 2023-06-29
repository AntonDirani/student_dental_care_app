import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:student_care_app/screens/splash_screen.dart';
import 'resources/color_manager.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorManager.primary,
    ));
    return ResponsiveSizer(builder: (buildContext, orientation, screenType) {
      return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen());
    });
  }
}
