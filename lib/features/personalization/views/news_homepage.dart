import 'package:dagu/features/messages/views/messages.dart';
import 'package:dagu/features/personalization/views/category_chip.dart';
import 'package:dagu/features/personalization/views/foryou_page.dart';
import 'package:dagu/features/personalization/views/latest_news_card.dart';
import 'package:dagu/features/personalization/views/news_article_card.dart';
import 'package:dagu/features/profile_management/user_profile_details.dart';
import 'package:dagu/features/search/search.dart';
// import 'package:dagu/features/search/search_page.dart';
import 'package:dagu/utils/constants/colors.dart';
import 'package:dagu/utils/constants/sizes.dart';
import 'package:dagu/utils/helpers/helper_functions.dart';
import 'package:dagu/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsHomePage extends StatefulWidget {
  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 1) {
      Get.to(() => ForYouPage());
    } else if (index == 2) {
      Get.to(() => MessagesPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    bool dark = DaguHelperFunctions.isDarkMode(context);
    return MaterialApp(
      title: 'Profile Page',
      theme: DaguAppTheme.lightTheme,
      darkTheme: DaguAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 23),
            child: Image.asset(
              'assets/images/logo.png',
              height: 40,
            ),
          ),
          title: Text("Home"),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Get.to(() => SearchPage());
              },
            ),
            IconButton(
              icon: Icon(Icons.person,
                  color: dark ? Colors.white : DaguColors.primaryColor),
              onPressed: () {
                Get.to(() => ProfilePage());
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              DaguSizes.defaultSpace,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 18, bottom: 18, left: 0, right: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Latest News',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to see more page
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'See All',
                              style: TextStyle(
                                color: DaguColors.primaryColor,
                              ),
                            ),
                            Icon(Icons.arrow_forward,
                                color: DaguColors.primaryColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Horizontally scrollable news cards
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      LatestNewsCard(articleUrl: "https://example.com"),
                      SizedBox(width: 10),
                      LatestNewsCard(articleUrl: "https://example.com"),
                      SizedBox(width: 10),
                      LatestNewsCard(articleUrl: "https://example.com"),
                      SizedBox(width: 10),
                      LatestNewsCard(articleUrl: "https://example.com"),
                      SizedBox(width: 10),
                      LatestNewsCard(articleUrl: "https://example.com"),
                      SizedBox(width: 10),
                      LatestNewsCard(articleUrl: "https://example.com"),
                      SizedBox(width: 10),
                      LatestNewsCard(articleUrl: "https://example.com"),
                      SizedBox(width: 10),
                      LatestNewsCard(articleUrl: "https://example.com"),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(
                      top: 18, bottom: 18, left: 0, right: 0),
                  child: Text(
                    'Discover More',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Horizontally scrollable categories
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CategoryChip(label: 'Healthy'),
                      SizedBox(width: 10),
                      CategoryChip(label: 'Technology'),
                      SizedBox(width: 10),
                      CategoryChip(label: 'Finance'),
                      SizedBox(width: 10),
                      CategoryChip(label: 'Arts'),
                      SizedBox(width: 10),
                      CategoryChip(label: 'Sports'),
                      SizedBox(width: 10),
                      CategoryChip(label: 'Politics'),
                      SizedBox(width: 10),
                      CategoryChip(label: 'Science'),
                      SizedBox(width: 10),
                      CategoryChip(label: 'Education'),
                      SizedBox(width: 10),
                      CategoryChip(label: 'Travel'),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Vertically scrollable news articles with text over images
                NewsArticleCard(articleUrl: "https://example.com"),
                SizedBox(height: 20),
                NewsArticleCard(articleUrl: "https://example.com"),
                SizedBox(height: 20),
                NewsArticleCard(articleUrl: "https://example.com"),
                SizedBox(height: 20),
                NewsArticleCard(articleUrl: "https://example.com"),
                SizedBox(height: 20),
                NewsArticleCard(articleUrl: "https://example.com"),
                SizedBox(height: 20),
                NewsArticleCard(articleUrl: "https://example.com"),
                SizedBox(height: 20),
                NewsArticleCard(articleUrl: "https://example.com"),
                SizedBox(height: 20),
                NewsArticleCard(articleUrl: "https://example.com"),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex, // Add this line
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
      ),
    );
  }
}
