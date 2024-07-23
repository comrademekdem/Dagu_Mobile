class Topic {
  final int id;
  final String topic;

  Topic({required this.id, required this.topic});
}

class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  late final String email;
  final List<Topic> topicsSelected;
  final String profilePic;
  final DateTime lastLogin;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.topicsSelected,
    required this.profilePic,
    required this.lastLogin,
  });
}
