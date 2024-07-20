import 'package:dagu/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class SeeMoreLikedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Handle "See More" logic
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.favorite,
              // color: Colors.red,
              size: 18,
            ),
            SizedBox(width: 10),
            Text('See More'),
            SizedBox(width: 10),
            Icon(
              Icons.arrow_forward,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class SeeMoreSavedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Handle "See More" logic
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.bookmark,
              // color: Colors.yellow,
              size: 18,
            ),
            SizedBox(width: 10),
            Text('See More'),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward, size: 18),
          ],
        ),
      ),
    );
  }
}
