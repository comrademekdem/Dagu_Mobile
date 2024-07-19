import 'package:dagu/features/messages/views/messages.dart';
import 'package:dagu/features/personalization/views/category_chip.dart';
import 'package:dagu/features/personalization/views/foryou_page.dart';
import 'package:dagu/features/personalization/views/news_article_card.dart';
import 'package:dagu/features/personalization/views/preferences_choice.dart';
import 'package:dagu/features/profile_management/user_profile_details.dart';
import 'package:dagu/features/search/search.dart';
import 'package:dagu/utils/constants/colors.dart';
import 'package:dagu/utils/constants/sizes.dart';
import 'package:dagu/utils/helpers/helper_functions.dart';
import 'package:dagu/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class NewsHomePage extends StatefulWidget {
  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
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
                        child: Text(
                          'See All',
                          style: TextStyle(
                            color: DaguColors.primaryColor,
                          ),
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
                      LatestNewsCard(),
                      SizedBox(width: 10),
                      LatestNewsCard(),
                      SizedBox(width: 10),
                      LatestNewsCard(),
                      SizedBox(width: 10),
                      LatestNewsCard(),
                      SizedBox(width: 10),
                      LatestNewsCard(),
                      SizedBox(width: 10),
                      LatestNewsCard(),
                      SizedBox(width: 10),
                      LatestNewsCard(),
                      SizedBox(width: 10),
                      LatestNewsCard(),
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
                // NewsArticleCard(
                //   title: '5 things to know about the \'conundrum\' of lupus',
                //   author: 'Matt Villano',
                //   date: 'Sunday, 9 May 2021',
                //   sourceUrl: 'https://example.com',
                // ),
                // SizedBox(height: 20),
                // NewsArticleCard(
                //   title: '4 ways families can ease anxiety together',
                //   author: 'Zain Korsgaard',
                //   date: 'Sunday, 9 May 2021',
                //   sourceUrl: 'https://example.com',
                // ),
                // SizedBox(height: 20),
                // NewsArticleCard(
                //   title:
                //       'Crypto investors should be prepared to lose all their money, BOE governor says',
                //   author: 'Ryan Browne',
                //   date: 'Monday, 10 May 2021',
                //   sourceUrl: 'https://example.com',
                // ),
                // SizedBox(height: 20),
                // NewsArticleCard(
                //   title: 'The future of technology in finance',
                //   author: 'John Doe',
                //   date: 'Tuesday, 11 May 2021',
                //   sourceUrl: 'https://example.com',
                // ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
          onTap: (int index) {
            if (index == 0) {
            } else if (index == 1) {
              Get.to(() => ForYouPage());
            } else if (index == 2) {
              // Get.to(() => MessagesPage());
            }
          },
        ),
      ),
    );
  }
}
