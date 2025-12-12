import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../app/data/repositories/auth_repository.dart';
import '../../../app/utils/storage_helper.dart';
import '../../../app/utils/logger.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  
  // State variables
  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;
  
  // TextEditingControllers
  late TextEditingController emailController;
  late TextEditingController passwordController;
  
  @override
  void onInit() {
    super.onInit();
    // Inicializar controllers
    emailController = TextEditingController();
    passwordController = TextEditingController();
    
    // Cargar estado inicial
    _loadInitialState();
    
    AppLogger.info('AuthController inicializado');
  }
  
  @override
  void onClose() {
    // Dispose controllers
    emailController.dispose();
    passwordController.dispose();
    
    AppLogger.info('AuthController disposed');
    super.onClose();
  }
  
  /// Cargar estado inicial desde storage
  void _loadInitialState() {
    isLoggedIn.value = StorageHelper.isLoggedIn();
    
    if (isLoggedIn.value) {
      final userData = StorageHelper.getUserData();
      if (userData != null) {
        userName.value = '${userData['userFullName']} ${userData['userLastName']}'.trim();
        userEmail.value = userData['userEmail'] ?? '';
        
        AppLogger.debug('Datos de usuario cargados: ${userName.value}');
      }
    } else {
      AppLogger.debug('Usuario no autenticado');
    }
  }
  
  /// Obtener datos del usuario actual
  Map<String, dynamic>? getCurrentUser() {
    return StorageHelper.getUserData();
  }
  
  /// Obtener ID del usuario
  String? getUserId() {
    final userData = getCurrentUser();
    return userData?['id']?.toString();
  }
  
  /// Limpiar formulario
  void clearForm() {
    emailController.clear();
    passwordController.clear();
    errorMessage.value = '';
    
    AppLogger.debug('Formulario limpiado');
  }
  
  /// Resetear estado para logout
  void resetState() {
    isLoading.value = false;
    isLoggedIn.value = false;
    userName.value = '';
    userEmail.value = '';
    errorMessage.value = '';
    clearForm();
    
    AppLogger.info('Estado del AuthController reseteado');
  }
  
  /// Validar email (simplificado)
  bool validateEmail(String email) {
    // Validación simple pero funcional
    return email.contains('@') && email.contains('.') && email.length > 5;
  }
  
  /// Validar contraseña
  bool validatePassword(String password) {
    return password.length >= 6;
  }
  
  /// Verificar si el formulario es válido
  bool get isFormValid {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    
    // Debug
    AppLogger.debug('Validando formulario: email="$email", password="${'*' * password.length}"');
    
    return email.isNotEmpty &&
           password.isNotEmpty &&
           validateEmail(email) &&
           validatePassword(password);
  }
  
  /// Login con parámetros opcionales (flexible)
  Future<void> login({String? email, String? password}) async {
    try {
      // Resetear errores
      errorMessage.value = '';
      
      // Usar parámetros o valores de controllers
      final loginEmail = email ?? emailController.text.trim();
      final loginPassword = password ?? passwordController.text.trim();
      
      AppLogger.info('Iniciando login para: $loginEmail');
      
      // Validaciones
      if (loginEmail.isEmpty || loginPassword.isEmpty) {
        errorMessage.value = 'Por favor completa todos los campos';
        AppLogger.warning('Validación fallida: campos vacíos');
        return;
      }
      
      if (!validateEmail(loginEmail)) {
        errorMessage.value = 'Ingresa un email válido (ejemplo@correo.com)';
        AppLogger.warning('Validación fallida: email inválido');
        return;
      }
      
      if (!validatePassword(loginPassword)) {
        errorMessage.value = 'La contraseña debe tener al menos 6 caracteres';
        AppLogger.warning('Validación fallida: contraseña muy corta');
        return;
      }
      
      // Iniciar loading
      isLoading.value = true;
      AppLogger.info('Procesando login...');
      
      // Llamar API
      final authResponse = await _authRepository.login(
        userEmail: loginEmail,
        userPassword: loginPassword,
      );
      
      // Actualizar estado
      isLoggedIn.value = true;
      userName.value = '${authResponse.user['userFullName']} ${authResponse.user['userLastName']}'.trim();
      userEmail.value = authResponse.user['userEmail'] ?? loginEmail;
      
      // Limpiar formulario
      clearForm();
      
      // Log exitoso
      AppLogger.info('✅ Login exitoso para: $loginEmail');
      
      // Mostrar éxito
      Get.snackbar(
        '¡Bienvenido!',
        'Sesión iniciada correctamente',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      
      // Navegar a home
      Get.offAllNamed('/home');
      
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      
      // Log de error
      AppLogger.error(
        '❌ Error en login',
        error: e,
        tag: 'AUTH',
      );
      
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  /// Login usando valores de los controllers
  Future<void> loginWithControllerValues() async {
    await login();
  }
  
  /// Logout
  Future<void> logout() async {
    try {
      isLoading.value = true;
      AppLogger.info('Iniciando proceso de logout');
      
      await _authRepository.logout();
      
      // Resetear estado local
      resetState();
      
      AppLogger.info('✅ Logout exitoso');
      
      Get.snackbar(
        'Sesión cerrada',
        'Has cerrado sesión exitosamente',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      
      // Navegar a login
      Get.offAllNamed('/login');
      
    } catch (e) {
      // Si falla el logout del API, igual limpiar localmente
      AppLogger.warning('Logout de API falló, limpiando datos locales');
      
      await StorageHelper.clearAuthData();
      resetState();
      
      AppLogger.info('Datos locales limpiados');
      
      Get.offAllNamed('/login');
    } finally {
      isLoading.value = false;
    }
  }
}