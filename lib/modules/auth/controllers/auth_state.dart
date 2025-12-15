import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthState {
  RxBool isCredentialValid = false.obs;

  // State variables
  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;

  // TextEditingControllers
  Rx<TextEditingController> emailController = TextEditingController(text: '').obs;
  Rx<TextEditingController> passwordController = TextEditingController(text: '').obs;

  AuthState() {
    ///Initialize variables
  }
}
