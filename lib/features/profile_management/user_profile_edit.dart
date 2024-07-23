import 'package:dagu/features/profile_management/user_profile_details.dart';
import 'package:dagu/utils/api_service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:dagu/features/personalization/models/user.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
// import 'package:dagu/services/api_service.dart'; // Ensure this is the correct path

class UserProfileEditPage extends StatefulWidget {
  final User user;

  UserProfileEditPage({required this.user});

  @override
  _UserProfileEditPageState createState() => _UserProfileEditPageState();
}

class _UserProfileEditPageState extends State<UserProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  late String firstName;
  late String lastName;
  late String username;
  late String profilePic;
  late String email;

  bool _isChanged = false;

  void _update() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        int userId = widget.user.id;

        await _apiService.updateUserDetails(
          userId,
          firstName,
          lastName,
          username,
          profilePic,
          email,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );

        // Update the local user object with new values while retaining unchanged fields
        User updatedUser = User(
          id: widget.user.id,
          firstName: firstName,
          lastName: lastName,
          username: username,
          profilePic: profilePic,
          email: email,
          topicsSelected: widget.user.topicsSelected, // Retain topicsSelected
          lastLogin: widget.user.lastLogin, // Retain lastLogin
        );
        Get.to(() => ProfilePage(user: updatedUser));
        // Navigate to NewsHomePage with the updated user object
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      }
    }
  }

  void _showConfirmationDialog(
      String title, String content, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Confirm"),
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    firstName = widget.user.firstName;
    lastName = widget.user.lastName;
    username = widget.user.username;
    profilePic = widget.user.profilePic;
    email = widget.user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.network(
                      profilePic,
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                initialValue: firstName,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value != firstName) {
                    setState(() {
                      _isChanged = true;
                      firstName = value;
                    });
                  }
                },
                onSaved: (value) => firstName = value!,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: lastName,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value != lastName) {
                    setState(() {
                      _isChanged = true;
                      lastName = value;
                    });
                  }
                },
                onSaved: (value) => lastName = value!,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: username,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value != username) {
                    setState(() {
                      _isChanged = true;
                      username = value;
                    });
                  }
                },
                onSaved: (value) => username = value!,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: email,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value != email) {
                    setState(() {
                      _isChanged = true;
                      email = value;
                    });
                  }
                },
                onSaved: (value) => email = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isChanged
                    ? () {
                        _showConfirmationDialog(
                          "Update Profile Details",
                          "Are you sure you want to update the above profile details?",
                          _update,
                        );
                      }
                    : null, // Disable button if no changes
                child: const Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
