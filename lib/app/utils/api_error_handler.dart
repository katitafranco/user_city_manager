import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String parse(DioException error) {
    final response = error.response;

    // Sin respuesta del servidor
    if (response == null) {
      return 'Error de conexión con el servidor';
    }

    final data = response.data;
    final statusCode = response.statusCode;

    switch (statusCode) {
      case 400:
        return data?['message'] ?? 'Datos inválidos';

      case 401:
        return 'No autorizado';

      case 403:
        return 'Acceso denegado';

      case 404:
        return 'Recurso no encontrado';

      case 409:
        // 🔥 Conflicto (email duplicado, clave única, etc.)
        return data?['message'] ?? 'Conflicto de datos';

      case 422:
        // FeathersJS validation
        if (data?['errors'] is Map) {
          final errors = data['errors'] as Map;
          return errors.values.first?.first ?? 'Error de validación';
        }
        return data?['message'] ?? 'Error de validación';

      case 500:
        return 'Error interno del servidor';

      default:
        return 'Error del servidor ($statusCode)';
    }
  }
}
