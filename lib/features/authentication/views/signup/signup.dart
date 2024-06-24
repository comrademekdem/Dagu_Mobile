import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dagu/utils/constants/colors.dart';
import 'package:dagu/utils/constants/sizes.dart';
import 'package:dagu/utils/helpers/helper_functions.dart';
import 'package:dagu/utils/api_service/api_service.dart';
import '../otp/otp.dart';

class SignUpView extends StatefulWidget {
  SignUpView({super.key});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isChecked = true;
  bool _isLoading = false;

  Future<void> _register() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await ApiService().register(
        _usernameController.text,
        _firstNameController.text,
        _lastNameController.text,
        _passwordController.text,
        _emailController.text,
      );
      Get.to(() => const OTPView());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
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
                "Let's create your Dagu account.",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: DaguSizes.spaceBtwSections,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              labelText: "First Name",
                              prefixIcon: Icon(Iconsax.user),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: DaguSizes.spaceBtwInputFields,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              labelText: "Last Name",
                              prefixIcon: Icon(Iconsax.user),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: DaguSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: "Username",
                        prefixIcon: Icon(Iconsax.user_edit),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: DaguSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: "E-mail",
                        prefixIcon: Icon(Iconsax.message),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: DaguSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Iconsax.password_check),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Iconsax.eye
                                : Iconsax.eye_slash,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                          return 'Password must contain at least one uppercase letter';
                        } else if (!RegExp(r'[a-z]').hasMatch(value)) {
                          return 'Password must contain at least one lowercase letter';
                        } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                          return 'Password must contain at least one numeric character';
                        } else if (!RegExp(r'[@#\$&*~]').hasMatch(value)) {
                          return 'Password must contain at least one special character (!@\$\#\$\&*)';
                        }
                        return null;
                      },
                      obscureText: !_isPasswordVisible,
                    ),
                    const SizedBox(
                      height: DaguSizes.spaceBtwInputFields,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value ?? true;
                            });
                          },
                          activeColor: DaguColors.primaryColor,
                        ),
                        const SizedBox(
                          width: DaguSizes.spaceBtwItems,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "I agree to ",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextSpan(
                                text: "Privacy Policy ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                      color: dark
                                          ? DaguColors.white
                                          : DaguColors.primaryColor,
                                      decoration: TextDecoration.underline,
                                      decorationColor: dark
                                          ? DaguColors.white
                                          : DaguColors.primaryColor,
                                    ),
                              ),
                              TextSpan(
                                text: "and ",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextSpan(
                                text: "Terms of Use",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                      color: dark
                                          ? DaguColors.white
                                          : DaguColors.primaryColor,
                                      decoration: TextDecoration.underline,
                                      decorationColor: dark
                                          ? DaguColors.white
                                          : DaguColors.primaryColor,
                                    ),
                              ),
                              TextSpan(
                                text: '.',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: DaguSizes.spaceBtwSections,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _register,
                        child: _isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : const Text("Create Account"),
                      ),
                    ),
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
                        Text(
                          "Or Sign Up With",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Flexible(
                          child: Divider(
                            color: dark ? DaguColors.darkGrey : DaguColors.grey,
                            thickness: 0.5,
                            indent: 20,
                            endIndent: 5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: DaguColors.grey),
                            borderRadius: BorderRadius.circular(100),
                          ),
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
