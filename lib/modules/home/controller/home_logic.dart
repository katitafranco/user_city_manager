import 'package:get/get.dart';
import '../../auth/controllers/auth_controller.dart';
import 'home_state.dart';

/// Lógica del Home.
/// Se encarga de cargar datos del usuario y manejar acciones del dashboard.
class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  final AuthController _authController = Get.find<AuthController>();

  /// Se ejecuta al inicializar el Home.
  /// Carga la información del usuario autenticado.
  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  /// Carga los datos del usuario actual desde AuthController
  void _loadUserData() {
    final userData = _authController.getCurrentUser();
    state.userData.value = userData;
    state.cityData.value = userData?['city'];
  }

  /// Cierra la sesión del usuario
  void logout() {
    _authController.logout();
  }

  /// Muestra un mensaje indicando que una funcionalidad aún no está disponible
  void showComingSoon(String feature) {
    Get.snackbar(
      'Próximamente',
      feature,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
