// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tiaraamarta_mobile/services/url_service.dart';

import '../models/user_model.dart';

class UserService {
  Future<void> setTokenPreference(String token) async {
    final pref = await SharedPreferences.getInstance();
    await clearTokenPreference();
    pref.setString('token', token);
  }

  Future<String?> getTokenPreference() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }

  Future<void> clearTokenPreference() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey('token')) {
      pref.clear();
    }
  }

  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    var url = UrlService().api('login');
    var headers = {'content-type': 'application/x-www-form-urlencoded'};
    var body = {
      'username': username,
      'password': password,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserModel user = await getUser(data['access_token']);
      print(user);
      await setTokenPreference(user.token);
      return user;
    } else {
      throw jsonDecode(response.body)['data']['error'];
    }
  }

  Future<UserModel> getUser(String accessToken) async {
    var url = UrlService().api('users/me');
    var headers = {'Authorization': 'Bearer $accessToken'};

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      UserModel user = UserModel.fromJson(data['data'], accessToken);
      return user;
    } else {
      throw jsonDecode(response.body)['detail'];
    }
  }

  Future<UserModel> register({
    required String fullname,
    required String username,
    required String password,
  }) async {
    var url = UrlService().api('register');
    var headers = {'content-type': 'application/x-www-form-urlencoded'};
    var body = {
      'fullname': fullname,
      'username': username,
      'password': password,
    };

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      UserModel user = await login(username: username, password: password);
      print(user);
      return user;
    } else {
      throw jsonDecode(response.body)['data']['error'];
    }
  }
}
