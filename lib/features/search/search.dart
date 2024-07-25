import 'package:dagu/features/search/user_search.dart';
import 'package:flutter/material.dart';
import 'package:dagu/features/personalization/models/user.dart';
import 'package:dagu/utils/api_service/api_service.dart';
import 'package:dagu/models/news_aritcle.dart';
import 'package:dagu/features/personalization/views/news_article_card.dart';

class SearchPage extends StatefulWidget {
  final User user;

  SearchPage({required this.user});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchText = "";
  Future<List<NewsArticle>>? searchResults;

  void _performSearch() async {
    setState(() {
      searchText = _searchController.text.trim();
      searchResults = ApiService().fetchNewsByCategory(searchText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onSubmitted: (_) => _performSearch(),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: _performSearch,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                // Navigate to user search page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserSearchPage(
                      originalUser: widget.user,
                    ),
                  ),
                );
              },
              child: Text(
                'Search for Users Instead',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          Expanded(
            child: searchText.isEmpty
                ? Center(child: Text('Enter a search term'))
                : FutureBuilder<List<NewsArticle>>(
                    future: searchResults,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No news articles found.'));
                      } else {
                        return ListView.builder(
                          padding: const EdgeInsets.all(8.0),
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
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
