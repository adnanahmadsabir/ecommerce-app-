import 'dart:convert';

import 'package:clothes_app/data/models/user_model.dart';
import 'package:clothes_app/domain/entities/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  // save user auth data
  static const _currentUser = "current_user";

  Future<void> setBool(String key,bool value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(key, value);
  }

  Future<bool> getBool(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(key) ?? false;
  }

  Future<void> set(Map<String, dynamic>? data) async {
    try {
      final pref = await SharedPreferences.getInstance();

      final jsonData = jsonEncode(UserModel.fromJson(data!));
      await pref.setString(_currentUser, jsonData);
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  Future<User?> get() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final user = pref.getString(_currentUser);

      if (user == null) return null;
      final userDataMap = jsonDecode(user) as Map<String, dynamic>;
      return UserModel.fromJson(userDataMap);
    } catch (e) {
      debugPrint("Error $e");
      return null;
    }
  }

  Future<void> remove() async {
    try {
      final pref = await SharedPreferences.getInstance();
      await pref.remove(_currentUser);
    } catch (e) {
      throw Exception("Error Occur $e");
    } finally {}
  }
}
