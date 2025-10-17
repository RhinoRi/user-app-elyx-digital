import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

/// getting cached data...
Future<List<UserModel>?> getCachedUsers(int page) async {
  final prefs = await SharedPreferences.getInstance();
  final cacheKey = 'users_page_$page';
  final timestampKey = '${cacheKey}_timestamp';

  final jsonString = prefs.getString(cacheKey);
  final timestampString = prefs.getString(timestampKey);

  if (jsonString == null || timestampString == null) return null;

  final cacheTime = DateTime.tryParse(timestampString);
  if (cacheTime == null ||
      DateTime.now().difference(cacheTime) > Duration(minutes: 30)) {
    // print(' Cache expired or invalid for $cacheKey');
    return null;
  }

  final List<dynamic> decoded = json.decode(jsonString);
  return decoded.map((json) => UserModel.fromJson(json)).toList();
}

/// saving data to cache...
Future<void> saveUsersToCache(int page, List<dynamic> usersJson) async {
  final prefs = await SharedPreferences.getInstance();
  final cacheKey = 'users_page_$page';
  final timestampKey = '${cacheKey}_timestamp';

  await prefs.setString(cacheKey, json.encode(usersJson));
  await prefs.setString(timestampKey, DateTime.now().toIso8601String());

  // print(' Cached users for $cacheKey at ${DateTime.now()}');
}
