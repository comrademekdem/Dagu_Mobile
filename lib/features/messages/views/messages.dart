import 'package:dagu/features/personalization/views/foryou_page.dart';
import 'package:dagu/features/personalization/views/news_homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: const Center(
        child: Text('Messages Page Content'),
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
            Get.to(() => ForYouPage());
          } else if (index == 2) {}
        },
      ),
    );
  }
}
