

/// Model for authentication response from API
class AuthResponse {
  final String accessToken;
  final Map<String, dynamic> authentication;
  final Map<String, dynamic> user;
  
  AuthResponse({
    required this.accessToken,
    required this.authentication,
    required this.user,
  });
  
  
  /// Factory constructor to create instance from JSON
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'],
      authentication: json['authentication'] ?? {},
      user: json['user'] ?? {},
    );
  }
  
  /// Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'authentication': authentication,
      'user': user,
    };
  }
}