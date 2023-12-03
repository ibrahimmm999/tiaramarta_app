import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/user_service.dart';

class UserProvider extends ChangeNotifier {
  late UserModel _user;
  String _errorMessage = "";

  UserModel get user => _user;
  String get errorMessage => _errorMessage;

  set setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    try {
      _user = await UserService().login(
        username: username,
        password: password,
      );
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> register({
    required String fullname,
    required String username,
    required String password,
  }) async {
    try {
      _user = await UserService().register(
        fullname: fullname,
        username: username,
        password: password,
      );
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> getUser({required String token}) async {
    try {
      UserModel user = await UserService().getUser(token);
      _user = user;
      return true;
    } catch (e) {
      return false;
    }
  }
}
