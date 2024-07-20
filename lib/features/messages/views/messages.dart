import 'package:dagu/features/personalization/views/foryou_page.dart';
import 'package:dagu/features/personalization/views/news_homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  int _currentIndex = 2;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      Get.to(() => NewsHomePage());
    } else if (index == 1) {
      Get.to(() => ForYouPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose User'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('A'),
            ),
            title: Text('User 1'),
            onTap: () {
              _sendNewsToUser('User 1');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text('B'),
            ),
            title: Text('User 2'),
            onTap: () {
              _sendNewsToUser('User 2');
              Navigator.pop(context);
            },
          ),
          // Add more ListTiles for other users as needed
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Highlight the selected item
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
        onTap: _onTabTapped,
      ),
    );
  }

  void _sendNewsToUser(String userName) {
    String newsTitle =
        'Crypto investors should be prepared to lose all their money, BOE governor says';
    String newsAuthor = 'Ryan Browne';
    String newsDate = 'Today';

    print('Sending news to $userName: $newsTitle by $newsAuthor on $newsDate');
  }
}
