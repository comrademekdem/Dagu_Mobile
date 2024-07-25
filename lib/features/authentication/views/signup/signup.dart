import 'package:dagu/features/authentication/google_signin_api.dart';
import 'package:dagu/features/authentication/views/login/login.dart';
import 'package:dagu/features/personalization/models/user.dart';
import 'package:dagu/features/personalization/views/news_homepage.dart';
import 'package:dagu/features/personalization/views/preferences_choice.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dagu/utils/constants/colors.dart';
import 'package:dagu/utils/constants/sizes.dart';
import 'package:dagu/utils/helpers/helper_functions.dart';
import 'package:dagu/utils/api_service/api_service.dart';
import '../otp/otp.dart';

class SignUpView extends StatefulWidget {
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
  String? _errorMessage;
  final _apiService = ApiService();

  Future _signUpWithGoogle() async {
    ApiService apiService;
    try {
      final googleUser = await GoogleSignInApi.login();
      if (googleUser == null) {
        setState(() {
          _errorMessage = 'Failed to sign in with Google. Please try again.';
        });
      } else {
        try {
          String displayName = googleUser.displayName ?? '';
          List<String> nameParts = displayName.split(' ');
          String firstName = nameParts.isNotEmpty ? nameParts[0] : '';
          String lastName =
              nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
          String userName = firstName;
          String password = "";
          String email = googleUser.email;
          await ApiService().register(
            userName ?? '', //Username
            firstName ?? '', // First name (optional)
            lastName ?? '', // Last name (optional)
            password, // Password (if required, generate or leave empty)
            email, // Email
          );

          final loginResponse = await _apiService.login(userName, password);
          final refreshToken = loginResponse['refresh'];
          final accessToken = loginResponse['access'];
          final jwt = JWT.decode(refreshToken);
          final userId = jwt.payload['user_id'];

          final userDetails =
              await _apiService.getUserDetails(accessToken, userId);
          final List<dynamic> topicsSelected = userDetails['topics_selected'];
          final List<Topic> topics = topicsSelected.map((topic) {
            return Topic(
              id: topic['id'],
              topic: topic['topic'],
            );
          }).toList();

          final User user = User(
            id: userDetails['id'],
            username: userDetails['username'],
            firstName: userDetails['first_name'],
            lastName: userDetails['last_name'],
            email: userDetails['email'],
            topicsSelected: topics,
            profilePic: userDetails['profile_pic'],
            lastLogin: DateTime.parse(userDetails['last_login']),
          );

          if (topics.isEmpty) {
            Get.to(() => PreferencesView(
                  user: user,
                )); // Navigate to preferences view
          } else {
            Get.to(() => NewsHomePage(user: user)); // Pass user to home view
          }
        } catch (e) {
          setState(() {
            _errorMessage = 'Failed to register with Google. Please try again.';
          });
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to sign in with Google. Please try again.';
      });
    }
  }

  Future<void> _register() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await ApiService().register(
        _usernameController.text,
        _firstNameController.text,
        _lastNameController.text,
        _passwordController.text,
        _emailController.text,
      );
      Get.to(() => OTPView(email: _emailController.text));
    } catch (e) {
      setState(() {
        _errorMessage =
            'Failed to register. Please try again.'; // Update with actual error if available
      });
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
        padding: const EdgeInsets.all(DaguSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Image(
              height: 150,
              image: AssetImage("assets/images/logo.png"),
            ),
            const SizedBox(height: DaguSizes.spaceBtwSections),
            Text(
              "Let's create your Dagu account.",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DaguSizes.spaceBtwSections),
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
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter your first name'
                              : null,
                        ),
                      ),
                      const SizedBox(width: DaguSizes.spaceBtwInputFields),
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            labelText: "Last Name",
                            prefixIcon: Icon(Iconsax.user),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter your last name'
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: DaguSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(Iconsax.user_edit),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter a username'
                        : null,
                  ),
                  const SizedBox(height: DaguSizes.spaceBtwInputFields),
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
                  const SizedBox(height: DaguSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
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
                  const SizedBox(height: DaguSizes.spaceBtwInputFields),
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
                      const SizedBox(width: DaguSizes.spaceBtwItems),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "I agree to ",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextSpan(
                              text: "Privacy Policy ",
                              style:
                                  Theme.of(context).textTheme.bodyMedium!.apply(
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
                              style:
                                  Theme.of(context).textTheme.bodyMedium!.apply(
                                        color: dark
                                            ? DaguColors.white
                                            : DaguColors.primaryColor,
                                        decoration: TextDecoration.underline,
                                        decorationColor: dark
                                            ? DaguColors.white
                                            : DaguColors.primaryColor,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: DaguSizes.spaceBtwInputFields),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : Column(
                          children: [
                            ElevatedButton(
                              onPressed: _register,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text("Continue"),
                            ),
                            const SizedBox(height: DaguSizes.spaceBtwItems),
                            IconButton(
                              onPressed: _signUpWithGoogle,
                              icon: Image.asset(
                                "assets/icons/google_icon.png",
                                width: 35,
                                height: 35,
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: DaguSizes.spaceBtwItems),
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
