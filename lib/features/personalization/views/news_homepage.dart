import 'package:dagu/features/personalization/views/foryou_page.dart';
import 'package:dagu/features/personalization/views/socials_page.dart';
import 'package:dagu/features/profile_management/user_profile_details.dart';
import 'package:dagu/features/search/search.dart';
import 'package:dagu/utils/constants/colors.dart';
import 'package:dagu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:dagu/features/personalization/views/latest_news_card.dart';
import 'package:dagu/features/personalization/views/news_article_card.dart';
import 'package:dagu/features/personalization/views/topics_map.dart';
import 'package:dagu/models/news_aritcle.dart';
import 'package:dagu/utils/api_service/api_service.dart';
import 'package:dagu/features/personalization/models/user.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NewsHomePage extends StatefulWidget {
  final User user;

  NewsHomePage({required this.user});

  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  late Future<List<NewsArticle>> latestNews;
  late Future<List<NewsArticle>> preferredNews;
  String? selectedCategory;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    latestNews = ApiService().fetchLatestNews();
    preferredNews = ApiService().fetchPreferredNews();
  }

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
      preferredNews = ApiService().fetchNewsByCategory(category);
    });
  }

  Future<void> _reloadLatestNews() async {
    setState(() {
      latestNews = ApiService().fetchLatestNews();
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      _reloadLatestNews();
    } else if (index == 1) {
      Get.to(() => ForYouPage(
            user: widget.user,
          ));
    } else if (index == 2) {
      Get.to(() => SocialsPage(
            senderUser: widget.user,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool dark = DaguHelperFunctions.isDarkMode(context);
    return Scaffold(
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
      body: RefreshIndicator(
        onRefresh: _reloadLatestNews,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Latest News',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder<List<NewsArticle>>(
                      future: latestNews,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('No news articles available.');
                        } else {
                          return SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final article = snapshot.data![index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: LatestNewsCard(
                                      article: article, user: widget.user),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Discover More',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: TopicsMap.topicMapping.keys.map((topic) {
                          final isSelected =
                              selectedCategory == TopicsMap.topicMapping[topic];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: GestureDetector(
                              onTap: () {
                                _onCategorySelected(
                                  isSelected
                                      ? ''
                                      : TopicsMap.topicMapping[topic]!,
                                );
                              },
                              child: Chip(
                                label: Text(topic),
                                backgroundColor: isSelected
                                    ? DaguColors.primaryColor
                                    : Colors.transparent,
                                shape: StadiumBorder(
                                  side: BorderSide(
                                      color: DaguColors.primaryColor),
                                ),
                                labelStyle: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return FutureBuilder<List<NewsArticle>>(
                    future: selectedCategory == null
                        ? preferredNews
                        : ApiService().fetchNewsByCategory(selectedCategory!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No news articles available.');
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final article = snapshot.data![index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: NewsArticleCard(
                                  article: article,
                                  user: widget.user,
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  );
                },
                childCount:
                    1, // Ensure this is always 1 to avoid duplicate data loading
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
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
            icon: Icon(Icons.people),
            label: 'Socials',
          ),
        ],
        onTap: _onTabTapped,
      ),
    );
  }
}
