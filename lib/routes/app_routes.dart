// ignore_for_file: constant_identifier_names

part of './app_pages.dart';

abstract class AppRoutes {
  /* 
   ///Como no usaremos pantalla de bienvenida la comento
  static const ROOT = '/';
 */
  /// *** Home ***
  ///
  static const LoginPage = '/login';

  /// *** Home ***
  ///
  static const HomeScreen = '/home';

  /// *** Ciudades ***
  static const CitiesPage = '/cities';

  /// *** Detalles de las Ciudades ***
  ///
  static const CityDetailPage = '/cities/detail';

  /// *** Usuarios ***
  static const UsersPage = '/users';
}
