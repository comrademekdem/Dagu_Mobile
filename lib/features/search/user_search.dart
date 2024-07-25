import 'package:dagu/features/personalization/models/user.dart';
import 'package:dagu/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:dagu/utils/api_service/api_service.dart';

class UserSearchPage extends StatefulWidget {
  final User originalUser;

  UserSearchPage({required this.originalUser});

  @override
  _UserSearchPageState createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Future<User?>? searchResult;
  late Future<List<User>> _followingUsersFuture;

  @override
  void initState() {
    super.initState();
    // Fetch followed users when the page initializes
    _followingUsersFuture =
        ApiService().fetchFollowedUsers(widget.originalUser.id);
  }

  void _performSearch() {
    final username = _searchController.text.trim();
    if (username.isNotEmpty) {
      setState(() {
        // Clear the current search result
        searchResult = ApiService().fetchUserByUsername(username);
      });
    }
  }

  void _followUser(int followerId, int followingId) async {
    try {
      await ApiService().followUser(followerId, followingId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You followed the user successfully'),
        ),
      );
      // Update the followed users list after following a new user
      setState(() {
        _followingUsersFuture =
            ApiService().fetchFollowedUsers(widget.originalUser.id);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to follow user: $e'),
        ),
      );
    }
  }

  bool _isUserFollowed(User searchedUser, List<User> followedUsers) {
    return followedUsers.any((user) => user.id == searchedUser.id);
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
                    hintText: 'Search for users...',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  // Navigate to the news search page
                  Navigator.pop(context);
                },
                child: Text(
                  'Search for News',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            FutureBuilder<User?>(
              future: searchResult,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final searchedUser = snapshot.data;
                  if (searchedUser != null) {
                    return FutureBuilder<List<User>>(
                      future: _followingUsersFuture,
                      builder: (context, followedSnapshot) {
                        if (followedSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (followedSnapshot.hasError) {
                          return Center(
                              child: Text('Error: ${followedSnapshot.error}'));
                        } else if (followedSnapshot.hasData) {
                          final followedUsers = followedSnapshot.data!;
                          return _buildUserCard(searchedUser, followedUsers);
                        } else {
                          return Center(
                              child: Text('No followed users found.'));
                        }
                      },
                    );
                  } else {
                    return Center(child: Text('No user found.'));
                  }
                } else {
                  return Center(
                      child: Text('Enter a username and press search.'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(User searchedUser, List<User> followedUsers) {
    final isFollowed = _isUserFollowed(searchedUser, followedUsers);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: DaguColors.primaryColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.network(
                    searchedUser.profilePic,
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${searchedUser.firstName} ${searchedUser.lastName}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '@${searchedUser.username}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Button color
                ),
                onPressed: isFollowed
                    ? null
                    : () {
                        _followUser(widget.originalUser.id, searchedUser.id);
                      },
                child: Text(
                  isFollowed ? 'Followed' : 'Follow',
                  style: TextStyle(
                      color: DaguColors.primaryColor), // Button text color
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
