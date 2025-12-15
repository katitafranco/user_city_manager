import 'package:get/get.dart';
import '../../../app/data/dio_client.dart';
import '../../../app/utils/logger.dart';
import '../models/city_model.dart';

class CityController extends GetxController {
  final DioClient _dioClient = Get.find<DioClient>();

  // ======================
  // State variables
  // ======================
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<CityModel> cities = <CityModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCities();
    AppLogger.info('CityController inicializado');
  }

  /// Obtener lista de ciudades desde la API
  Future<void> fetchCities() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      AppLogger.info('Obteniendo lista de ciudades...');

      final response = await _dioClient.dio.get('/cities');

      if (response.statusCode == 200) {
        final List<dynamic> dataList = response.data['data'];

        cities.value = dataList.map((e) => CityModel.fromJson(e)).toList();

        AppLogger.debug('Ciudades cargadas: ${cities.length}');
      } else {
        errorMessage.value = 'Error ${response.statusCode}';
        AppLogger.warning('Error al cargar ciudades');
      }
    } catch (e, st) {
      AppLogger.error('Failed to fetch cities', error: e, stackTrace: st);
      errorMessage.value = 'No se pudieron cargar las ciudades';
    } finally {
      isLoading.value = false;
    }
  }

  /// Refrescar lista manualmente
  Future<void> refreshCities() async {
    AppLogger.info('Refrescando ciudades...');
    await fetchCities();
  }

  /// Obtener ciudad por ID
  CityModel? getCityById(int id) {
    try {
      return cities.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  void onClose() {
    AppLogger.info('CityController disposed');
    super.onClose();
  }
}
