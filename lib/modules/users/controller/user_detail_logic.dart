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

  /// Ciudades disponibles
  List<CityModel> get cities => _citiesLogic.state.cities;

  /// null = CREATE | con valor = EDIT
  int? userId;

  @override
  void onInit() {
    super.onInit();

    userId = Get.arguments as int?;

    if (userId != null) {
      state.isEditing.value = true;
      _loadEditData();
    } else {
      state.isEditing.value = false;
      _loadCreateData();
    }
  }

  /// =========================
  /// CARGA PARA EDICIÓN
  /// =========================
  Future<void> _loadEditData() async {
    try {
      state.isLoading.value = true;

      final user = _usersLogic.getUserById(userId!);
      if (user == null) {
        state.errorMessage.value = 'Usuario no encontrado';
        return;
      }

      state.user.value = user;

      if (_citiesLogic.state.cities.isEmpty) {
        await _citiesLogic.fetchCities();
      }

      state.nameCtrl.text = user.userFullName;
      state.lastNameCtrl.text = user.userLastName;
      state.emailCtrl.text = user.userEmail;
      state.phoneCtrl.text = user.userPhone ?? '';

      state.selectedCityId.value = user.userCity.toString();

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

  /// =========================
  /// CARGA PARA CREACIÓN
  /// =========================
  Future<void> _loadCreateData() async {
    try {
      state.isLoading.value = true;

      state.clear();
      state.selectedCityId.value = null;

      if (_citiesLogic.state.cities.isEmpty) {
        await _citiesLogic.fetchCities();
      }
    } catch (e, st) {
      AppLogger.error(
        'Error preparando creación de usuario',
        error: e,
        stackTrace: st,
      );
      state.errorMessage.value = 'Error preparando formulario';
    } finally {
      state.isLoading.value = false;
    }
  }

  /// =========================
  /// CAMBIO DESDE DROPDOWN (STRING)
  /// =========================
  void onCityIdChanged(String? cityId) {
    if (cityId == null) {
      state.selectedCityId.value = null;
      state.selectedCity.value = null;
      return;
    }

    state.selectedCityId.value = cityId;

    state.selectedCity.value = cities.firstWhereOrNull(
      (c) => c.id.toString() == cityId,
    );
  }

  /// =========================
  /// GUARDAR (CREATE / UPDATE)
  /// =========================
  Future<void> saveChanges() async {
    try {
      state.isLoading.value = true;
      state.errorMessage.value = '';

      final city = state.selectedCity.value;
      if (city == null) {
        Get.snackbar('Error', 'Debe seleccionar una ciudad');
        return;
      }

      final success = state.isEditing.value
          ? await _usersLogic.updateUser(
              userId: state.user.value!.id,
              userFullName: state.nameCtrl.text.trim(),
              userLastName: state.lastNameCtrl.text.trim(),
              userEmail: state.emailCtrl.text.trim(),
              userCity: city.id,
            )
          : await _usersLogic.createUser(
              userFullName: state.nameCtrl.text.trim(),
              userLastName: state.lastNameCtrl.text.trim(),
              userEmail: state.emailCtrl.text.trim(),
              userPhone: state.phoneCtrl.text.trim(),
              userPassword: state.passwordCtrl.text.trim(),
              userCity: city.id,
            );

      if (!success) return;

      Get.back(result: true);
      Get.snackbar(
        'Éxito',
        state.isEditing.value
            ? 'Usuario actualizado correctamente'
            : 'Usuario creado correctamente',
      );
    } catch (e, st) {
      AppLogger.error(
        'Error guardando usuario',
        error: e,
        stackTrace: st,
      );
      Get.snackbar('Error', 'No se pudo guardar el usuario');
    } finally {
      state.isLoading.value = false;
    }
  }

  @override
  void onClose() {
    state.nameCtrl.dispose();
    state.lastNameCtrl.dispose();
    state.emailCtrl.dispose();
    state.phoneCtrl.dispose();
    state.passwordCtrl.dispose();
    super.onClose();
  }
}
