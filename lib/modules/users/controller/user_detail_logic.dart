import 'package:get/get.dart';
import '../../../app/utils/logger.dart';
import '../../cities/controller/cities_logic.dart';
import '../controller/users_logic.dart';
import 'user_detail_state.dart';
import '../../cities/models/city_model.dart';

class UserDetailLogic extends GetxController {
  final UserDetailState state = UserDetailState();

  final UsersLogic _usersLogic = Get.find<UsersLogic>();
  final CitiesLogic _citiesLogic = Get.find<CitiesLogic>();

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

      // 1️⃣ Obtener usuario desde UsersLogic
      final user = _usersLogic.getUserById(userId);
      if (user == null) {
        state.errorMessage.value = 'Usuario no encontrado';
        return;
      }

      state.user.value = user;

      // 2️⃣ Cargar ciudades (si aún no están)
      if (_citiesLogic.state.cities.isEmpty) {
        await _citiesLogic.fetchCities();
      }

      state.cities.assignAll(_citiesLogic.state.cities);

      // 3️⃣ Seleccionar ciudad actual del usuario
      state.selectedCity.value = state.cities.firstWhereOrNull(
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
}
