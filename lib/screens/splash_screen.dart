import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/components_manager.dart';
import '../resources/font_manager.dart';
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
          padding: const EdgeInsets.all(AppPadding.p40),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 1.h, 0, 0),
                      child: SvgPicture.asset(
                        ImageAssetsManager.splashLogo,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Text(
                        AppStrings.splashScreenText,
                        style: TextStyles.getTextStyle(
                            fontSize: FontSize.s22,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.costumeBlack,
                            height: 1.8),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 3.h, 0, 1.h),
                      child: ComponentManager.mainGradientButton(
                          text: AppStrings.continueText),
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
