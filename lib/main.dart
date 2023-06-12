import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_care_app/resources/assets_manager.dart';
import 'resources/color_manager.dart';
import 'resources/font_manager.dart';
import 'resources/string_manager.dart';
import 'resources/styles_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'resources/values_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'resources/components_manager.dart';

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
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppMargin.m40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5.h, 0, 0),
                    child: SvgPicture.asset(
                      ImageAssetsManager.splashLogo,
                      height: AppSize.s38,
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s3,
                  ),
                  Text(
                    AppStrings.splashScreenText,
                    style: TextStyles.getTextStyle(
                        fontSize: FontSize.s22,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.costumeBlack,
                        height: 1.8),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: AppSize.s6,
                  ),
                  ComponentManager.mainGradientButton(
                      text: AppStrings.continueText)
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
