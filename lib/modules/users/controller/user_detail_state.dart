import 'package:get/get.dart';
import '../../cities/models/city_model.dart';
import '../models/user_model.dart';

class UserDetailState {
  /// Usuario cargado
  final Rx<UserModel?> user = Rx<UserModel?>(null);

  /// Lista de ciudades
  final RxList<CityModel> cities = <CityModel>[].obs;

  /// Ciudad seleccionada
  final Rx<CityModel?> selectedCity = Rx<CityModel?>(null);

  /// Loading general
  final RxBool isLoading = false.obs;

  /// Error
  final RxString errorMessage = ''.obs;
}