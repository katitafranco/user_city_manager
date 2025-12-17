import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cities/models/city_model.dart';
import '../models/user_model.dart';

class UserDetailState {
  /// Estado general del formulario
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final isEditing = false.obs;

  /// Usuario en edición (null = create)
  final user = Rx<UserModel?>(null);

  /// Ciudad seleccionada (UI)
  final selectedCity = Rx<CityModel?>(null);

  /// Controllers del formulario
  final nameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  /// 🆕 SOLO para CREATE / opcional en UPDATE
  final phoneCtrl = TextEditingController();

  /// 🆕 SOLO para CREATE
  final passwordCtrl = TextEditingController();

  /// 🆕 SOLO para CREATE / UPDAT E
  final selectedCityId = RxnString();

  /// Limpieza (muy importante)
  void clear() {
    user.value = null;
    isEditing.value = false;
    errorMessage.value = '';

    nameCtrl.clear();
    lastNameCtrl.clear();
    emailCtrl.clear();
    phoneCtrl.clear();
    passwordCtrl.clear();

    selectedCity.value = null;
  }
}
