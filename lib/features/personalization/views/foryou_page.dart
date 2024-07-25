import 'package:dagu/features/messages/views/messages.dart';
import 'package:dagu/features/personalization/models/user.dart';
import 'package:dagu/features/personalization/views/liked_news_card.dart';
import 'package:dagu/features/personalization/views/news_homepage.dart';
import 'package:dagu/features/personalization/views/saved_news_card.dart';
import 'package:dagu/features/personalization/views/section_header.dart';
import 'package:dagu/features/personalization/views/see_more.dart';
import 'package:dagu/features/personalization/views/socials_page.dart';
import 'package:dagu/models/news_aritcle.dart';
import 'package:dagu/utils/api_service/api_service.dart';
import 'package:dagu/utils/constants/colors.dart';
import 'package:dagu/utils/constants/sizes.dart';
import 'package:dagu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForYouPage extends StatefulWidget {
  final User user;

  ForYouPage({required this.user});

  @override
  _ForYouPageState createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage> {
  int _currentIndex = 1;
  int _selectedTabIndex = 0; // Add a variable to track the selected tab
  late Future<List<NewsArticle>> _likedNewsFuture;
  late Future<List<NewsArticle>>
      _bookmarkedNewsFuture; // Future for bookmarked news
  PageController _pageController =
      PageController(initialPage: 0); // PageController for swipe functionality

  @override
  void initState() {
    super.initState();
    _likedNewsFuture = ApiService().fetchLikedNews(widget.user.id);
    _bookmarkedNewsFuture = ApiService()
        .fetchBookmarkedNews(widget.user.id); // Fetch bookmarked news
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      Get.to(() => NewsHomePage(user: widget.user));
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
        title: Text('For You'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20), // Space to lower the tab switcher
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: DaguSizes.defaultSpace),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTabIndex = 0;
                      _pageController.jumpToPage(0); // Switch to liked page
                    });
                  },
                  child: Text(
                    'Liked',
                    style: TextStyle(
                      fontSize: 20, // Increase font size
                      color: _selectedTabIndex == 0
                          ? DaguColors.primaryColor
                          : Colors.black,
                      fontWeight: _selectedTabIndex == 0
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTabIndex = 1;
                      _pageController
                          .jumpToPage(1); // Switch to bookmarked page
                    });
                  },
                  child: Text(
                    'Bookmarked',
                    style: TextStyle(
                      fontSize: 20, // Increase font size
                      color: _selectedTabIndex == 1
                          ? DaguColors.primaryColor
                          : Colors.black,
                      fontWeight: _selectedTabIndex == 1
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              children: [
                _buildLikedNewsSection(), // Function to build liked news section
                _buildBookmarkedNewsSection(), // Function to build bookmarked news section
              ],
            ),
          ),
        ],
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

  // Function to build the liked news section
  Widget _buildLikedNewsSection() {
    return FutureBuilder<List<NewsArticle>>(
      future: _likedNewsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No liked news articles'));
        }

        final articles = _removeDuplicateArticles(snapshot.data!);
        return SingleChildScrollView(
          padding: const EdgeInsets.all(DaguSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...articles.map((article) {
                return Column(
                  children: [
                    LikedNewsCard(article: article, user: widget.user),
                    SizedBox(height: 10),
                  ],
                );
              }).toList(),
              SeeMoreLikedButton(), // See More button added here
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // Function to build the bookmarked news section
  Widget _buildBookmarkedNewsSection() {
    return FutureBuilder<List<NewsArticle>>(
      future: _bookmarkedNewsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No bookmarked news articles'));
        }

        final articles = _removeDuplicateArticles(snapshot.data!);
        return SingleChildScrollView(
          padding: const EdgeInsets.all(DaguSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...articles.map((article) {
                return Column(
                  children: [
                    SavedNewsCard(article: article, user: widget.user),
                    SizedBox(height: 10),
                  ],
                );
              }).toList(),
              SeeMoreSavedButton(), // See More button added here
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // Remove duplicate articles based on the first 20 characters of the description
  List<NewsArticle> _removeDuplicateArticles(List<NewsArticle> articles) {
    Set<String> uniqueDescriptions = {};
    List<NewsArticle> uniqueArticles = [];

    for (var article in articles) {
      // Use the entire description if it's shorter than 20 characters
      String uniqueId = article.description.length > 20
          ? article.description.substring(0, 20)
          : article.description;

      if (!uniqueDescriptions.contains(uniqueId)) {
        uniqueDescriptions.add(uniqueId);
        uniqueArticles.add(article);
      }
    }

    return uniqueArticles;
  }
}
