import 'package:dagu/features/authentication/controllers/onboarding_controller.dart';
import 'package:dagu/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = DaguHelperFunctions.isDarkMode(context);
    return Positioned(
        left: DaguSizes.defaultSpace,
        bottom: DaguDeviceUtils.getBottomNavigationBarHeight() + 25,
        child: SmoothPageIndicator(
          count: 3,
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          effect: const ExpandingDotsEffect(
            activeDotColor: DaguColors.dark,
            dotHeight: 6,
          ),
        ));
  }
}