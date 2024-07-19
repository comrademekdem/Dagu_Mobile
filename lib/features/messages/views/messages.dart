import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
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
              // Example avatar
              backgroundColor: Colors.blue,
              child: Text('A'), // Example initials or image
            ),
            title: Text('User 1'), // Replace with user's name
            onTap: () {
              // Replace with sending logic
              _sendNewsToUser('User 1');
              Navigator.pop(context); // Close messages page after sending
            },
          ),
          ListTile(
            leading: CircleAvatar(
              // Example avatar
              backgroundColor: Colors.green,
              child: Text('B'), // Example initials or image
            ),
            title: Text('User 2'), // Replace with user's name
            onTap: () {
              // Replace with sending logic
              _sendNewsToUser('User 2');
              Navigator.pop(context); // Close messages page after sending
            },
          ),
          // Add more ListTiles for other users as needed
        ],
      ),
    );
  }

  void _sendNewsToUser(String userName) {
    // Replace with logic to send news article to selected user
    String newsTitle =
        'Crypto investors should be prepared to lose all their money, BOE governor says';
    String newsAuthor = 'Ryan Browne';
    String newsDate = 'Today'; // Replace with actual date if available

    // Example: Send news to the user's chat
    print('Sending news to $userName: $newsTitle by $newsAuthor on $newsDate');
    // Implement your sending logic here (e.g., send to a chat or store for sending later)
  }
}
