


import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FavoritesSecureService {
  static const _key = 'favorite_users';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Get all favorite user IDs
  Future<List<String>> getFavorites() async {
    final data = await _storage.read(key: _key);
    if (data == null || data.isEmpty) return [];
    return List<String>.from(jsonDecode(data));
  }

  /// Toggle favorite
  Future<void> toggleFavorite(String userId) async {
    final favs = await getFavorites();
    if (favs.contains(userId)) {
      favs.remove(userId);
    } else {
      favs.add(userId);
    }
    await _storage.write(key: _key, value: jsonEncode(favs));
  }

  /// Check if user is favorite
  Future<bool> isFavorite(String userId) async {
    final favs = await getFavorites();
    return favs.contains(userId);
  }

  /// Clear all
  Future<void> clearFavorites() async {
    await _storage.delete(key: _key);
  }
}
