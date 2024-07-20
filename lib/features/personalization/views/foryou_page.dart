import 'package:dagu/features/messages/views/messages.dart';
import 'package:dagu/features/personalization/views/liked_news_card.dart';
import 'package:dagu/features/personalization/views/news_homepage.dart';
import 'package:dagu/features/personalization/views/saved_news_card.dart';
import 'package:dagu/features/personalization/views/section_header.dart';
import 'package:dagu/features/personalization/views/see_more.dart';
import 'package:dagu/features/profile_management/user_profile_details.dart';
import 'package:dagu/utils/constants/colors.dart';
import 'package:dagu/utils/constants/sizes.dart';
import 'package:dagu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForYouPage extends StatefulWidget {
  @override
  _ForYouPageState createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage> {
  int _currentIndex = 1;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      Get.to(() => NewsHomePage());
    } else if (index == 2) {
      Get.to(() => MessagesPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    bool dark = DaguHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('For You'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DaguSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: 'Liked by You'),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  LikedNewsCard(),
                  SizedBox(height: 10),
                  LikedNewsCard(),
                  SizedBox(height: 10),
                  LikedNewsCard(),
                  SizedBox(height: 10),
                  LikedNewsCard(),
                  SizedBox(height: 10),
                  SeeMoreLikedButton(), // See More button added here
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(
              color: dark ? DaguColors.darkGrey : DaguColors.grey,
              thickness: 0.8,
              indent: 1,
              // endIndent: 20,
            ),
            SizedBox(height: 10),
            SectionHeader(title: 'Saved by You'),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SavedNewsCard(),
                  SizedBox(height: 10),
                  SavedNewsCard(),
                  SizedBox(height: 10),
                  SavedNewsCard(),
                  SizedBox(height: 10),
                  SavedNewsCard(),
                  SizedBox(height: 10),
                  SeeMoreSavedButton(), // See More button added here
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Highlight the selected item
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'For You',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
        ],
        onTap: _onTabTapped,
      ),
    );
  }
}
