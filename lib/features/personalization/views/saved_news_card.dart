import 'package:dagu/features/messages/views/messages.dart';
import 'package:dagu/features/personalization/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SavedNewsCard extends StatelessWidget {
  late final User user;
  void _showPopupMenu(BuildContext context, Offset offset) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: [
        PopupMenuItem<String>(
          value: 'remove',
          child: Text('Remove from Saved'),
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
          // Handle remove from saved logic
        } else if (selectedItem == 'send') {
          showShareOptions(context);
        }
      }
    });
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
                  Navigator.pop(context); // Close the bottom sheet
                  Get.to(() => MessagesPage(
                        user: user,
                      ));
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share outside'),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  Share.share(
                    'Check out this news article: Crypto investors should be prepared to lose all their money, BOE governor says',
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

  void _handleLongPress(BuildContext context) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero, ancestor: overlay);
    _showPopupMenu(context, position);
  }

  Future<void> _showLeavePageDialog(BuildContext context) async {
    bool? confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Leave this page?'),
        content:
            Text('Do you really want to leave this page to view the article?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      // Replace the URL with the actual article URL
      const url = 'https://example.com/news-article';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch the article')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showLeavePageDialog(context),
      onLongPress: () => _handleLongPress(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/homepage_placeholder_1.jpeg',
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
                      'Crypto investors should be prepared to lose all their money, BOE governor says',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
