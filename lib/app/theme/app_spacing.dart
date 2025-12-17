import 'package:flutter/material.dart';

class AppSpacing {
  // Espaciados comunes (en puntos)
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  
  // Bordes redondeados
  static const double borderRadiusXs = 4.0;
  static const double borderRadiusSm = 8.0;
  static const double borderRadiusMd = 12.0;
  static const double borderRadiusLg = 16.0;
  static const double borderRadiusXl = 24.0;
  static const double borderRadiusRound = 50.0;
  
  // Dimensiones específicas para Grid
  static const double gridSpacing = 16.0;        // Espacio entre items
  static const double gridChildAspectRatio = 1.2; // Relación alto/ancho
  static const int gridCrossAxisCount = 2;        // Columnas en grid
  
  // Dimensiones específicas para Listas
  static const double listItemSpacing = 12.0;
  static const double listItemHeight = 56.0;
  

  
  // Padding comunes
  static const EdgeInsets screenPadding = EdgeInsets.all(md);
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  static const EdgeInsets dialogPadding = EdgeInsets.all(lg);
  
  // Button padding
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    vertical: md,
    horizontal: lg,
  );
  
  // Input padding
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );
  
  // AppBar
  static const EdgeInsets appBarPadding = EdgeInsets.symmetric(horizontal: md);
  
  // Icon sizes
  static const double iconSizeXs = 16.0;
  static const double iconSizeSm = 20.0;
  static const double iconSizeMd = 24.0;
  static const double iconSizeLg = 32.0;
  static const double iconSizeXl = 40.0;
  
  // Avatar sizes
  static const double avatarSizeSm = 32.0;
  static const double avatarSizeMd = 48.0;
  static const double avatarSizeLg = 64.0;
  
  // Helper methods
  static EdgeInsets symmetric({double horizontal = 0, double vertical = 0}) {
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }
  
  static EdgeInsets only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }
  
  static EdgeInsets all(double value) => EdgeInsets.all(value);
}