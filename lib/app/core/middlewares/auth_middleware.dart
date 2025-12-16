import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_city_manager/app/utils/storage_helper.dart';
import 'package:user_city_manager/routes/app_pages.dart';

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
