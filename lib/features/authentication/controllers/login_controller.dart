import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

void logUser(username, password) async {
  try {
    var response = await Dio().post(
        "https://dagu-backend.onrender.com/auth/token/",
        data: {"username": username, "password": password});
    var data = response.data as Map<String, dynamic>;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogged', data['access'] != null ? true : false);
  } catch (e) {
    print(e);
  }
}
