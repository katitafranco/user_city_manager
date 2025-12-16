import 'package:get/get.dart';
import '../models/user_model.dart';

/// Estado del módulo Users.
/// Maneja loading, errores y listado de usuarios.
class UsersState {
  //Estado de carga
  final RxBool isLoading = false.obs;

  //Mensaje de error
  final RxString errorMessage = ''.obs;

  //Listado de usuarios
  final users = <UserModel>[].obs;
}
