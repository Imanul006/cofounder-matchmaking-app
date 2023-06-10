import 'package:flutter/material.dart';
import 'package:kiuqi/constants/values.dart';
import 'package:kiuqi/screens/user_details/components/basic_info_step.dart';
import 'package:kiuqi/screens/user_details/components/celebration_screen.dart';
import 'package:kiuqi/screens/user_details/components/profile_step.dart';
import 'package:kiuqi/screens/user_details/components/startup_step.dart';
import 'package:kiuqi/screens/user_details/components/tagline_preview_step.dart';
import 'package:kiuqi/screens/user_details/components/tagline_step.dart';
import 'package:kiuqi/utils/loading_animation.dart';
import 'package:provider/provider.dart';
import 'package:kiuqi/providers/user_details_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> steps = [
      const BasicInfoStep(),
      const StartupStep(),
      const TaglineStep(),
      const TaglinePreviewStep(),
      const ProfileStep(),
      // const StageStep(),
      // const TargetedGenreStep(),
    ];

    UserDetailsProvider userDetailsProvider =
        Provider.of(context, listen: true);
    final PageController stepController = PageController();

    return Scaffold(
      body: SafeArea(
        child: userDetailsProvider.isLoading
            ? Center(child: LoadingAnimation.spin())
            : userDetailsProvider.isDataSubmitted
                ? const CelebrationScreen()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 8),
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: stepController,
                            onPageChanged: (index) => {},
                            children: steps,
                          ),
                        ),
                        SizedBox(
                          //flex: 3,
                          child: Column(
                            children: [
                              const SizedBox(height: 25),
                              SmoothPageIndicator(
                                controller: stepController,
                                count: userDetailsProvider.totalSteps,
                                effect: const ExpandingDotsEffect(
                                  expansionFactor: 5,
                                  dotHeight: 8,
                                  dotWidth: 8,
                                  activeDotColor: Colors.grey,
                                  dotColor: Color.fromARGB(255, 208, 208, 208),
                                ),
                              ),
                              const SizedBox(height: 18),
                              ElevatedButton(
                                onPressed: () {
                                  userDetailsProvider.nextStep();
                                  stepController.animateToPage(
                                    userDetailsProvider.currentStep,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                  );
                                },
                                style: ButtonStyle(
                                  elevation:
                                      MaterialStateProperty.all<double>(12),
                                  shadowColor: MaterialStateProperty.all<Color>(
                                      AppColor.primaryColor),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    Size(MediaQuery.of(context).size.width, 70),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColor.primaryColor),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35.0),
                                      side: const BorderSide(
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      userDetailsProvider.buttonText,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.arrow_forward,
                                      size: 22,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Visibility(
                                visible: userDetailsProvider.currentStep > 0,
                                child: TextButton(
                                  onPressed: () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    userDetailsProvider.previousStep();
                                    stepController.animateToPage(
                                      userDetailsProvider.currentStep,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                  child: const Text(
                                    "Go back",
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
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
