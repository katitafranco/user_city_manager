import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// FloatingActionButton reutilizable para acciones de creación.
///
/// IMPORTANTE:
/// - NO maneja seguridad
/// - NO valida permisos
/// - SOLO navega
///
/// La seguridad (OTP, permisos, confirmaciones)
/// debe manejarse dentro del caso de uso (Logic / Controller).
class SecureCreateFab extends StatelessWidget {
  /// Ruta a la que se navega
  final String route;

  /// Icono del FAB (por defecto: +)
  final IconData icon;

  const SecureCreateFab({
    super.key,
    required this.route,
    this.icon = Icons.add,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(icon),
      onPressed: () {
        Get.toNamed(route);
      },
    );
  }
}
