import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/config/api_endpoints.dart';
import '../../../app/data/dio_client.dart';
import '../../../app/utils/logger.dart';
import '../../../app/widgets/securities/secure_action_dialog.dart';

import 'cities_logic.dart';
import 'cities_create_state.dart';

/// Modelo simple para países
class CountryOption {
  final String code;
  final String name;

  const CountryOption(this.code, this.name);
}

class CityCreateLogic extends GetxController {
  final CityCreateState state = CityCreateState();

  final DioClient _dioClient = Get.find<DioClient>();
  final CitiesLogic _citiesLogic = Get.find<CitiesLogic>();

  /// Input nombre de ciudad
  final cityNameCtrl = TextEditingController();

  /// Lista predefinida de países (frontend)
  final List<CountryOption> countries = const [
    CountryOption('EC', 'Ecuador'),
    CountryOption('PE', 'Perú'),
    CountryOption('CO', 'Colombia'),
    CountryOption('CL', 'Chile'),
  ];

  /// País seleccionado (código)
  final selectedCountryCode = RxnString();

  /// Validación mínima (lo que pediste)
  bool get isFormValid =>
      cityNameCtrl.text.trim().isNotEmpty && selectedCountryCode.value != null;

  Future<void> createCity() async {
    // 1️⃣ Validación básica
    if (!isFormValid) {
      return; // botón ya está deshabilitado, no mostramos nada
    }

    // 2️⃣ OTP
    final confirmed = await SecureActionDialog.confirm(
      title: 'Confirmar creación',
      description:
          'Estás a punto de crear una nueva ciudad.\n'
          'Ingresa el OTP para continuar.',
    );

    if (!confirmed) {
      Get.snackbar('Cancelado', 'La ciudad no fue creada');
      return;
    }

    // 3️⃣ POST
    state.isLoading.value = true;

    try {
      final payload = {
        'cityName': cityNameCtrl.text.trim(),
        'cityCountryCode': selectedCountryCode.value,
      };

      final response = await _dioClient.dio.post(
        ApiEndpoints.cities,
        data: payload,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await _citiesLogic.fetchCities();

        Get.back();
        Get.snackbar('Éxito', 'Ciudad creada correctamente');
      }
    } catch (e, st) {
      AppLogger.error('Error creando ciudad', error: e, stackTrace: st);
      Get.snackbar('Error', 'No se pudo crear la ciudad');
    } finally {
      state.isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();

    cityNameCtrl.addListener(() {
      cityName.value = cityNameCtrl.text;
    });
  }

  final cityName = ''.obs;
}
