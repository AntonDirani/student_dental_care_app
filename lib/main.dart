import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:student_care_app/controllers/diagnose_controller.dart';
import 'package:student_care_app/controllers/location_controller.dart';
import 'package:student_care_app/controllers/login_controller.dart';
import 'package:student_care_app/controllers/patient_controller.dart';
import 'package:student_care_app/controllers/posts_controller.dart';
import 'package:student_care_app/controllers/register_controller.dart';
import 'package:student_care_app/controllers/report_controller.dart';
import 'package:student_care_app/controllers/student_controller.dart';
import 'package:student_care_app/screens/login_and_register/splash_screen.dart';
import 'controllers/treatment_controller.dart';
import 'controllers/treatment_provider.dart';
import 'controllers/university_controller.dart';
import 'resources/color_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorManager.primary,
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginController>(
          create: (context) => LoginController(),
        ),
        ChangeNotifierProvider<RegisterController>(
          create: (context) => RegisterController(),
        ),
        ChangeNotifierProvider<StudentController>(
          create: (context) => StudentController(),
        ),
        ChangeNotifierProvider<UniversityController>(
          create: (context) => UniversityController(),
        ),
        ChangeNotifierProvider<PatientController>(
          create: (context) => PatientController(),
        ),
        ChangeNotifierProvider<LocationController>(
          create: (context) => LocationController(),
        ),
        ChangeNotifierProvider<TreatmentController>(
          create: (context) => TreatmentController(),
        ),
        ChangeNotifierProvider<PostController>(
          create: (context) => PostController(),
        ),
        ChangeNotifierProvider<TreatmentSelectionState>(
          create: (context) => TreatmentSelectionState(),
        ),
        ChangeNotifierProvider<ReportController>(
          create: (context) => ReportController(),
        ),
        ChangeNotifierProvider<DiagnoseController>(
          create: (context) => DiagnoseController(),
        ),
      ],
      child: ResponsiveSizer(
        builder: (buildContext, orientation, screenType) {
          return MaterialApp(
            locale: const Locale('ar'),
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            supportedLocales: const [Locale('ar')],
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
            theme: ThemeData(
              androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
            ),
          );
        },
      ),
    );
  }
}
