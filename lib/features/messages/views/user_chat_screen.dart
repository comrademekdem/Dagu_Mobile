// user_chat_screen.dart

import 'package:flutter/material.dart';
import 'chat_bubble.dart';
import 'message_article_card.dart';

class UserChatScreen extends StatelessWidget {
  final String userName;

  UserChatScreen({required this.userName});

  final List<Map<String, dynamic>> messages = [
    {
      "isSentByMe": true,
      "title": "5 things to know about the 'conundrum' of lupus",
      "author": "Matt Villano",
      "date": "Sunday, 9 May 2021",
      "source": "Health Section"
    },
    {
      "isSentByMe": false,
      "title": "4 ways families can ease anxiety together",
      "author": "Zain Korsgaard",
      "date": "Sunday, 9 May 2021",
      "source": "Lifestyle Section"
    },
    // Add more messages here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            return ChatBubble(
              isSentByMe: message["isSentByMe"],
              child: MessageArticleCard(
                title: message["title"],
                author: message["author"],
                date: message["date"],
                sourceUrl: message["http://example.com"],
              ),
              source: message["source"],
            );
          },
        ),
      ),
    );
  }
}
