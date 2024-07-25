class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String profilePic;
  final List<Topic> topicsSelected;
  final DateTime lastLogin;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePic,
    required this.topicsSelected,
    required this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'],
      profilePic: json['profile_pic'],
      topicsSelected: (json['topics_selected'] as List<dynamic>)
          .map((topicJson) => Topic.fromJson(topicJson))
          .toList(),
      lastLogin: DateTime.parse(json['last_login']),
    );
  }
}

class Topic {
  final int id;
  final String topic;

  Topic({
    required this.id,
    required this.topic,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      topic: json['topic'],
    );
  }
}
