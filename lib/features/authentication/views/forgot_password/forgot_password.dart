// import 'package:dagu/common/styles/spacing_styles.dart';
// import 'package:dagu/features/authentication/views/create_new_password/create_new_password.dart';
// import 'package:dagu/utils/helpers/helper_functions.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';

// import '../otp/otp.dart';
// import '../signup/signup.dart';

// class ForgotPassword extends StatelessWidget {
//   const ForgotPassword({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<FormState> _formKey =
//         GlobalKey<FormState>(); // Add this line

//     bool dark = DaguHelperFunctions.isDarkMode(context);
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: DaguSpacingStyles.paddingWithAppBarHeight,
//           child: Column(
//             children: [
//               Column(
//                 // crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 40),
//                   const Image(
//                     height: 150,
//                     image: AssetImage(
//                       "assets/images/logo.png",
//                     ),
//                   ),
//                   const SizedBox(height: 25),
//                   Text(
//                     "Forgot Password?",
//                     style: Theme.of(context).textTheme.headlineMedium,
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 30),
//                   const Text(
//                     textAlign: TextAlign.center,
//                     "Please enter the e-mail address linked with your account.",
//                     style: TextStyle(
//                       fontSize: 20,
//                     ),
//                   ),
//                 ],
//               ),
//               Form(
//                 key: _formKey, // Add this line
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       top: 20, bottom: 20, left: 0, right: 0),
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           prefixIcon: Icon(Iconsax.direct_right),
//                           labelText: "E-mail",
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your email';
//                           } else if (!RegExp(
//                                   r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
//                               .hasMatch(value)) {
//                             return 'Please enter a valid email address';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 30),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               Get.to(() => const CreateNewPasswordView());
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
