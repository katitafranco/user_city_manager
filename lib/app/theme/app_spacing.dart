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
  
// ============ ALINEACIÓN Y DISTRIBUCIÓN ============
  
  // MainAxisAlignment values (para Column/Row)
  static const MainAxisAlignment centerMain = MainAxisAlignment.center;
  static const MainAxisAlignment startMain = MainAxisAlignment.start;
  static const MainAxisAlignment endMain = MainAxisAlignment.end;
  static const MainAxisAlignment spaceBetweenMain = MainAxisAlignment.spaceBetween;
  static const MainAxisAlignment spaceAroundMain = MainAxisAlignment.spaceAround;
  static const MainAxisAlignment spaceEvenlyMain = MainAxisAlignment.spaceEvenly;
  
  // CrossAxisAlignment values (para Column/Row)
  static const CrossAxisAlignment stretchCross = CrossAxisAlignment.stretch;
  static const CrossAxisAlignment startCross = CrossAxisAlignment.start;
  static const CrossAxisAlignment centerCross = CrossAxisAlignment.center;
  static const CrossAxisAlignment endCross = CrossAxisAlignment.end;
  static const CrossAxisAlignment baselineCross = CrossAxisAlignment.baseline;
  
  // MainAxisSize values
  static const MainAxisSize minMainAxis = MainAxisSize.min;
  static const MainAxisSize maxMainAxis = MainAxisSize.max;
  
  // TextAlign values
  static const TextAlign textCenter = TextAlign.center;
  static const TextAlign textLeft = TextAlign.left;
  static const TextAlign textRight = TextAlign.right;
  static const TextAlign textJustify = TextAlign.justify;
  static const TextAlign textStart = TextAlign.start;
  static const TextAlign textEnd = TextAlign.end;
  
  // VerticalDirection values
  static const VerticalDirection verticalDown = VerticalDirection.down;
  static const VerticalDirection verticalUp = VerticalDirection.up;
  
  // TextDirection values
  static const TextDirection textLTR = TextDirection.ltr;
  static const TextDirection textRTL = TextDirection.rtl;

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