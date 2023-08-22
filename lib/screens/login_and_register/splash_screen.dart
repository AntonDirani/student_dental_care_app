import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_care_app/controllers/location_controller.dart';
import 'package:student_care_app/controllers/report_controller.dart';
import 'package:student_care_app/controllers/treatment_controller.dart';
import 'package:student_care_app/home_screen.dart';
import 'package:student_care_app/screens/login_and_register/do_you_have_an_account.dart';
import '../../controllers/posts_controller.dart';
import '../../controllers/university_controller.dart';
import '../../resources/assets_manager.dart';
import '../../resources/components_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<UniversityController>(context, listen: false).getUnis();
    Provider.of<LocationController>(context, listen: false).fetchLocations();
    Provider.of<PostController>(context, listen: false).getPosts();
    Provider.of<TreatmentController>(context, listen: false).fetchTreatments();
    Provider.of<ReportController>(context, listen: false).fetchReportsItems();
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
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          final auth = prefs.getString('token');
                          print(prefs.getString('token'));
                          auth != null
                              ? Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ))
                              : Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DoYouHaveAnAccount(),
                                  ),
                                );
                        },
                        text: AppStrings.continueText,
                        icon: Icons.arrow_forward_ios,
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
