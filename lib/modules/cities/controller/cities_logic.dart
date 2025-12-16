import 'package:get/get.dart';
import '../../../app/config/api_endpoints.dart';
import '../../../app/data/dio_client.dart';
import '../../../app/utils/logger.dart';
import '../../../app/widgets/securities/secure_action_dialog.dart';
import '../models/city_model.dart';
import 'cities_state.dart';

/// Lógica del módulo Cities.
/// Se encarga de obtener, refrescar y buscar ciudades.
class CitiesLogic extends GetxController {
  final CitiesState state = CitiesState();
  final DioClient _dioClient = Get.find<DioClient>();

  /// Carga inicial de ciudades al entrar al módulo
  @override
  void onInit() {
    super.onInit();
    fetchCities();
    AppLogger.info('CitiesLogic inicializado');
  }

  /// Obtiene la lista de ciudades desde la API
  Future<void> fetchCities() async {
    try {
      state.isLoading.value = true;
      state.errorMessage.value = '';

      /*  final response = await _dioClient.dio.get('/cities');
 */
      final response = await _dioClient.dio.get(ApiEndpoints.cities);
      final List data = response.data['data'];
      state.cities.value = data.map((e) => CityModel.fromJson(e)).toList();

      AppLogger.debug('Ciudades cargadas: ${state.cities.length}');
    } catch (e, st) {
      AppLogger.error('Error cargando ciudades', error: e, stackTrace: st);
      state.errorMessage.value = 'No se pudieron cargar las ciudades';
    } finally {
      state.isLoading.value = false;
    }
  }

  /// Refresca manualmente la lista de ciudades
  Future<void> refreshCities() async {
    await fetchCities();
  }

  /// Obtiene una ciudad por su ID
  CityModel? getCityById(int id) {
    try {
      return state.cities.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Actualiza una ciudad.
  /// Valida datos, solicita confirmación OTP y simula la persistencia.
  Future<bool> updateCity({
    required int cityId,
    required String cityName,
  }) async {
    // Validación básica
    if (cityName.isEmpty) {
      Get.snackbar('Error', 'Todos los campos son obligatorios');
      return false;
    }

    // 2️⃣ Confirmación OTP (widget reutilizable)
    final confirmed = await SecureActionDialog.confirm(
      title: 'Confirmar actualización',
      description:
          'Estás a punto de actualizar la información de la ciudad.\n'
          'Ingresa el OTP para continuar.',
    );

    if (!confirmed) {
      Get.snackbar('Cancelado', 'No se realizaron cambios');
      return false;
    }

    try {
      // state.isLoading.value = true;

      AppLogger.info('Actualizando ciudad ID: $cityId');

      // Llamada al backend para actualizar la ciudad
      final response = await _dioClient.dio.patch(
        ApiEndpoints.cityById(cityId),
        data: {
          'cityName': cityName,
        },
      );

      if (response.statusCode == 200) {
        // Si la actualización fue exitosa, actualizamos la ciudad localmente
        final index = state.cities.indexWhere((c) => c.id == cityId);
        if (index != -1) {
          state.cities[index] = state.cities[index].copyWith(
            cityName: cityName,
          );
        }

        Get.snackbar('Éxito', 'Ciudad actualizada correctamente');
        return true;
      } else {
        Get.snackbar('Error', 'No se pudo actualizar la ciudad');
        return false;
      }
    } catch (e, st) {
      AppLogger.error('Error al actualizar ciudad', error: e, stackTrace: st);
      Get.snackbar('Error', 'No se pudo actualizar la ciudad');
      return false;
    }
  }

  /// Desactiva una ciudad tras confirmar la acción con OTP
  Future<bool> deactivateCity(int cityId) async {
    final confirmed = await SecureActionDialog.confirm(
      title: 'Desactivar ciudad',
      description: 'Esta acción desactivará la ciudad. ¿Deseas continuar?',
    );

    if (!confirmed) {
      Get.snackbar('Cancelado', 'La ciudad no fue modificada');
      return false;
    }

    try {
      final response = await _dioClient.dio.patch(
        ApiEndpoints.cityById(cityId),
        data: {'state': 0},
      );

      if (response.statusCode == 200) {
        final index = state.cities.indexWhere((c) => c.id == cityId);
        if (index != -1) {
          state.cities[index] = state.cities[index].copyWith(state: 0);
        }

        Get.snackbar('Éxito', 'Ciudad desactivada');
        return true;
      }

      Get.snackbar('Error', 'No se pudo desactivar la ciudad');
      return false;
    } catch (e) {
      Get.snackbar('Error', 'Error al desactivar ciudad');
      return false;
    }
  }

  Future<bool> reactivateCity(int cityId) async {
    final confirmed = await SecureActionDialog.confirm(
      title: 'Reactivar ciudad',
      description:
          'Esta acción volverá a activar la ciudad. ¿Deseas continuar?',
    );

    if (!confirmed) {
      Get.snackbar('Cancelado', 'La ciudad no fue modificada');
      return false;
    }

    try {
      final response = await _dioClient.dio.patch(
        ApiEndpoints.cityById(cityId),
        data: {'state': 1},
      );

      if (response.statusCode == 200) {
        final index = state.cities.indexWhere((c) => c.id == cityId);
        if (index != -1) {
          state.cities[index] = state.cities[index].copyWith(state: 1);
        }

        Get.snackbar('Éxito', 'Ciudad reactivada correctamente');
        return true;
      }

      Get.snackbar('Error', 'No se pudo reactivar la ciudad');
      return false;
    } catch (e) {
      Get.snackbar('Error', 'Error al reactivar la ciudad');
      return false;
    }
  }

  /// Se ejecuta cuando el módulo se elimina de memoria.
  @override
  void onClose() {
    AppLogger.info('CitiesLogic disposed');
    super.onClose();
  }
}
