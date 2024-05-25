import 'package:dagu/common/styles/spacing_styles.dart';
import 'package:dagu/features/authentication/views/otp/otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class PreferencesView extends StatefulWidget {
  const PreferencesView({Key? key}) : super(key: key);

  @override
  _PreferencesViewState createState() => _PreferencesViewState();
}

class _PreferencesViewState extends State<PreferencesView> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isRememberMeChecked = false;
  List<String> selectedTopics = [];

  @override
  Widget build(BuildContext context) {
    bool dark = DaguHelperFunctions.isDarkMode(context);
    List<String> topics = [
      // Topic list
    ];

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: DaguSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Mekdem",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: DaguColors.primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: ", Welcome to Dagu News.",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 25),
              Text(
                "Tell us what you want to discover, from Sports to Politics, from Entertainment to Health. Dagu will deliver.",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 19),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 107,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          selectedTopics.clear();
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(
                              color: dark ? Colors.white : Color(0xFF652D91)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.trash,
                            color: dark
                                ? DaguColors.white
                                : DaguColors.primaryColor,
                            size: 16,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Reset",
                            style: TextStyle(
                              color: dark
                                  ? DaguColors.white
                                  : DaguColors.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: DaguSizes.spaceBtwSections * 1.25),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: topics.map((topic) {
                    final isSelected = selectedTopics.contains(topic);
                    return OutlinedButton(
                      onPressed: () {
                        setState(() {
                          if (isSelected) {
                            selectedTopics.remove(topic);
                          } else {
                            selectedTopics.add(topic);
                          }
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        side: BorderSide(
                            color: isSelected
                                ? DaguColors.white
                                : DaguColors
                                    .primaryColor), // Border color logic
                        backgroundColor: isSelected
                            ? dark
                                ? DaguColors.white
                                : DaguColors.primaryColor
                            : dark
                                ? null
                                : null,
                      ),
                      child: Text(
                        topic,
                        style: TextStyle(
                          color: isSelected
                              ? dark
                                  ? DaguColors.primaryColor
                                  : DaguColors.white
                              : dark
                                  ? DaguColors.white
                                  : DaguColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: DaguSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      Get.to(() => const OTPView());
                    }
                  },
                  child: const Text("Confirm"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
