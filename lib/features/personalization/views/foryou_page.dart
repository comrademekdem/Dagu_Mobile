import 'package:dagu/features/messages/views/messages.dart';
import 'package:dagu/features/personalization/views/news_homepage.dart';
import 'package:dagu/features/profile_management/user_profile_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            Get.to(() => NewsHomePage());
          } else if (index == 1) {
          } else if (index == 2) {
            Get.to(() => MessagesPage());
          }
        },
      ),
    );
  }
}
