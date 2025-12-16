import 'package:get/get.dart';

/// Estado del Home.
/// Contiene la información reactiva usada por la pantalla principal.
class HomeState {
  /// Datos del usuario logueado
  final userData = Rx<Map<String, dynamic>?>(null);

  /// Datos de la ciudad asociada al usuario
  final cityData = Rx<Map<String, dynamic>?>(null);
}