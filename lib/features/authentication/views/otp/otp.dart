import 'dart:math';

import 'package:dagu/features/authentication/views/success_messages/successfully_created_account.dart';
import 'package:dagu/utils/api_service/api_service.dart';
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
import '../success_messages/successfully_changed_password.dart';

class OTPView extends StatefulWidget {
  final String email;
  OTPView({required this.email});

  @override
  _OTPViewState createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  late String _generatedOtp;
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _generatedOtp = generateOTP(4);
    ApiService().sendOTPEmail(widget.email, _generatedOtp);
  }

  String generateOTP(int length) {
    final random = Random();
    const chars = '0123456789';
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  void _verifyOtp() {
    if (_otpController.text.trim() == _generatedOtp) {
      Get.to(() => const AccountCreateSuccessView());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP. Please try again.')),
      );
    }
  }

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
                image: AssetImage("assets/images/logo.png"),
              ),
              const SizedBox(
                height: DaguSizes.spaceBtwSections,
              ),
              Text(
                "OTP Verification",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: DaguSizes.spaceBtwSections,
              ),
              const Text(
                "Enter the verification code we just sent to your email.",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: DaguSizes.spaceBtwSections,
              ),
              Form(
                child: Column(
                  children: [
                    PinCodeTextField(
                      appContext: context,
                      length: 4,
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        // Handle value changes
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(30),
                        fieldHeight: 70,
                        fieldWidth: 70,
                        activeFillColor: DaguColors.primaryColor,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.grey.shade200,
                      ),
                      onCompleted: (value) {
                        _verifyOtp();
                      },
                    ),
                    const SizedBox(
                      height: DaguSizes.spaceBtwSections,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _verifyOtp,
                        child: const Text("Submit"),
                      ),
                    ),
                    const SizedBox(
                      height: DaguSizes.spaceBtwSections,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Didn't get the code?"),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _generatedOtp = generateOTP(4);
                              ApiService()
                                  .sendOTPEmail(widget.email, _generatedOtp);
                            });
                          },
                          child: const Text("Resend OTP"),
                        ),
                      ],
                    ),
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
