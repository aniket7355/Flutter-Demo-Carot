import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const String _tokenKey = 'user_token';
  static const String _expiryKey = 'token_expiry';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    // Save expiry time (1 day later)
    final expiryTime = DateTime.now().add(Duration(days: 1)).toIso8601String();
    await prefs.setString(_expiryKey, expiryTime);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryTimeString = prefs.getString(_expiryKey);
    if (expiryTimeString != null) {
      final expiryTime = DateTime.parse(expiryTimeString);
      if (DateTime.now().isAfter(expiryTime)) {
        // Token expired
        await prefs.remove(_tokenKey);
        await prefs.remove(_expiryKey);
        return null;
      }
    }
    return prefs.getString(_tokenKey);
  }

  // Method to remove the token (add this for logout functionality)
  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_expiryKey);
  }
}
