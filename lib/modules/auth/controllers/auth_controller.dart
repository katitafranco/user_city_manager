import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/data/repositories/auth_repository.dart';
import '../../../app/utils/logger.dart';
import '../../../app/utils/storage_helper.dart';
import '../../../routes/app_pages.dart';
import 'auth_state.dart';

class AuthController extends GetxController {
  AuthState state = AuthState();
  final AuthRepository _authRepository = Get.find<AuthRepository>();

  @override
  void onInit() {
    super.onInit();
    // Inicializar controllers
    // state.emailController. = TextEditingController();
    // state.passwordController = TextEditingController();

    // Cargar estado inicial
    _loadInitialState();

    AppLogger.info('AuthController inicializado');
  }

  @override
  void onClose() {
    // Dispose controllers
    state.emailController.value.dispose();
    state.passwordController.value.dispose();

    AppLogger.info('AuthController disposed');
    super.onClose();
  }

  /// Cargar estado inicial desde storage
  void _loadInitialState() {
    state.isLoggedIn.value = StorageHelper.isLoggedIn();

    if (state.isLoggedIn.value) {
      final userData = StorageHelper.getUserData();
      if (userData != null) {
        state.userName.value =
            '${userData['userFullName']} ${userData['userLastName']}'.trim();
        state.userEmail.value = userData['userEmail'] ?? '';

        AppLogger.debug('Datos de usuario cargados: ${state.userName.value}');
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
    state.emailController.value.clear();
    state.passwordController.value.clear();
    state.errorMessage.value = '';

    AppLogger.debug('Formulario limpiado');
  }

  /// Resetear estado para logout
  void resetState() {
    state.isLoading.value = false;
    state.isLoggedIn.value = false;
    state.userName.value = '';
    state.userEmail.value = '';
    state.errorMessage.value = '';
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
  bool isFormValid() {
    final email = state.emailController.value.text.trim();
    final password = state.passwordController.value.text.trim();

    // Debug
    AppLogger.debug(
      'Validando formulario: email="$email", password="${'*' * password.length}"',
    );

    state.isCredentialValid.value =
        email.isNotEmpty &&
        password.isNotEmpty &&
        validateEmail(email) &&
        validatePassword(password);

    return state.isCredentialValid.value;
  }

  /// Login con parámetros opcionales (flexible)
  Future<void> login({String? email, String? password}) async {
    try {
      // Resetear errores
      state.errorMessage.value = '';

      // Usar parámetros o valores de controllers
      final loginEmail = email ?? state.emailController.value.text.trim();
      final loginPassword =
          password ?? state.passwordController.value.text.trim();

      AppLogger.info('Iniciando login para: $loginEmail');

      // Validaciones
      if (loginEmail.isEmpty || loginPassword.isEmpty) {
        state.errorMessage.value = 'Por favor completa todos los campos';
        AppLogger.warning('Validación fallida: campos vacíos');
        return;
      }

      if (!validateEmail(loginEmail)) {
        state.errorMessage.value =
            'Ingresa un email válido (ejemplo@correo.com)';
        AppLogger.warning('Validación fallida: email inválido');
        return;
      }

      if (!validatePassword(loginPassword)) {
        state.errorMessage.value =
            'La contraseña debe tener al menos 6 caracteres';
        AppLogger.warning('Validación fallida: contraseña muy corta');
        return;
      }

      // Iniciar loading
      state.isLoading.value = true;
      AppLogger.info('Procesando login...');

      // Llamar API
      final authResponse = await _authRepository.login(
        userEmail: loginEmail,
        userPassword: loginPassword,
      );

      // Actualizar estado
      state.isLoggedIn.value = true;
      state.userName.value =
          '${authResponse.user['userFullName']} ${authResponse.user['userLastName']}'
              .trim();
      state.userEmail.value = authResponse.user['userEmail'] ?? loginEmail;

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
      /*   Get.offAllNamed('/home'); */
      Get.offAllNamed(AppRoutes.HomeScreen);
    } catch (e) {
      state.errorMessage.value = e.toString().replaceAll('Exception: ', '');

      // Log de error
      AppLogger.error('❌ Error en login', error: e, tag: 'AUTH');

      Get.snackbar(
        'Error',
        state.errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      state.isLoading.value = false;
    }
  }

  /// Login usando valores de los controllers
  Future<void> loginWithControllerValues() async {
    await login();
  }

  /// Logout
  Future<void> logout() async {
    try {
      state.isLoading.value = true;
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
      state.isLoading.value = false;
    }
  }

  Future<void> performLogin() async {
    AppLogger.info('🎯 Botón presionado - Iniciando login');

    await login(
      email: state.emailController.value.text.trim(),
      password: state.passwordController.value.text.trim(),
    );
  }
}
