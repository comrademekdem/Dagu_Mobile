// import 'package:dagu/common/styles/spacing_styles.dart';
// import 'package:dagu/features/authentication/views/otp/otp.dart';
// import 'package:dagu/utils/helpers/helper_functions.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';

// import '../../../../utils/constants/colors.dart';
// import '../../../../utils/constants/sizes.dart';

// class CreateNewPasswordView extends StatefulWidget {
//   const CreateNewPasswordView({super.key});

//   @override
//   _CreateNewPasswordViewState createState() => _CreateNewPasswordViewState();
// }

// class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
//   final _formKey = GlobalKey<FormState>();
//   late String password = '';
//   late String confirmPassword = '';

//   @override
//   Widget build(BuildContext context) {
//     bool dark = DaguHelperFunctions.isDarkMode(context);

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: DaguSpacingStyles.paddingWithAppBarHeight,
//           child: Column(
//             children: [
//               Column(
//                 children: [
//                   const SizedBox(height: 40),
//                   const Image(
//                     height: 150,
//                     image: AssetImage("assets/images/logo.png"),
//                   ),
//                   const SizedBox(height: 25),
//                   Text(
//                     "Create New Password.",
//                     style: Theme.of(context).textTheme.headlineMedium,
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     textAlign: TextAlign.left,
//                     "Your new password must be unique from any of your previously used ones.",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w300,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//               Form(
//                 key: _formKey,
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       top: 20, bottom: 20, left: 0, right: 0),
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         expands: false,
//                         decoration: const InputDecoration(
//                           labelText: "Password",
//                           prefixIcon: Icon(Iconsax.password_check),
//                           suffixIcon: Icon(Iconsax.eye_slash),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a password';
//                           } else if (value.length < 8) {
//                             return 'Password must be at least 8 characters long';
//                           } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
//                             return 'Password must contain at least one uppercase letter';
//                           } else if (!RegExp(r'[a-z]').hasMatch(value)) {
//                             return 'Password must contain at least one lowercase letter';
//                           } else if (!RegExp(r'[0-9]').hasMatch(value)) {
//                             return 'Password must contain at least one numeric character';
//                           } else if (!RegExp(r'[@#\$&*~]').hasMatch(value)) {
//                             return 'Password must contain at least one special character (!@\$\#\$\&*)';
//                           }
//                           password = value;
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: DaguSizes.spaceBtwInputFields),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           prefixIcon: Icon(Iconsax.password_check),
//                           labelText: "Confirm the Password",
//                           suffixIcon: Icon(Iconsax.eye_slash),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please confirm your password';
//                           } else if (value != password) {
//                             return 'The two passwords should be similar';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: DaguSizes.spaceBtwSections),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (_formKey.currentState?.validate() == true) {
//                               Get.to(() => const OTPView());
//                             }
//                           },
//                           child: const Text("Confirm"),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
