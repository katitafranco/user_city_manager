/* import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    colorSchemeSeed: Colors.blue,

    appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),

    cardTheme: const CardThemeData(
      elevation: 2,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}
 */
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    
    // Color Scheme basado en AppColors
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
      surface: AppColors.surface,
    ),
    
    // Text Theme que usa AppColors
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.textSecondary,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: AppColors.textDisabled,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textInverse,
      ),
    ),
    
    // AppBar usa primary color
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textInverse,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textInverse,
      ),
    ),
    
    // Card Theme
    cardTheme: CardThemeData(
      elevation: 2,
      color: AppColors.surface,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLg),
        side: const BorderSide(color: AppColors.border, width: 1),
      ),
    ),
    
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textInverse,
        padding: AppSpacing.buttonPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMd),
        ),
        textStyle: ThemeData.light().textTheme.labelLarge,
      ),
    ),
    
    // Icon Theme
    iconTheme: const IconThemeData(
      color: AppColors.textSecondary,
    ),
    
    // Divider Theme
    dividerTheme: const DividerThemeData(
      space: AppSpacing.md,
      thickness: 1,
      color: AppColors.border,
    ),
  );
  
// ============ GETTERS PARA DIMENSIONES ============
  
  // Grid configuration
  static int get gridCrossAxisCount => AppSpacing.gridCrossAxisCount;
  static double get gridSpacing => AppSpacing.gridSpacing;
  static double get gridChildAspectRatio => AppSpacing.gridChildAspectRatio;
  
  
  // Spacing
  static EdgeInsets get screenPadding => AppSpacing.screenPadding;
  static EdgeInsets get cardPadding => AppSpacing.cardPadding;
  static EdgeInsets get buttonPadding => AppSpacing.buttonPadding;
  static EdgeInsets get dialogPadding => AppSpacing.dialogPadding;
  
  // Border radius
  static double get borderRadiusSm => AppSpacing.borderRadiusSm;
  static double get borderRadiusMd => AppSpacing.borderRadiusMd;
  static double get borderRadiusLg => AppSpacing.borderRadiusLg;
  
  // Icon sizes
  static double get iconSizeMd => AppSpacing.iconSizeMd;
  static double get iconSizeLg => AppSpacing.iconSizeLg;
  static double get iconSizeXl => AppSpacing.iconSizeXl;
  
  // Avatar sizes
  static double get avatarSizeMd => AppSpacing.avatarSizeMd;
  static double get avatarSizeLg => AppSpacing.avatarSizeLg;

  // Getters para acceder fácilmente
  static Color get primaryColor => lightTheme.colorScheme.primary;
  static Color get secondaryColor => lightTheme.colorScheme.secondary;
  static Color get backgroundColor => lightTheme.colorScheme.surface;
  static Color get surfaceColor => lightTheme.colorScheme.surface;
  static Color get errorColor => lightTheme.colorScheme.error;
  
  // Feature colors from AppColors
  static Color get userManagementColor => AppColors.userManagement;
  static Color get cityManagementColor => AppColors.cityManagement;
  static Color get settingsColor => AppColors.settings;
  static Color get aboutColor => AppColors.about;

  // Text colors
  static Color get textPrimaryColor => AppColors.textPrimary;
  static Color get textSecondaryColor => AppColors.textSecondary;

  // ============ GETTERS PARA ALINEACIÓN ============
  
  // MainAxisAlignment
  static MainAxisAlignment get centerMain => MainAxisAlignment.center;
  static MainAxisAlignment get startMain => MainAxisAlignment.start;
  static MainAxisAlignment get endMain => MainAxisAlignment.end;
  static MainAxisAlignment get spaceBetweenMain => MainAxisAlignment.spaceBetween;
  static MainAxisAlignment get spaceAroundMain => MainAxisAlignment.spaceAround;
  
  // CrossAxisAlignment  
  static CrossAxisAlignment get stretchCross => CrossAxisAlignment.stretch;
  static CrossAxisAlignment get startCross => CrossAxisAlignment.start;
  static CrossAxisAlignment get centerCross => CrossAxisAlignment.center;
  static CrossAxisAlignment get endCross => CrossAxisAlignment.end;
  
  // MainAxisSize
  static MainAxisSize get minMainAxis => MainAxisSize.min;
  static MainAxisSize get maxMainAxis => MainAxisSize.max;
  
  // TextAlign
  static TextAlign get textCenter => TextAlign.center;
  static TextAlign get textLeft => TextAlign.left;
  static TextAlign get textRight => TextAlign.right;
  static TextAlign get textJustify => TextAlign.justify;
  
  // Helper para obtener theme actual
  static ThemeData get currentTheme => lightTheme;
  
  // Helper para context shortcuts
  static ThemeData of(BuildContext context) => Theme.of(context);
  static TextTheme textTheme(BuildContext context) => Theme.of(context).textTheme;
  static ColorScheme colorScheme(BuildContext context) => Theme.of(context).colorScheme;
}