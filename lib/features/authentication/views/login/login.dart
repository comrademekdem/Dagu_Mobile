import 'package:dagu/common/styles/spacing_styles.dart';
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
import '../../../personalization/views/preferences_choice.dart';
import '../forgot_password/forgot_password.dart';
class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                    "Welcome Back to Dagu News.",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    textAlign: TextAlign.left,
                    "Login",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                        labelText: "E-mail or Phone Number",
                      ),
                    ),
                    const SizedBox(height: DaguSizes.spaceBtwInputFields),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.password_check),
                        labelText: "Password",
                        suffixIcon: Icon(Iconsax.eye_slash),
                      ),
                    ),
                    const SizedBox(height: DaguSizes.spaceBtwInputFields / 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: true, onChanged: (value) {}),
                            const Text(
                              "Remember Me",
                            )
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ForgotPassword()),
                            );
                          },
                          child: const Text("Forgot Password"),
                        ),
                      ],
                    ),
                    const SizedBox(height: DaguSizes.spaceBtwSections),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () => Get.to(()=> const TopicPreferencesPage()), child: const Text("Sign In"))),
                    const SizedBox(height: DaguSizes.spaceBtwItems),
                    SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () => Get.to(() => const SignUpView()),
                            child: const Text("Sign Up",
                                style: TextStyle(color: Color(0xFF652D91)
                                )
                            )
                        )
                    ),
                  ],
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Divider(
                      color: dark ? DaguColors.darkGrey : DaguColors.grey,
                      thickness: 0.5,
                      indent: 5,
                      endIndent: 20,
                    ),
                  ),
                  Text("Or Sign In With",
                      style: Theme.of(context).textTheme.labelMedium),
                  Flexible(
                    child: Divider(
                      color: dark ? DaguColors.darkGrey : DaguColors.grey,
                      thickness: 0.5,
                      indent: 20,
                      endIndent: 5,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: DaguColors.grey),
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Image(
                        width: DaguSizes.iconMd,
                        height: DaguSizes.iconMd,
                        image: AssetImage("assets/icons/google_icon.png"),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    ));
  }
}
