import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:student_care_app/controllers/location_controller.dart';

import '../../controllers/university_controller.dart';
import '../../home_screen.dart';
import '../../resources/assets_manager.dart';
import '../../resources/components_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<UniveristyController>(context, listen: false).getUnis();
    Provider.of<LocationController>(context, listen: false).fetchLocations();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p33),
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
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 7.h),
                      child: Text(
                        AppStrings.splashScreenText,
                        style: StylesManager.medium20(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 3.h, 0, 1.h),
                      child: ComponentManager.mainGradientButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                          },
                          text: AppStrings.continueText,
                          icon: Icons.arrow_back_ios),
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
