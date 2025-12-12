import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_constants.dart';

class StorageHelper {
  static SharedPreferences? _prefs;
  
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  /// Save authentication data from FeathersJS response
  static Future<void> saveAuthData(Map<String, dynamic> authResponse) async {
    await saveToken(authResponse['accessToken']);
    await saveUserData(authResponse['user']);
    
    // También guarda el authentication completo si lo necesitas
    if (authResponse['authentication'] != null) {
      await _prefs?.setString(
        'authentication',
        jsonEncode(authResponse['authentication']),
      );
    }
  }
  
  /// Save access token
  static Future<bool> saveToken(String token) async {
    return await _prefs?.setString(AppConstants.tokenKey, token) ?? false;
  }
  
  /// Get access token
  static String? getToken() {
    return _prefs?.getString(AppConstants.tokenKey);
  }
  
  /// Save user data
  static Future<bool> saveUserData(Map<String, dynamic> userData) async {
    final userJson = jsonEncode(userData);
    return await _prefs?.setString(AppConstants.userKey, userJson) ?? false;
  }
  
  /// Get user data
  static Map<String, dynamic>? getUserData() {
    final userJson = _prefs?.getString(AppConstants.userKey);
    if (userJson != null) {
      return jsonDecode(userJson) as Map<String, dynamic>;
    }
    return null;
  }
  
  /// Get current user ID
  static String? getUserId() {
    final userData = getUserData();
    return userData?['id']?.toString();
  }
  
  /// Get current user name
  static String? getUserName() {
    final userData = getUserData();
    return '${userData?['userFullName']} ${userData?['userLastName']}'.trim();
  }
  
  /// Check if user is logged in
  static bool isLoggedIn() {
    return getToken() != null && getToken()!.isNotEmpty;
  }
  
  /// Clear all authentication data
  static Future<void> clearAuthData() async {
    await _prefs?.remove(AppConstants.tokenKey);
    await _prefs?.remove(AppConstants.userKey);
    await _prefs?.remove('authentication');
  }
}