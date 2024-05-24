import 'package:dagu/features/authentication/views/login/login.dart';
import 'package:dagu/utils/constants/colors.dart';
import 'package:dagu/utils/constants/sizes.dart';
import 'package:dagu/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../utils/constants/text_strings.dart';

class AccountCreateSuccessView extends StatelessWidget {
  const AccountCreateSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(DaguSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Iconsax.tick_circle,
                color: DaguColors.primaryColor,
                size: 100.0,
              ),
              const SizedBox(height: DaguSizes.spaceBtwSections,),
              const Text(
                'Account Created!',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DaguSizes.spaceBtwItems,),
              const Text(
                'Your account has been created successfully.',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w200),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DaguSizes.spaceBtwSections,),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => Get.to(() => const LoginView()),
                      child: const Text("Go Back to Login",
                          style: TextStyle(color: Color(0xffffffff)
                          )
                      )
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
