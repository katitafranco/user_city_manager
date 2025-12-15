import 'package:flutter/material.dart';
import 'package:user_city_manager/app/theme/app_theme.dart';
import '../theme/app_spacing.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool enabled;
  final IconData? icon;
  final Color? color;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? iconSize;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.icon,
    this.color,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
     this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppTheme.primaryColor;
    final effectiveIconSize = iconSize ?? AppTheme.iconSizeMd;    
    final effectiveBackgroundColor = backgroundColor ?? Colors.transparent;
     final effectiveBorderColor = borderColor ?? effectiveColor;

    return OutlinedButton(
      onPressed: enabled && !isLoading ? onPressed : null,
      style: OutlinedButton.styleFrom(
          backgroundColor: effectiveBackgroundColor,
        foregroundColor: effectiveColor,
        side: BorderSide(
          color: effectiveBorderColor,
          width: 1.5,
        ),
        padding: AppSpacing.buttonPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMd),
        ),
        textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                 color: effectiveColor,
              ),
            )
          : Row(
              mainAxisAlignment: AppTheme.centerMain,
             
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: effectiveIconSize,
                    color: effectiveColor,
                  ),
                  SizedBox(width: AppSpacing.sm),
                ],
                Text(
                  text,
                  style: AppTheme.textTheme(context).labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: effectiveColor,
                  ),
                ),
              ],
            ),
    );
  }
}
// Variante para warning (usando AppColors del theme)
class WarningButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool enabled;
  final IconData? icon;

  const WarningButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      enabled: enabled,
      icon: icon ?? Icons.warning,
      color: AppTheme.currentTheme.colorScheme.error, // O usar AppColors si está en AppTheme
      borderColor: AppTheme.currentTheme.colorScheme.error,
      backgroundColor: AppTheme.currentTheme.colorScheme.error,
    );
  }
}