import 'package:dagu/features/authentication/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class OnBoardingNextNavigation extends StatelessWidget {
  const OnBoardingNextNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = DaguDeviceUtils.isDarkMode(context);
    return Positioned(
        right: DaguSizes.defaultSpace,
        bottom: DaguDeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
          onPressed: () => OnBoardingController.instance.nextPage(),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: dark ? DaguColors.primaryColor : Colors.black,
          ),
          child: const Icon(Iconsax.arrow_right_3),

        )
    );
  }
}