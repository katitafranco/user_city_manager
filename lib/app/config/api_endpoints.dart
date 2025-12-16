
/// Centraliza todos los endpoints de la API.
class ApiEndpoints {
  ApiEndpoints._(); // Previene instancias accidentales

  // =========================
  // Authentication (FeathersJS)
  // =========================
  static const String login = '/authentication';
  static const String logout = '/authentication/logout';
  static const String refreshToken = '/authentication/refresh';

  // =========================
  // User management
  // =========================
  static const String users = '/users';

  static String userById(String id) => '$users/$id';

  // =========================
  // City management
  // =========================
  static const String cities = '/cities';

  static String cityById(int id) => '$cities/$id';
}
