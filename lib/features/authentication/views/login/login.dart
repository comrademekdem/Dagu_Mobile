import 'package:dagu/common/styles/spacing_styles.dart';
import 'package:dagu/features/authentication/views/signup/signup.dart';
import 'package:dagu/utils/api_service/api_service.dart';
import 'package:dagu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../personalization/views/preferences_choice.dart';
import '../forgot_password/forgot_password.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService(); // Initialize ApiService
  final _emailOrUsernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isRememberMeChecked = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailOrUsernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final username = _emailOrUsernameController.text.trim();
      final password = _passwordController.text.trim();

      final response = await _apiService.login(username, password);
      print(response);
      Get.to(() =>
          const PreferencesView()); // Navigate to next screen after successful login
    } catch (e) {
      print('Login failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to login')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool dark = DaguHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DaguSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Image(
                height: 150,
                image: AssetImage("assets/images/logo.png"),
              ),
              const SizedBox(height: 25),
              Text(
                "Welcome Back to Dagu News.",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailOrUsernameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.direct_right),
                          labelText: "E-mail or Username",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email or username';
                          }
                          // Email validation
                          if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                  .hasMatch(value) &&
                              false) {
                            return 'Please enter a valid email or username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: DaguSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.password_check),
                          labelText: "Password",
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
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        obscureText: !_isPasswordVisible,
                      ),
                      const SizedBox(height: DaguSizes.spaceBtwInputFields / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _isRememberMeChecked,
                                onChanged: (value) {
                                  setState(() {
                                    _isRememberMeChecked = value ?? false;
                                  });
                                },
                              ),
                              const Text("Remember Me"),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPassword(),
                                ),
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
                          onPressed: _isLoading ? null : _signIn,
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : const Text("Sign In"),
                        ),
                      ),
                      const SizedBox(height: DaguSizes.spaceBtwItems),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: _isLoading
                              ? null
                              : () => Get.to(() => SignUpView()),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(color: Color(0xFF652D91)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                    "Or Sign In With",
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
      ),
    );
  }
}
