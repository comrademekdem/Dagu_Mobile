import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final Widget child;
  final bool isSentByMe;
  final String source;

  ChatBubble(
      {required this.child, required this.isSentByMe, required this.source});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth * 0.7,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: isSentByMe ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft:
                    isSentByMe ? Radius.circular(10) : Radius.circular(0),
                bottomRight:
                    isSentByMe ? Radius.circular(0) : Radius.circular(10),
              ),
            ),
            child: child,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              'Sent from $source',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
