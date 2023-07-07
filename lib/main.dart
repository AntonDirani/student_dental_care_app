import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:student_care_app/controllers/login_controller.dart';
import 'package:student_care_app/screens/login_and_register/splash_screen.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginController>(
          create: (context) => LoginController(),
        ),
      ],
      child: ResponsiveSizer(builder: (buildContext, orientation, screenType) {
        return const MaterialApp(
            debugShowCheckedModeBanner: false, home: SplashScreen());
      }),
    );
  }
}
