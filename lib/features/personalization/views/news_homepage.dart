import 'package:dagu/features/messages/views/messages.dart';
import 'package:dagu/features/personalization/models/user.dart';
import 'package:dagu/features/personalization/views/category_chip.dart';
import 'package:dagu/features/personalization/views/news_article_card.dart';
import 'package:dagu/models/news_aritcle.dart';
import 'package:dagu/utils/api_service/news_service.dart';
import 'package:flutter/material.dart';
import 'package:dagu/features/personalization/views/foryou_page.dart';
import 'package:dagu/features/personalization/views/latest_news_card.dart';
import 'package:dagu/features/profile_management/user_profile_details.dart';
import 'package:dagu/features/search/search.dart';
import 'package:dagu/utils/constants/colors.dart';
import 'package:dagu/utils/constants/sizes.dart';
import 'package:dagu/utils/helpers/helper_functions.dart';
import 'package:dagu/utils/theme/theme.dart';
import 'package:get/get.dart';

class NewsHomePage extends StatefulWidget {
  final User user;

  NewsHomePage({required this.user});

  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  int _currentIndex = 0;
  late Future<List<NewsArticle>> _newsArticles;

  @override
  void initState() {
    super.initState();
    _newsArticles = NewsService().fetchNews();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 1) {
      Get.to(() => ForYouPage(
            user: widget.user,
          ));
    } else if (index == 2) {
      Get.to(() => MessagesPage(
            user: widget.user,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool dark = DaguHelperFunctions.isDarkMode(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Home Page',
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
                Get.to(() => SearchPage(
                      user: widget.user,
                    ));
              },
            ),
            IconButton(
              icon: Icon(Icons.person,
                  color: dark ? Colors.white : DaguColors.primaryColor),
              onPressed: () {
                Get.to(() => ProfilePage(
                      user: widget.user,
                    ));
              },
            ),
          ],
        ),
        body: FutureBuilder<List<NewsArticle>>(
          future: _newsArticles,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print("This error");
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No news articles found.'));
            } else {
              final articles = snapshot.data!;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(DaguSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Latest News',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      // Horizontally scrollable latest news cards
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: articles
                              .take(8)
                              .map((article) => Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: LatestNewsCard(
                                      article: article,
                                      user: widget.user,
                                    ),
                                  ))
                              .toList(),
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
                          children: widget.user.topicsSelected.map((topic) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: CategoryChip(label: topic.topic),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Vertically scrollable news articles
                      Column(
                        children: articles
                            .map((article) => Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: NewsArticleCard(
                                      article: article,
                                      articleUrl: article.url,
                                      user: widget.user),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'For You',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
          ],
        ),
      ),
    );
  }
}
