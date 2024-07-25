import 'package:dagu/common/styles/spacing_styles.dart';
import 'package:dagu/features/authentication/views/signup/signup.dart';
import 'package:dagu/features/personalization/views/news_homepage.dart';
import 'package:dagu/features/personalization/models/user.dart';
import 'package:dagu/utils/api_service/api_service.dart';
import 'package:dagu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  final _secureStorage = FlutterSecureStorage(); // Initialize secure storage
  bool _isPasswordVisible = false;
  bool _isRememberMeChecked = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadStoredCredentials(); // Load stored credentials on startup
  }

  @override
  void dispose() {
    _emailOrUsernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadStoredCredentials() async {
    final storedUsername = await _secureStorage.read(key: 'username');
    final storedPassword = await _secureStorage.read(key: 'password');

    if (storedUsername != null && storedPassword != null) {
      _emailOrUsernameController.text = storedUsername;
      _passwordController.text = storedPassword;
      setState(() {
        _isRememberMeChecked = true;
      });

      // Optionally, automatically sign in if credentials are loaded
      // await _signIn();
    }
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

      final loginResponse = await _apiService.login(username, password);
      print('Response from login: $loginResponse'); // Log the entire response

      final refreshToken = loginResponse['refresh'];
      final accessToken = loginResponse['access'];

      // Save credentials if "Remember Me" is checked
      if (_isRememberMeChecked) {
        await _secureStorage.write(key: 'username', value: username);
        await _secureStorage.write(key: 'password', value: password);
      } else {
        await _secureStorage.delete(key: 'username');
        await _secureStorage.delete(key: 'password');
      }

      // Decode the refresh token to get user ID
      final jwt = JWT.decode(refreshToken);
      final userId = jwt.payload['user_id'];

      final userDetails = await _apiService.getUserDetails(accessToken, userId);
      final List<dynamic> topicsSelected = userDetails['topics_selected'];
      final String firstName = userDetails['first_name'];

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
      print('Login failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to login')),
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
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 0, right: 0),
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
                            onPressed: () {},
                            child: const Text("Forgot Password"),
                          ),
                        ],
                      ),
                      const SizedBox(height: DaguSizes.spaceBtwSections),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _signIn,
                                child: const Text("Sign In"),
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
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/icons/google_icon.png",
                  width: 35,
                  height: 35,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
