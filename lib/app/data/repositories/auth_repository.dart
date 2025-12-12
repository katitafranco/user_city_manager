import 'package:dio/dio.dart' as dio_package;
import 'package:get/get.dart';
import '../../../modules/auth/models/auth_response.dart';
import '../../config/api_endpoints.dart';
import '../../config/app_constants.dart';
import '../../utils/logger.dart';
import '../../utils/storage_helper.dart';
import '../dio_client.dart';// Import the logger

/// Repository for authenticatimport 'package:dio/dio.dart' as dio_package;

class AuthRepository {
  final DioClient _dioClient = Get.find<DioClient>();
  
  /// Authenticate with FeathersJS local strategy
  Future<AuthResponse> login({
    required String userEmail,
    required String userPassword,
  }) async {
    try {
      AppLogger.info('Attempting login for user: $userEmail');
      
      // FeathersJS espera este formato
      final loginData = {
        'strategy': AppConstants.authStrategy,
        'userEmail': userEmail,
        'userPassword': userPassword,
      };
      
      AppLogger.debug('Login data: $loginData');
      
      final response = await _dioClient.dio.post(
        ApiEndpoints.login,
        data: loginData,
      );
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        AppLogger.info('Login successful for user: $userEmail');
        
        final authResponse = AuthResponse.fromJson(response.data);
        
        // Guardar datos en storage
        await StorageHelper.saveAuthData({
          'accessToken': authResponse.accessToken,
          'user': authResponse.user,
          'authentication': authResponse.authentication,
        });
        
        return authResponse;
      } else {
        AppLogger.error(
          'Login failed with status: ${response.statusCode}',
          tag: 'LOGIN',
        );
        throw Exception('Error de autenticación: ${response.statusCode}');
      }
    } on dio_package.DioException catch (e) {
      final errorMessage = _handleDioError(e);
      AppLogger.error(
        'Login Dio error: $errorMessage',
        error: e,
        tag: 'LOGIN',
      );
      throw Exception(errorMessage);
    } catch (e, stackTrace) {
      AppLogger.error(
        'Login failed with unexpected error',
        error: e,
        stackTrace: stackTrace,
        tag: 'LOGIN',
      );
      throw Exception('Error de login: $e');
    }
  }
  
  /// Logout from FeathersJS
  Future<void> logout() async {
    try {
      AppLogger.info('Attempting logout');
      
      // FeathersJS logout endpoint
      await _dioClient.dio.delete(ApiEndpoints.logout);
      
      AppLogger.info('Logout successful');
    } catch (e, stackTrace) {
      AppLogger.error(
        'Logout API call failed, but clearing local data anyway',
        error: e,
        stackTrace: stackTrace,
        tag: 'LOGOUT',
      );
    } finally {
      // Siempre limpiamos los datos locales
      await StorageHelper.clearAuthData();
    }
  }
  
  /// Handle Dio errors específicos para FeathersJS
  String _handleDioError(dio_package.DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final errorData = error.response!.data;
      
      AppLogger.debug('Error response: $errorData');
      
      switch (statusCode) {
        case 400:
          return errorData['message'] ?? 'Solicitud incorrecta';
        case 401:
          return 'Email o contraseña incorrectos';
        case 403:
          return 'Acceso denegado';
        case 404:
          return 'Recurso no encontrado';
        case 422: // FeathersJS validation error
          final errors = errorData['errors'];
          if (errors is Map) {
            return errors.values.first?.first ?? 'Error de validación';
          }
          return errorData['message'] ?? 'Error de validación';
        case 500:
          return 'Error interno del servidor';
        default:
          return 'Error del servidor: $statusCode';
      }
    } else if (error.type == dio_package.DioExceptionType.connectionTimeout) {
      return 'Tiempo de conexión agotado. Verifica tu conexión a internet.';
    } else if (error.type == dio_package.DioExceptionType.receiveTimeout) {
      return 'El servidor está tardando mucho en responder.';
    } else if (error.type == dio_package.DioExceptionType.connectionError) {
      return 'Sin conexión a internet. Verifica tu red.';
    } else {
      return 'Error inesperado: ${error.message}';
    }
  }
}