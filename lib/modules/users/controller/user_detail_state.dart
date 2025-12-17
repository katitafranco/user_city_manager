import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cities/models/city_model.dart';
import '../models/user_model.dart';

class UserDetailState {
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final isEditing = false.obs;

  final user = Rx<UserModel?>(null);
  final selectedCity = Rx<CityModel?>(null);

  // 🆕 Controllers de edición
  final nameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
}
