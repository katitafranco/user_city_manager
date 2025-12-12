/// Application constants and configuration values
class AppConstants {
  // API Configuration
  static const String baseUrl = 'http://10.0.2.2:3020';
 // Timeouts
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  
  // Storage Keys
  static const String tokenKey = 'accessToken';
  static const String refreshTokenKey = 'refreshToken';
  static const String userKey = 'user_data';
  
  // API Strategy
  static const String authStrategy = 'local';
  
  // Validation
  static const String emailValidationMessage = 'Ingresa un email válido';
  static const String passwordValidationMessage = 'La contraseña debe tener al menos 6 caracteres';
}

/* "strategy": "local",
    "userEmail": "jc@gmail.com",
    "userPassword": "111111" */