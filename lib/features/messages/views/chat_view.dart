import 'package:dagu/features/personalization/models/user.dart';
import 'package:dagu/features/personalization/views/news_article_card.dart';
import 'package:dagu/models/news_aritcle.dart';
import 'package:dagu/utils/api_service/api_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final User senderUser;
  final User receiverUser;

  ChatPage({required this.senderUser, required this.receiverUser});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Future<List<NewsArticle>> _sharedNewsFuture;

  @override
  void initState() {
    super.initState();
    _sharedNewsFuture = ApiService()
        .getSharedNews(widget.senderUser.id, widget.receiverUser.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.receiverUser.username}'),
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: _sharedNewsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No shared articles from this user'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                NewsArticle article = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: NewsArticleCard(
                    article: article,
                    user: widget.senderUser,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
