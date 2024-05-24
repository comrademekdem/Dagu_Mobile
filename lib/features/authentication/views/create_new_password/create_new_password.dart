import 'package:dagu/common/styles/spacing_styles.dart';
import 'package:dagu/features/authentication/views/otp/otp.dart';
import 'package:dagu/features/authentication/views/signup/signup.dart';
import 'package:dagu/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../forgot_password/forgot_password.dart';
class CreateNewPasswordView extends StatelessWidget {
  const CreateNewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = DaguHelperFunctions.isDarkMode(context);
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
              padding: DaguSpacingStyles.paddingWithAppBarHeight,
              child: Column(
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      const Image(
                          height: 150,
                          image: AssetImage(
                            "assets/images/logo.png",
                          )),
                      const SizedBox(height: 25),
                      Text(
                        "Create New Password.",
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        textAlign: TextAlign.left,
                        "Your new password must be unique from any of your previously used ones.",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Form(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.direct_right),
                                labelText: "Enter your new password",
                              ),
                            ),
                            const SizedBox(height: DaguSizes.spaceBtwInputFields),
                            TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.password_check),
                                labelText: "Confirm the Password",
                                suffixIcon: Icon(Iconsax.eye_slash),
                              ),
                            ),

                            const SizedBox(height: DaguSizes.spaceBtwSections),
                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () => Get.to(() => const OTPView()), child: const Text("Confirm"))),
                          ],
                        ),
                      )),



                ],
              )),
        ));
  }
}
