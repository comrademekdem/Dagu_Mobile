import 'package:dagu/features/misc/about';
import 'package:dagu/features/personalization/views/foryou_page.dart';
import 'package:dagu/features/personalization/views/news_homepage.dart';
import 'package:dagu/features/profile_management/user_profile_edit.dart';
import 'package:dagu/utils/constants/colors.dart';
import 'package:dagu/utils/constants/sizes.dart';
import 'package:dagu/utils/helpers/helper_functions.dart';
import 'package:dagu/utils/theme/theme.dart'; // Import your theme file
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: DaguAppTheme.lightTheme,
      darkTheme: DaguAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isTwoFactorEnabled = false;

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
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Confirm"),
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
  Widget build(BuildContext context) {
    bool dark = DaguHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('For You'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: DaguSizes.spaceBtwSections),
            Text(
              "User Details",
              textAlign: TextAlign.left, // Align to the left
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: DaguSizes.spaceBtwSections),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: DaguColors.primaryColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/avatar.png', // Add your avatar image in assets folder
                            fit: BoxFit.cover,
                            width: 90,
                            height: 90,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fekadu Sisay',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'fekadusisay@gmail.com',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          Get.to(() => UserProfileEditPage());
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: dark ? DaguColors.darkerGrey : Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('My Account'),
                    trailing: const Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.arrow_forward_ios, size: 20),
                    ),
                    onTap: () {
                      Get.to(() => UserProfileEditPage());
                    },
                  ),
                  Divider(
                    color: dark ? DaguColors.darkGrey : DaguColors.grey,
                    thickness: 0.5,
                    indent: 5,
                    endIndent: 20,
                  ),
                  ListTile(
                    leading: Icon(Icons.lock),
                    title: Text('Two-Factor Authentication'),
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Switch(
                        value: isTwoFactorEnabled,
                        onChanged: (bool value) {
                          setState(() {
                            isTwoFactorEnabled = value;
                          });
                        },
                      ),
                    ),
                    onTap: () {
                      // Optional: Handle additional action on tap
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.restore),
                    title: Text('Reset User Preferences'),
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                    ),
                    onTap: () {
                      _showConfirmationDialog(
                        "Reset Preferences",
                        "Are you sure you want to reset preferences?",
                        () {
                          // Handle reset preferences
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Log out'),
                    onTap: () {
                      _showConfirmationDialog(
                        "Log out",
                        "Are you sure you want to log out?",
                        () {
                          // Handle logout
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: dark ? DaguColors.darkerGrey : Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.help),
                    title: Text('Help & Support'),
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                    ),
                    onTap: () {
                      // Navigate to help and support
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('About App'),
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                    ),
                    onTap: () {
                      Get.to(() => AboutAppPage());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'For You',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (int index) {
          // Handle navigation to different pages based on index
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsHomePage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForYouPage()),
            );
          } else if (index == 2) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ProfilePage()),
            // );
          }
        },
      ),
    );
  }
}
