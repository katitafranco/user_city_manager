import 'dart:io';

class AppConstants {
  // API Configuration
  // Detecta la plataforma para usar la URL correcta
  static final String baseUrl = Platform.isAndroid
      ? 'http://10.0.2.2:3020' // Emulador Android apunta al localhost de la PC
      : 'http://172.30.5.139:3020'; // iOS Simulator o dispositivo físico usa IP de la PC

  // Timeouts
  static const int connectTimeout = 30000; // Tiempo de conexión en ms
  static const int receiveTimeout =
      30000; // Tiempo máximo de espera de respuesta

  // Storage Keys
  static const String tokenKey = 'accessToken'; // Token JWT
  static const String refreshTokenKey = 'refreshToken'; // Token de refresco
  static const String userKey = 'user_data'; // Datos del usuario

  // API Strategy
  static const String authStrategy = 'local'; // Estrategia de autenticación

  // Validation
  static const String emailValidationMessage =
      'Ingresa un email válido'; // Mensaje de validación
  static const String passwordValidationMessage =
      'La contraseña debe tener al menos 6 caracteres'; // Mensaje de validación de contraseña
}
/* "strategy": "local",
    "userEmail": "jc@gmail.com",
    "userPassword": "111111" */