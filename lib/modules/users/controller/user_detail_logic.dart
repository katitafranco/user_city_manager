import 'package:get/get.dart';
import '../../../app/utils/logger.dart';
import '../../cities/controller/cities_logic.dart';
import '../../cities/models/city_model.dart';
import '../controller/users_logic.dart';
import 'user_detail_state.dart';

class UserDetailLogic extends GetxController {
  final UserDetailState state = UserDetailState();

  final UsersLogic _usersLogic = Get.find<UsersLogic>();
  final CitiesLogic _citiesLogic = Get.find<CitiesLogic>();

  List<CityModel> get cities => _citiesLogic.state.cities;

  late final int userId;

  @override
  void onInit() {
    super.onInit();
    userId = Get.arguments as int;
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      state.isLoading.value = true;

      // Usuario
      final user = _usersLogic.getUserById(userId);
      if (user == null) {
        state.errorMessage.value = 'Usuario no encontrado';
        return;
      }

      state.user.value = user;

      // Cargar ciudades si hace falta
      if (_citiesLogic.state.cities.isEmpty) {
        await _citiesLogic.fetchCities();
      }

      // Inicializar valores editables
      state.nameCtrl.text = user.userFullName;
      state.lastNameCtrl.text = user.userLastName;
      state.emailCtrl.text = user.userEmail;

      state.selectedCity.value = cities.firstWhereOrNull(
        (c) => c.id == user.userCity,
      );
    } catch (e, st) {
      AppLogger.error(
        'Error cargando detalle de usuario',
        error: e,
        stackTrace: st,
      );
      state.errorMessage.value = 'Error cargando el usuario';
    } finally {
      state.isLoading.value = false;
    }
  }

  /// Cambiar ciudad seleccionada
  void onCityChanged(CityModel? city) {
    state.selectedCity.value = city;
  }

  /// Alternar modo edición
  void toggleEdit() {
    state.isEditing.value = !state.isEditing.value;

    // Si cancela, restaurar datos originales
    if (!state.isEditing.value) {
      final user = state.user.value;
      if (user != null) {
        state.nameCtrl.text = user.userFullName;
        state.lastNameCtrl.text = user.userLastName;
        state.emailCtrl.text = user.userEmail;
        state.selectedCity.value = cities.firstWhereOrNull(
          (c) => c.id == user.userCity,
        );
      }
    }
  }

  /// Guardar cambios reales
  Future<void> saveChanges() async {
    final user = state.user.value;
    final city = state.selectedCity.value;

    if (user == null || city == null) {
      Get.snackbar('Error', 'Datos incompletos');
      return;
    }

    try {
      state.isLoading.value = true;

      await _usersLogic.updateUser(
        userId: user.id,
        userFullName: state.nameCtrl.text.trim(),
        userLastName: state.lastNameCtrl.text.trim(),
        userEmail: state.emailCtrl.text.trim(),
        userCity: city.id,
      );

      // Volver atrás indicando que hubo cambios
      Get.back(result: true);
      
      // Actualizar usuario local
      state.user.value = user.copyWith(
        userFullName: state.nameCtrl.text.trim(),
        userLastName: state.lastNameCtrl.text.trim(),
        userEmail: state.emailCtrl.text.trim(),
        city: city,
      );

      state.isEditing.value = false;
      Get.snackbar('Éxito', 'Usuario actualizado correctamente');
    } catch (e) {
      Get.snackbar('Error', 'No se pudo actualizar el usuario');
    } finally {
      state.isLoading.value = false;
    }
  }

  @override
  void onClose() {
    state.nameCtrl.dispose();
    state.lastNameCtrl.dispose();
    state.emailCtrl.dispose();
    super.onClose();
  }
}
