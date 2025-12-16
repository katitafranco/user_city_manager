import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:user_city_manager/app/config/api_endpoints.dart';
import 'package:user_city_manager/app/utils/logger.dart';
import '../../../app/data/dio_client.dart';
import '../../../app/utils/api_error_handler.dart';
import '../../../app/widgets/securities/secure_action_dialog.dart';
import '../models/user_model.dart';
import 'users_state.dart';

class UsersLogic extends GetxController {
  final UsersState state = UsersState();
  final DioClient _dioClient = Get.find<DioClient>();

  /// Carga inicial de usuarios al entrar al módulo
  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    AppLogger.info('UsersLogic inicializado');
  }

  /// Obtiene la lista de usuarios desde la API
  Future<void> fetchUsers() async {
    try {
      state.isLoading.value = true;
      state.errorMessage.value = '';

      final response = await _dioClient.dio.get(ApiEndpoints.users);
      final List data = response.data['data'];
      state.users.value = data.map((e) => UserModel.fromJson(e)).toList();

      AppLogger.debug('Usuarios cargados: ${state.users.length}');
    } catch (e, st) {
      AppLogger.error('Error cargando usuarios', error: e, stackTrace: st);
      state.errorMessage.value = 'No se pudieron cargar los usuarios';
    } finally {
      //Desactivar el loading en cualquier caso
      state.isLoading.value = false;
    }
  }

  /// Refresca manualmente la lista de usuarios
  Future<void> refreshUsers() async {
    await fetchUsers();
  }

  /// Obtiene un usuario por su ID
  UserModel? getUserById(int id) {
    try {
      return state.users.firstWhere((u) => u.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<bool> createUser({
    required String userFullName,
    required String userLastName,
    required String userEmail,
    required int userCity,
  }) async {
    if (userFullName.isEmpty || userLastName.isEmpty || userEmail.isEmpty) {
      state.errorMessage.value = 'Todos los campos son obligatorios';
      return false;
    }
    try {
      // Loading
      state.isLoading.value = true;
      state.errorMessage.value = '';

      // Payload minimo para crear usuario
      final payload = {
        'userFullName': userFullName,
        'userLastName': userLastName,
        'userEmail': userEmail,
        'userCity': userCity,
      };

      // Llamada a la API
      await _dioClient.dio.post(ApiEndpoints.users, data: payload);

      // Refrescar la lista de usuarios
      await fetchUsers();
      return true;
    }
    /* catch (e, st) {
      AppLogger.error('Error creando usuario', error: e, stackTrace: st);
      state.errorMessage.value = 'No se pudo crear el usuario';
      return false; */
    on DioException catch (e, st) {
      final message = ApiErrorHandler.parse(e);
      state.errorMessage.value = message;

      AppLogger.error('Error actualizando usuario', error: e, stackTrace: st);

      return false;
    } finally {
      // Desactivar loading
      state.isLoading.value = false;
    }
  }

  Future<bool> updateUser({
    required int userId,
    required String userFullName,
    required String userLastName,
    required String userEmail,
    int? userCity,
  }) async {
    //validación básica
    if (userFullName.isEmpty || userLastName.isEmpty || userEmail.isEmpty) {
      state.errorMessage.value = 'Todos los campos son obligatorios';
      return false;
    }

    final confirmed = await SecureActionDialog.confirm(
      title: 'Crear usuario',
      description: 'Esta acción actualizará un usuario. ¿Deseas continuar?',
    );

    if (!confirmed) {
      Get.snackbar('Cancelado', 'El usuario no fue actualizado');
      return false;
    }

    try {
      // Loading
      state.isLoading.value = true;
      state.errorMessage.value = '';

      // Patch al backend
      await _dioClient.dio.patch(
        ApiEndpoints.userById(userId),
        data: {
          'userFullName': userFullName,
          'userLastName': userLastName,
          'userEmail': userEmail,
        },
      );

      //Actualizando lista localmente
      final index = state.users.indexWhere((u) => u.id == userId);
      if (index != -1) {
        state.users[index] = state.users[index].copyWith(
          userFullName: userFullName,
          userLastName: userLastName,
          userEmail: userEmail,
        );
      }

      return true;
    } on DioException catch (e, st) {
      final message = ApiErrorHandler.parse(e);
      state.errorMessage.value = message;

      AppLogger.error('Error actualizando usuario', error: e, stackTrace: st);

      return false;
    } finally {
      // Desactivar loading
      state.isLoading.value = false;
    }
  }

  Future<bool> toggleUserState(int userId) async {
    final user = getUserById(userId);
    if (user == null) return false;

    final newState = user.state == 1 ? 0 : 1;

    final confirmed = await SecureActionDialog.confirm(
      title: newState == 1 ? 'Reactivar usuario' : 'Desactivar usuario',
      description: newState == 1
          ? 'El usuario volverá a estar activo. ¿Deseas continuar?'
          : 'El usuario será desactivado. ¿Deseas continuar?',
    );

    if (!confirmed) return false;

    try {
      state.isLoading.value = true;

      await _dioClient.dio.patch(
        ApiEndpoints.userById(userId),
        data: {'state': newState},
      );

      final index = state.users.indexWhere((u) => u.id == userId);
      if (index != -1) {
        state.users[index] = state.users[index].copyWith(state: newState);
      }

      return true;
    }    
    on DioException catch (e, st) {
      final message = ApiErrorHandler.parse(e);
      state.errorMessage.value = message;

      AppLogger.error('Error actualizando usuario', error: e, stackTrace: st);

      return false;
    } finally {
      state.isLoading.value = false;
    }
  }
}
