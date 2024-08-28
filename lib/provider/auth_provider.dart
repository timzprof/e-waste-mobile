import 'dart:convert';

import 'package:ewaste/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ewaste/models/user.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider();

  bool _isLoading = false;

  bool _isAuthenticated = false;
  User? _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  User? get user => _user;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future loadData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString('user');

      if (userJson != null) {
        User user = User.fromJson(json.decode(userJson));

        _user = user;
        _isAuthenticated = true;
      }
      notifyListeners();
    } catch (err) {
      print('Caught loading user error: $err');
    }
  }

  Future registerUser(
      {required String name,
      required String email,
      required String sensorId,
      required String password}) async {
    try {
      setLoading(true);
      var response = await register(
          name: name, email: email, sensorId: sensorId, password: password);

      return response;
    } catch (err) {
      print('Caught user registration error: $err');
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future login({required String email, required String password}) async {
    try {
      setLoading(true);
      User? user = await authenticate(email: email, password: password);

      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', user.token);
        await prefs.setString('user', json.encode(user.toJson()));

        _user = user;
        _isAuthenticated = true;
      }

      notifyListeners();
    } catch (err) {
      print('Caught user authentication error: $err');
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future logout() async {
    try {
      setLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      _user = null;
      _isAuthenticated = false;

      notifyListeners();
    } catch (err) {
      print('Caught logout error: $err');
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
