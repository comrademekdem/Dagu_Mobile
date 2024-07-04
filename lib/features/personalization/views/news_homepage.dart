import 'package:dagu/features/messages/views/messages.dart';
import 'package:dagu/features/personalization/views/foryou_page.dart';
import 'package:dagu/features/personalization/views/preferences_choice.dart';
import 'package:dagu/features/profile_management/user_profile_details.dart';
import 'package:dagu/features/search/search.dart';
import 'package:dagu/utils/constants/colors.dart';
import 'package:dagu/utils/constants/sizes.dart';
import 'package:dagu/utils/helpers/helper_functions.dart';
import 'package:dagu/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart'; // Import the share_plus package

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
            padding: const EdgeInsets.only(
                left: 23), // Adjust the left padding as needed
            child: Image.asset(
              'assets/images/logo.png', // Replace with your logo asset path
              height: 40, // Adjust the height as needed
            ),
          ),
          title: Text("Home"),
          // Optional: Keep this if you want to keep the title text
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
                // Latest News Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
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
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Discover More Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
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
                NewsArticleCard(
                  title: '5 things to know about the \'conundrum\' of lupus',
                  author: 'Matt Villano',
                  date: 'Sunday, 9 May 2021',
                ),
                SizedBox(height: 20),
                NewsArticleCard(
                  title: '4 ways families can ease anxiety together',
                  author: 'Zain Korsgaard',
                  date: 'Sunday, 9 May 2021',
                ),
                SizedBox(height: 20),
                NewsArticleCard(
                  title:
                      'Crypto investors should be prepared to lose all their money, BOE governor says',
                  author: 'Ryan Browne',
                  date: 'Monday, 10 May 2021',
                ),
                SizedBox(height: 20),
                NewsArticleCard(
                  title: 'The future of technology in finance',
                  author: 'John Doe',
                  date: 'Tuesday, 11 May 2021',
                ),
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
              Get.to(() => MessagesPage());
            }
          },
        ),
      ),
    );
  }
}

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
                        if (!isLiked) {
                          if (!isLiked) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('News Article added to Liked.')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('News Article removed from Liked.')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('News Article removed from Liked.')),
                          );
                        }
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
                        if (!isBookmarked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('News Article added to Saved.')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('News Article removed from Saved.')),
                          );
                        }
                        setState(() {
                          isBookmarked = !isBookmarked;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.share, color: Colors.white),
                      onPressed: () {
                        Share.share(
                          'Check out this news article: Crypto investors should be prepared to lose all their money, BOE governor says',
                          subject: 'News Article',
                        );
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
}

class CategoryChip extends StatelessWidget {
  final String label;

  CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.transparent,
      shape: StadiumBorder(
        side: BorderSide(color: DaguColors.primaryColor),
      ),
      labelStyle: TextStyle(
        color: DaguColors.primaryColor,
      ),
    );
  }
}

class NewsArticleCard extends StatefulWidget {
  final String title;
  final String author;
  final String date;

  NewsArticleCard({
    required this.title,
    required this.author,
    required this.date,
  });

  @override
  _NewsArticleCardState createState() => _NewsArticleCardState();
}

class _NewsArticleCardState extends State<NewsArticleCard> {
  bool isLiked = false;
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: double.infinity,
        height: 250,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/homepage_placeholder_2.jpeg',
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
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'by ${widget.author}',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.date,
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
                        if (!isLiked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('News Article added to Liked.')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('News Article removed from Liked.')),
                          );
                        }

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
                        if (!isBookmarked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('News Article added to Liked.')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('News Article removed from Liked.')),
                          );
                        }
                        setState(() {
                          isBookmarked = !isBookmarked;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.share, color: Colors.white),
                      onPressed: () {
                        Share.share(
                          'Check out this news article: ${widget.title} by ${widget.author} on ${widget.date}',
                          subject: 'News Article',
                        );
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
}
