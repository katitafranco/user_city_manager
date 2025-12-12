import 'package:dio/dio.dart' as dio_package;  // Alias para evitar conflictos
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_endpoints.dart';
import '../config/app_constants.dart';

import '../utils/logger.dart';


/// Custom Dio client with interceptors for token management
class DioClient {
  late dio_package.Dio _dioInstance;
  
  DioClient() {
    _dioInstance = dio_package.Dio(
      dio_package.BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: Duration(milliseconds: AppConstants.connectTimeout),
        receiveTimeout: Duration(milliseconds: AppConstants.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    
    _dioInstance.interceptors.add(dio_package.InterceptorsWrapper(
      onRequest: _onRequest,
      onResponse: _onResponse,
      onError: _onError,
    ));
  }
  
  /// Interceptor for outgoing requests
  Future<void> _onRequest(
    dio_package.RequestOptions options,
    dio_package.RequestInterceptorHandler handler,
  ) async {
    try {
      // Get token from storage
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppConstants.tokenKey);
      
      // Add authorization header if token exists
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
        AppLogger.debug('Added auth token to request');
      }
      
      // Log network request using our custom logger
      AppLogger.networkRequest(
        options.method,
        options.uri.toString(),
        data: options.data,
      );
      
      return handler.next(options);
    } catch (error) {
      AppLogger.error(
        'Failed to setup request',
        error: error,
        tag: 'REQUEST_SETUP',
      );
      
      return handler.reject(
        dio_package.DioException(
          requestOptions: options,
          error: 'Failed to setup request',
        ),
      );
    }
  }
  
  /// Interceptor for incoming responses
  void _onResponse(
    dio_package.Response response,
    dio_package.ResponseInterceptorHandler handler,
  ) {
    // Log network response using our custom logger
    AppLogger.networkResponse(
      response.statusCode ?? 0,
      response.requestOptions.uri.toString(),
      data: response.data,
    );
    
    return handler.next(response);
  }
  
  /// Interceptor for error handling
  Future<void> _onError(
    dio_package.DioException err,
    dio_package.ErrorInterceptorHandler handler,
  ) async {
    // Log network error using our custom logger
    AppLogger.networkError(
      err.requestOptions.uri.toString(),
      err.response?.statusCode,
      err.message ?? 'Unknown error',
    );
    
    // Handle 401 Unauthorized errors (token expired)
    if (err.response?.statusCode == 401) {
      AppLogger.info('Token expired, attempting to refresh...');
      
      // Attempt to refresh token
      final refreshed = await _refreshToken();
      if (refreshed) {
        AppLogger.info('Token refreshed successfully, retrying request');
        
        // Retry the original request
        try {
          final retryResponse = await _retryRequest(err.requestOptions);
          return handler.resolve(retryResponse);
        } catch (retryError) {
          AppLogger.error(
            'Failed to retry request after token refresh',
            error: retryError,
          );
          return handler.next(err);
        }
      } else {
        // Token refresh failed, navigate to login
        AppLogger.warning('Token refresh failed, navigating to login');
        Get.offAllNamed('/login');
      }
    }
    
    return handler.next(err);
  }
  
  /// Attempt to refresh the authentication token
  Future<bool> _refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppConstants.tokenKey);
      
      if (token == null) {
        AppLogger.warning('No token found for refresh');
        return false;
      }
      
      AppLogger.debug('Refreshing token...');
      
      // Call refresh token endpoint
      final response = await _dioInstance.post(
        ApiEndpoints.refreshToken,
        data: {'token': token},
      );
      
      if (response.statusCode == 200) {
        final newToken = response.data['token'];
        await prefs.setString(AppConstants.tokenKey, newToken);
        AppLogger.info('Token refreshed successfully');
        return true;
      }
      
      AppLogger.warning('Token refresh failed with status: ${response.statusCode}');
      return false;
    } catch (error) {
      AppLogger.error(
        'Failed to refresh token',
        error: error,
      );
      return false;
    }
  }
  
  /// Retry a failed request with the new token
  Future<dio_package.Response<dynamic>> _retryRequest(
    dio_package.RequestOptions options,
  ) async {
    final newOptions = dio_package.Options(
      method: options.method,
      headers: options.headers,
    );
    
    return _dioInstance.request<dynamic>(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: newOptions,
    );
  }
  
  /// Getter for Dio instance
  dio_package.Dio get dio => _dioInstance;
}