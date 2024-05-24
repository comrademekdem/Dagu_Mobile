import 'package:dagu/utils/constants/colors.dart';
import 'package:dagu/utils/constants/sizes.dart';
import 'package:dagu/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/text_strings.dart';
import '../otp/otp.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = DaguHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DaguSizes.defaultSpace),
          child: Column(
            children: [
              const Image(
                  height: 150,
                  image: AssetImage(
                    "assets/images/logo.png",
                  )),
              ///Title
              const SizedBox(
                height: DaguSizes.spaceBtwSections,
              ),
              Text("Let's create your Dagu account.",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(
                height: DaguSizes.spaceBtwSections,
              ),
              Form(
                child: Column(
                  children: [
                    Row(
                    children: [
                      //First Name
                      Expanded(
                        child: TextFormField(
                        expands: false,
                        decoration: const InputDecoration(labelText: "First Name", prefixIcon: Icon(Iconsax.user)),
                        ),
                      ),
                      const SizedBox(width: DaguSizes.spaceBtwInputFields,),
                      //Last Name
                      Expanded(
                        child: TextFormField(
                        expands: false,
                        decoration: const InputDecoration(labelText: "Last Name", prefixIcon: Icon(Iconsax.user)),
                        ),
                      ),
                    ],
                    ),
                    const SizedBox(height: DaguSizes.spaceBtwInputFields,),
                    //Username
                    TextFormField(
                      expands: false,
                      decoration: const InputDecoration(labelText: "Username", prefixIcon: Icon(Iconsax.user_edit)),
                    ),
                    const SizedBox(height: DaguSizes.spaceBtwInputFields,),
                    //Email
                    TextFormField(
                      expands: false,
                      decoration: const InputDecoration(labelText: "E-mail", prefixIcon: Icon(Iconsax.message)),
                    ),
                    const SizedBox(height: DaguSizes.spaceBtwInputFields,),
                    TextFormField(
                      expands: false,
                      decoration: const InputDecoration(labelText: "Phone Number", prefixIcon: Icon(Iconsax.call)),
                    ),
                    const SizedBox(height: DaguSizes.spaceBtwInputFields,),
                    TextFormField(
                      expands: false,
                      decoration: const InputDecoration(labelText: "Password", prefixIcon: Icon(Iconsax.password_check), suffixIcon: Icon(Iconsax.eye_slash)),
                    ),
                    const SizedBox(height: DaguSizes.spaceBtwInputFields,),
                    Row(
                      children: [
                        SizedBox(width: 24, height: 24, child: Checkbox(value: true, onChanged: (value){}, activeColor: DaguColors.primaryColor)),
                        const SizedBox(width: DaguSizes.spaceBtwItems,),
                        Text.rich(TextSpan(
                          children: [
                            TextSpan(text: "I agree to ", style: Theme.of(context).textTheme.bodyMedium),
                            TextSpan(text: "Privacy Policy ", style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: dark? DaguColors.white: DaguColors.primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: dark? DaguColors.white: DaguColors.primaryColor,
                            )),
                            TextSpan(text: "and ", style: Theme.of(context).textTheme.bodyMedium),
                            TextSpan(text: "Terms of Use", style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: dark? DaguColors.white: DaguColors.primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: dark? DaguColors.white: DaguColors.primaryColor,
                            )),
                            TextSpan(text: '.', style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(height: DaguSizes.spaceBtwSections,),
                    SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.to(() => const OTPView()), child: const Text("Create Account"))),
                    const SizedBox(height: DaguSizes.spaceBtwItems),
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
                        Text("Or Sign Up With",
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

                ),

              )
                  ],
              ),
          ),
        ),
    );
  }
}
