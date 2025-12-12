/* import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF1976D2);
  static const secondary = Color(0xFF42A5F5);
  static const tertiary = Color(0xFF90CAF9);
  static const neutral = Color(0xFF9E9E9E);
  static const settings = Color(0xFF9C27B0);
  static const accent = Color(0xFFFFC107);

  static const textPrimary = Color(0xFF212121);
  static const textSecondary = Color(0xFF616161);

  static const background = Color(0xFFF5F5F5);

  static const card = Colors.white;
  static const border = Color(0xFFE0E0E0);

  static const success = Colors.green;
  static const warning = Colors.orange;
  static const danger = Colors.red;
}
 */

import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF42A5F5);
  static const Color primaryDark = Color(0xFF0D47A1);
  
  // Secondary/Accent Colors
  static const Color secondary = Color(0xFFFFC107);
  static const Color accent = Color(0xFF9C27B0);
  
  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Neutral Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFE0E0E0);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF616161);
  static const Color textDisabled = Color(0xFF9E9E9E);
  static const Color textInverse = Colors.white;
  
  // Status Colors (para botones específicos)
  static const Color userManagement = primary;       // Usuarios usa primary
  static const Color cityManagement = Color(0xFF49AF4C);       // Ciudades usa verde
  static const Color settings = Color(0xFFFF9800);              // Configuración usa naranja
  static const Color about = Color(0xFF9C27B0);      // Acerca de usa morado
  
  // Helper method para obtener color por feature
  static Color getFeatureColor(String feature) {
    switch (feature) {
      case 'users':
        return userManagement;
      case 'cities':
        return cityManagement;
      case 'settings':
        return settings;
      case 'about':
        return about;
      default:
        return primary;
    }
  }
}