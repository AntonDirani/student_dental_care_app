

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:student_care_app/screens/do_you_have_an_account.dart';

import '../resources/assets_manager.dart';

import '../resources/components_manager.dart';

import '../resources/string_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p35),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 1.h, 0, 0),
                        child: SvgPicture.asset(
                          ImageAssetsManager.splashLogo,
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.fromLTRB(0, 0, 0, 7.h),
                      child: Text(
                        AppStrings.splashScreenText,
                        style: StylesManager.medium23(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 3.h, 0, 1.h),
                      child: ComponentManager.mainGradientButton(
                          text: AppStrings.continueText,
                          navigate: const DoYouHaveAnAccount(),
                        context: context
                          ,icon: Icons.arrow_back_ios
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}