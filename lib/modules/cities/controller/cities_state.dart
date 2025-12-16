import 'package:get/get.dart';
import '../models/city_model.dart';

/// Estado del módulo Cities.
/// Maneja loading, errores y listado de ciudades.
class CitiesState {
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final cities = <CityModel>[].obs;
}
