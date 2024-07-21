import 'package:dagu/models/news_aritcle.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dagu/features/messages/views/messages.dart';
import 'package:url_launcher/url_launcher.dart';

class LatestNewsCard extends StatelessWidget {
  final NewsArticle article;

  LatestNewsCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(article.url)) {
          await launch(article.url);
        } else {
          throw 'Could not launch ${article.url}';
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 250,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  article.urlToImage,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      article.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'by ${article.author}',
                      style: TextStyle(color: Colors.grey[300]),
                    ),
                    SizedBox(height: 5),
                    Text(
                      article.description,
                      style: TextStyle(color: Colors.grey[300]),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite_border, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.bookmark_border, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.share, color: Colors.white),
                        onPressed: () {
                          showShareOptions(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.send),
                title: Text('Share within Dagu'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MessagesPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share outside'),
                onTap: () {
                  Navigator.pop(context);
                  Share.share(
                    'Check out this news article: ${article.title}',
                    subject: 'News Article',
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
