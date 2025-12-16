import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../utils/storage_helper.dart';



/// Middleware encargado de proteger rutas que requieren autenticación.
/// Si el usuario no tiene una sesión válida, redirige al login.
class AuthMiddleware extends GetMiddleware {

  /// Se ejecuta antes de entrar a una ruta protegida.
  /// 
  /// - Permite la navegación si el usuario está autenticado.
  /// - Redirige al login si no existe una sesión activa.
  @override
  RouteSettings? redirect(String? route) {
    if (StorageHelper.isLoggedIn()) {
      return null; // Permite continuar a la ruta solicitada
    }

    // Bloquea el acceso y redirige al login
    return const RouteSettings(
      name: AppRoutes.LoginPage,
    );
  }
}
