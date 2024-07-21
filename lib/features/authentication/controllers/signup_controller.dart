import 'package:dio/dio.dart';

void registerUser(firstname, lastname, username, email, password) async {
  try {
    var response = await Dio()
        .post("https://dagu-backend.onrender.com/auth/api/register", data: {
      "first_name": firstname,
      "last_name": lastname,
      "username": username,
      "email": email,
      "password": password,
    });
    print(response);
  } catch (e) {
    print(e);
  }
}
