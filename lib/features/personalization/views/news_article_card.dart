import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class LatestNewsCard extends StatefulWidget {
  @override
  _LatestNewsCardState createState() => _LatestNewsCardState();
}

class _LatestNewsCardState extends State<LatestNewsCard> {
  bool isLiked = false;
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  SizedBox(height: 5),
                  Text(
                    'by Ryan Browne',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '“I’m going to say this very bluntly again,” he added. “Buy them only if you’re prepared to lose all your money.”',
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
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: isBookmarked ? Colors.yellow : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          isBookmarked = !isBookmarked;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.share, color: Colors.white),
                      onPressed: () {
                        _showShareOptions();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showShareOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.send),
                title: Text('Share within Dagu'),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
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
}

// Mock MessagesPage widget for demonstration
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
              backgroundColor: Colors.blue,
              child: Text('A'),
            ),
            title: Text('User 1'),
            onTap: () {
              _sendNewsToUser(context, 'User 1');
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text('B'),
            ),
            title: Text('User 2'),
            onTap: () {
              _sendNewsToUser(context, 'User 2');
            },
          ),
          // Add more ListTiles for other users as needed
        ],
      ),
    );
  }

  void _sendNewsToUser(BuildContext context, String userName) {
    // Implement the logic to send the news article to the selected user
    Navigator.pop(context); // Close the messages page after sending
  }
}
