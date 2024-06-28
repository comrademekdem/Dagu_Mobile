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
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search News',
                        suffixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color:
                                dark ? Colors.white : DaguColors.primaryColor,
                            width: 5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color:
                                dark ? Colors.white : DaguColors.primaryColor,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: DaguColors.primaryColor,
                            width: 1,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications,
                        color: dark ? Colors.white : DaguColors.primaryColor),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox()
            ],
          ),
        ),
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

              const SizedBox(height: 10),
              LatestNewsCard(),
              SizedBox(height: 20),

              // Categories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryChip(label: 'Healthy'),
                  CategoryChip(label: 'Technology'),
                  CategoryChip(label: 'Finance'),
                  CategoryChip(label: 'Arts'),
                  CategoryChip(label: 'Sports'),
                ],
              ),
              SizedBox(height: 20),

              // News Articles
              NewsArticleCard(
                title: '5 things to know about the \'conundrum\' of lupus',
                author: 'Matt Villano',
                date: 'Sunday, 9 May 2021',
              ),
              NewsArticleCard(
                title: '4 ways families can ease anxiety together',
                author: 'Zain Korsgaard',
                date: 'Sunday, 9 May 2021',
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              'assets/images/homepage_placeholder_1.jpeg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Crypto investors should be prepared to lose all their money, BOE governor says',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'by Ryan Browne',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 5),
                Text(
                  '“I’m going to say this very bluntly again,” he added. “Buy them only if you’re prepared to lose all your money.”',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
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
      backgroundColor: Colors.purple.withOpacity(0.1),
      labelStyle: TextStyle(color: Colors.purple),
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/homepage_placeholder_1.jpeg',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'by $author',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 5),
            Text(
              date,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
