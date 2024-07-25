import 'package:dagu/features/messages/views/chat_view.dart';
import 'package:dagu/features/personalization/views/foryou_page.dart';
import 'package:dagu/features/personalization/views/news_homepage.dart';
import 'package:dagu/models/news_aritcle.dart';
import 'package:dagu/utils/constants/colors.dart';
import 'package:dagu/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dagu/features/personalization/models/user.dart';
import 'package:dagu/utils/api_service/api_service.dart';
// import 'package:dagu/models/news_article.dart';

class SocialsPage extends StatefulWidget {
  final User senderUser;
  final NewsArticle? articleToShare;

  SocialsPage({required this.senderUser, this.articleToShare});

  @override
  _SocialsPageState createState() => _SocialsPageState();
}

class _SocialsPageState extends State<SocialsPage> {
  int _currentIndex = 2;
  late Future<List<User>> _followingUsersFuture;

  @override
  void initState() {
    super.initState();
    _followingUsersFuture =
        ApiService().fetchFollowedUsers(widget.senderUser.id);
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      Get.to(() => NewsHomePage(user: widget.senderUser));
    } else if (index == 1) {
      Get.to(() => ForYouPage(user: widget.senderUser));
    }
  }

  void _navigateToChat(User senderUser, User receiverUser) {
    Get.to(() => ChatPage(senderUser: senderUser, receiverUser: receiverUser));
  }

  Future<void> _confirmUnfollow(User recieverUser) async {
    final shouldUnfollow = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Unfollow'),
        content: Text(
            'Are you sure you want to unfollow ${recieverUser.firstName} ${recieverUser.lastName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
        ],
      ),
    );

    if (shouldUnfollow == true) {
      try {
        await ApiService().unfollowUser(widget.senderUser.id, recieverUser.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'You have unfollowed ${recieverUser.firstName} ${recieverUser.lastName}'),
          ),
        );
        // Refresh the following users list
        setState(() {
          _followingUsersFuture =
              ApiService().fetchFollowedUsers(widget.senderUser.id);
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to unfollow user: $e'),
          ),
        );
      }
    }
  }

  Future<void> _refreshFollowedUsers() async {
    // Refresh the following users list
    setState(() {
      _followingUsersFuture =
          ApiService().fetchFollowedUsers(widget.senderUser.id);
    });
  }

  Future<void> _shareArticle(User recieverUser) async {
    if (widget.articleToShare == null) {
      return;
    }
    int newsId = await ApiService().storeNewsArticle(widget.articleToShare!);
    print(newsId);
    await ApiService()
        .shareArticle(widget.senderUser.id, recieverUser.id, newsId);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Article shared with ${recieverUser.firstName} ${recieverUser.lastName}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Socials'),
        // backgroundColor: AppColors.appBarColor,
      ),
      body: FutureBuilder<List<User>>(
        future: _followingUsersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No followed users'));
          } else {
            List<User> followedUsers = snapshot.data!;
            return RefreshIndicator(
              onRefresh: _refreshFollowedUsers,
              child: ListView.builder(
                itemCount: followedUsers.length,
                itemBuilder: (context, index) {
                  User recieverUser = followedUsers[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(recieverUser.profilePic),
                    ),
                    title: Text(
                        '${recieverUser.firstName} ${recieverUser.lastName}'),
                    subtitle: Text('@${recieverUser.username}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.message),
                          onPressed: () =>
                              _navigateToChat(widget.senderUser, recieverUser),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _confirmUnfollow(recieverUser),
                        ),
                        if (widget.articleToShare != null)
                          IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () => _shareArticle(recieverUser),
                          ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        // selectedItemColor: D,
        // unselectedItemColor: AppColors.unselectedIconColor,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'For Your',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Socials',
          ),
        ],
      ),
    );
  }
}
