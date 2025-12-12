import 'package:get/get.dart';
import '../../../app/data/dio_client.dart'; // Para DioClient
import '../../../app/utils/logger.dart'; // Para AppLogger

class CityController extends GetxController {
  final DioClient _dioClient = Get.find<DioClient>();

  var cities = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCities();
  }

  Future<void> fetchCities() async {
    try {
      isLoading.value = true; // Indicar que la carga comenzó
      errorMessage.value = ''; // Limpiar mensajes de error previos

      final response = await _dioClient.dio.get('/cities'); // Llamada a la API

      if (response.statusCode == 200) {
        // La lista real de ciudades está dentro de la clave 'data' del Map
        final List<dynamic> dataList = response.data['data'] as List<dynamic>;

        // Convertir cada item a Map<String, dynamic> y asignarlo a la lista observable
        cities.value = dataList.map((e) => e as Map<String, dynamic>).toList();
      } else {
        errorMessage.value = 'Error ${response.statusCode}';
      }
    } catch (e, st) {
      // Registrar error en el logger y actualizar mensaje de error
      AppLogger.error('Failed to fetch cities', error: e, stackTrace: st);
      errorMessage.value = 'No se pudieron cargar las ciudades';
    } finally {
      isLoading.value = false; // Indicar que la carga terminó
    }
  }
}
