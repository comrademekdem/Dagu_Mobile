import 'package:flutter/material.dart';
import 'user_chat_screen.dart';

class ChatUsersList extends StatelessWidget {
  final List<String> users = [
    "User 1",
    "User 2",
    "User 3"
  ]; // Dummy list of users

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserChatScreen(userName: users[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
