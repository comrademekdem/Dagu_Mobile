import 'package:dagu/features/authentication/controllers/onboarding_controller.dart';
import 'package:dagu/features/authentication/views/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:dagu/features/authentication/views/onboarding/widgets/onboarding_next_navigation.dart';
import 'package:dagu/features/authentication/views/onboarding/widgets/onboarding_page.dart';
import 'package:dagu/features/authentication/views/onboarding/widgets/onboarding_skip.dart';
import 'package:dagu/utils/constants/colors.dart';
import 'package:dagu/utils/constants/image_strings.dart';
import 'package:dagu/utils/constants/sizes.dart';
import 'package:dagu/utils/constants/text_strings.dart';
import 'package:dagu/utils/device/device_utility.dart';
import 'package:dagu/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:iconsax/iconsax.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: controller.pageController,
          onPageChanged: controller.updatePageIndicator,

          children: const [
            OnBoardingPage(
                image: DaguImages.onBoardingScreen1,
                title: DaguTexts.onBoardingTitle1,
                subTitle: DaguTexts.onBoardingSubTitle1
            ),
            OnBoardingPage(
                image: DaguImages.onBoardingScreen2,
                title: DaguTexts.onBoardingTitle2,
                subTitle: DaguTexts.onBoardingSubTitle2
            ),
            OnBoardingPage(
                image: DaguImages.onBoardingScreen3,
                title: DaguTexts.onBoardingTitle3,
                subTitle: DaguTexts.onBoardingSubTitle3
            ),
          ],
        ),
        const OnBoardingSkip(),
        const OnBoardingDotNavigation(),
        const OnBoardingNextNavigation(),
      ],
    ));
  }
}








