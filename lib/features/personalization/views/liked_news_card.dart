import 'package:dagu/features/messages/views/messages.dart';
import 'package:dagu/features/personalization/models/user.dart';
import 'package:dagu/features/personalization/views/article_detail_page.dart';
import 'package:dagu/features/personalization/views/socials_page.dart';
import 'package:dagu/models/news_aritcle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class LikedNewsCard extends StatefulWidget {
  final NewsArticle article;
  final User user;

  LikedNewsCard({required this.article, required this.user});
  @override
  _LikedNewsCardState createState() => _LikedNewsCardState();
}

class _LikedNewsCardState extends State<LikedNewsCard> {
  void _showPopupMenu(BuildContext context, Offset offset) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: [
        PopupMenuItem<String>(
          value: 'remove',
          child: Text('Remove from Liked'),
        ),
        PopupMenuItem<String>(
          value: 'send',
          child: Text('Send to Others'),
        ),
      ],
      elevation: 8.0,
    ).then((selectedItem) {
      if (selectedItem != null) {
        if (selectedItem == 'remove') {
          // Handle remove from liked logic
        } else if (selectedItem == 'send') {
          showShareOptions();
        }
      }
    });
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

  void _handleLongPress(BuildContext context) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero, ancestor: overlay);
    _showPopupMenu(context, position);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ArticleDetailPage(article: widget.article));
      },
      onLongPress: () => _handleLongPress(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 225,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.article.urlToImage,
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
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    _showPopupMenu(context, details.globalPosition);
                  },
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
