import 'package:dagu/features/personalization/views/news_homepage.dart';
import 'package:dagu/features/profile_management/user_profile_details.dart';
import 'package:flutter/material.dart';

class ForYouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('For You'),
      ),
      body: Center(
        child: Text('This is the For You page'),
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
            // Navigate to Home page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsHomePage()),
            );
          } else if (index == 1) {
            // Navigate to For You page
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
        },
      ),
    );
  }
}
