import 'dart:convert';
import 'dart:math';
import 'package:dagu/features/personalization/models/user.dart';
import 'package:dagu/features/personalization/views/topics_map.dart';
import 'package:dagu/models/news_aritcle.dart';
import 'package:dagu/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://dagu-backend.onrender.com';
  static const String MailgunbaseUrl = 'https://api.mailgun.net/v3';
  final String apiKey = APIConstants.apiKey;
  final String newsApibaseUrl = 'https://newsapi.org/v2/everything';

  Future<void> register(String username, String firstName, String lastName,
      String password, String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'password': password,
        'email': email,
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Registration successful');
    }
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/token/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> getUserDetails(String token, int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/news/users/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('User details response status: ${response.statusCode}');
      print('User details response body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        print('User not found: ${response.statusCode}');
        throw Exception('User not found');
      } else {
        print('Failed to get user details: ${response.statusCode}');
        throw Exception('Failed to get user details');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<void> setUserPreferences(User user, List<String> preferences) async {
    int id = user.id;
    final response = await http.patch(
      Uri.parse('$baseUrl/news/users/$id'),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'topics_selected': preferences
            .map((topic) => {
                  'id':
                      0, // Backend might not need this, or could be used for reference
                  'topic': topic
                })
            .toList()
      }),
    );

    if (response.statusCode == 200) {
      print('Preferences updated successfully');
    } else {
      print('Failed to update preferences: ${response.statusCode}');
      throw Exception('Failed to update preferences');
    }
  }

  Future<void> likeArticle(int userId, int newsId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/news/liked/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': userId,
        'news_id': newsId,
        'liked': true,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Handle successful response
      print('Article liked successfully');
    } else {
      // Handle error
      print('Failed to like article');
      print(response.body);
    }
  }

  Future<void> bookmarkArticle(int userId, int newsId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/news/bookmarked/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': userId,
        'news_id': newsId,
        'bookmarked': true,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Handle successful response
      print('Article Bookmarked successfully');
    } else {
      // Handle error
      print('Failed to bookmark article');
      print(response.body);
    }
  }

  Future<void> updateUserDetails(int userId, String firstName, String lastName,
      String username, String profilePic, String email) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/news/users/$userId'),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'first_name': firstName,
        'last_name': lastName,
        'username': username,
        'profile_pic': profilePic,
        'email': email,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('User details updated successfully');
    } else {
      print('Failed to update user details: ${response.statusCode}');
      print(response.body);
      throw Exception('Failed to update user details');
    }
  }

  Future<void> sendOTPEmail(String email, String otp) async {
    final apiKey = APIConstants.OTPApiKey;
    final domain = APIConstants.sandboxDomain;
    final url = Uri.parse('$MailgunbaseUrl/$domain/messages');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Basic ' + base64Encode(utf8.encode('api:$apiKey')),
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'from': 'Dagunewsteam@dagu.com',
        'to': email,
        'subject': 'Your OTP Code',
        'text':
            'Your OTP code is $otp. Please do not share this code with anyone but us.',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('OTP sent successfully.');
    } else {
      print('Failed to send OTP: ${response.body}');
    }
  }

  Future<List<NewsArticle>> fetchLikedNews(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/news/liked/$id'),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> body = jsonDecode(response.body);
      List<NewsArticle> articles =
          body.map((dynamic item) => NewsArticle.fromDaguJson(item)).toList();
      return articles;
    } else {
      print(response.body);
      throw Exception('Failed to load liked news');
    }
  }

  Future<List<NewsArticle>> fetchBookmarkedNews(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/news/bookmarked/$id'),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> body = jsonDecode(response.body);
      List<NewsArticle> articles =
          body.map((dynamic item) => NewsArticle.fromDaguJson(item)).toList();
      return articles;
    } else {
      print(response.body);
      throw Exception('Failed to load Bookmarked news');
    }
  }

  Future<int> storeNewsArticle(NewsArticle article) async {
    final response = await http.post(
      Uri.parse('$baseUrl/news/list/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(article.toJson()),
    );

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      final newsId = jsonResponse['news_id'];
      print(response.body);
      return newsId;
    } else {
      print(response.body);
      throw Exception('Failed to store article');
    }
  }

  Future<List<NewsArticle>> fetchLatestNews() async {
    List<String> topics = TopicsMap.topicMapping.keys.toList();
    int randomIndex = Random().nextInt(topics.length);
    String selectedTopic =
        TopicsMap.topicMapping[topics[randomIndex]] ?? 'politics';
    final response = await http.get(Uri.parse(
        '$newsApibaseUrl?q=$selectedTopic&page=1&pageSize=20&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> articlesJson = jsonData['articles'];

      return articlesJson.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<NewsArticle>> fetchPreferredNews() async {
    final response = await http.get(Uri.parse(
        '$newsApibaseUrl?q=politics&page=1&pageSize=20&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> articlesJson = jsonData['articles'];

      return articlesJson.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<NewsArticle>> fetchNewsByCategory(String category) async {
    final response = await http.get(Uri.parse(
        '$newsApibaseUrl?q=$category&page=1&pageSize=20&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> articlesJson = jsonData['articles'];

      return articlesJson.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      print(response);
      throw Exception('Failed to load news');
    }
  }

  Future<List<NewsArticle>> searchArticles(String query) async {
    final response = await http.get(Uri.parse(
        '$newsApibaseUrl?q="$query"&searchIn=title,description,content&language=en&pageSize=20&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> articlesJson = jsonData['articles'];

      return articlesJson.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load search articles');
    }
  }

  Future<void> removeLikedArticle(int userId, int newsId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/news/liked/$userId/$newsId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 204) {
      // Handle successful response
      print('Article removed from liked successfully');
    } else {
      // Handle error
      print('Failed to remove liked article');
      print(response.body);
    }
  }

  Future<User?> fetchUserByUsername(String username) async {
    final response =
        await http.get(Uri.parse('$baseUrl/news/users/?search=$username'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      // Assuming the API returns a list of users and you want the first match
      if (jsonData.isNotEmpty) {
        return User.fromJson(
            jsonData[0]); // Assuming the user model has a fromJson method
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<void> followUser(int followerId, int followingId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/news/follow/$followerId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"follower": followerId, "following": followingId}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('User followed successfully');
    } else {
      print('Failed to follow user: ${response.statusCode}');
      print(response.body);
      throw Exception('Failed to follow user');
    }
  }

  Future<List<User>> fetchFollowedUsers(int userId) async {
    final url = '$baseUrl/news/follow/$userId';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final Set<int> seenUserIds = {};
        final List<User> uniqueFollowedUsers = [];

        for (var userJson in data) {
          final userMap = userJson['followed_user'] as Map<String, dynamic>;
          final user = User.fromJson(userMap);

          if (!seenUserIds.contains(user.id)) {
            seenUserIds.add(user.id);
            uniqueFollowedUsers.add(user);
          }
        }

        return uniqueFollowedUsers;
      } else {
        // Handle unexpected status codes
        throw Exception('Failed to load followed users');
      }
    } catch (e) {
      // Handle network errors or other exceptions
      print('Error: $e');
      // Return an empty list to ensure the return type is always satisfied
      return <User>[]; // Use a literal empty list
    }
  }

  Future<void> unfollowUser(int followerId, int followedId) async {
    final url = '$baseUrl/news/follow/$followerId/$followedId';
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode != 204) {
      throw Exception('Failed to unfollow user');
    }
  }

  Future<void> shareArticle(int senderId, int receiverId, int newsId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/news/shared/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'news_id': newsId,
        'source': senderId,
        'destination': receiverId,
      }),
    );
    print(response.body);
    if (response.statusCode != 201) {
      print(response.body);
      throw Exception('Failed to share article: ${response.body}');
    }
  }

  Future<List<NewsArticle>> getSharedNews(int id, int sourceUserId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/news/shared/$id'),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> body = jsonDecode(response.body);

      // Filter the articles to only include those from the specified source user
      List<NewsArticle> articles = body
          .where((dynamic item) => item['source'] == sourceUserId)
          .map((dynamic item) => NewsArticle.fromSharedJson(item))
          .toList();
      return articles;
    } else {
      throw Exception('Failed to load shared news');
    }
  }
}
