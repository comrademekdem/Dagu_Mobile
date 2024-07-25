import 'package:dagu/features/personalization/models/user.dart';
import 'package:dagu/features/personalization/views/article_detail_page.dart';

import 'package:dagu/features/personalization/views/socials_page.dart';
import 'package:dagu/models/news_aritcle.dart';

import 'package:dagu/utils/api_service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class LatestNewsCard extends StatefulWidget {
  final NewsArticle article;
  final User user;

  LatestNewsCard({required this.article, required this.user});

  @override
  _LatestNewsCardState createState() => _LatestNewsCardState();
}

class _LatestNewsCardState extends State<LatestNewsCard> {
  bool isLiked = false;
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();

    isLiked = widget.article.liked;
    isBookmarked = widget.article.bookmarked;
  }

  Future<void> _toggleLike() async {
    setState(() {
      isLiked = !isLiked;
    });

    try {
      int newsId = await ApiService().storeNewsArticle(widget.article);
      int userId = widget.user.id;
      await ApiService().likeArticle(userId, newsId);
    } catch (e) {
      print('Failed to like/unlike article: $e');
    }
  }

  Future<void> _toggleBookmark() async {
    setState(() {
      isBookmarked = !isBookmarked;
    });

    try {
      int newsId = await ApiService().storeNewsArticle(widget.article);
      int userId = widget.user.id;
      await ApiService().bookmarkArticle(userId, newsId);
    } catch (e) {
      print('Failed to bookmark article/remove article from bookmark: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ArticleDetailPage(article: widget.article));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 225,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.article.urlToImage ??
                      "https://static1.anpoimages.com/wordpress/wp-content/uploads/wm/2024/07/android-recovery-factory-reset-wipe-hero.jpg",
                  height: 225,
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
                      widget.article.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'by ${widget.article.author}',
                      style: TextStyle(color: Colors.grey[300]),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.article.description,
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
                    color: Colors.black.withOpacity(0),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.white,
                        ),
                        onPressed: _toggleLike,
                      ),
                      IconButton(
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: isBookmarked ? Colors.yellow : Colors.white,
                        ),
                        onPressed: _toggleBookmark,
                      ),
                      IconButton(
                        icon: Icon(Icons.share, color: Colors.white),
                        onPressed: showShareOptions,
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

  void showShareOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.send),
                title: Text('Share within Dagu'),
                onTap: () async {
                  Navigator.pop(context); // Close the bottom sheet

                  Get.to(() => SocialsPage(
                        articleToShare: widget.article,
                        senderUser: widget.user,
                      ));
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share outside'),
                onTap: () {
                  Navigator.pop(context);
                  String url = widget.article.url;
                  Share.share(
                    'Sent from Dagu News App.\n$url',
                    subject: widget.article.description,
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
