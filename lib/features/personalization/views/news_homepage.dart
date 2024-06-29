import 'package:dagu/utils/constants/colors.dart';
import 'package:dagu/utils/constants/sizes.dart';
import 'package:dagu/utils/helpers/helper_functions.dart';
import 'package:dagu/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class NewsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: DaguAppTheme.lightTheme,
      darkTheme: DaguAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool dark = DaguHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications,
                color: dark ? Colors.white : DaguColors.primaryColor),
            onPressed: () {},
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
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class LatestNewsCard extends StatelessWidget {
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

class NewsArticleCard extends StatelessWidget {
  final String title;
  final String author;
  final String date;

  NewsArticleCard({
    required this.title,
    required this.author,
    required this.date,
  });

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
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'by $author',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                  SizedBox(height: 5),
                  Text(
                    date,
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search News'),
      ),
      body: Center(
        child: Text('Search Page Content'),
      ),
    );
  }
}
