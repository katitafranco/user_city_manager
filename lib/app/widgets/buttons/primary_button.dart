import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final bool loading;
  final bool enabled;
  final VoidCallback? onPressed;
   final bool isLoading;

  final IconData? icon;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? iconSize;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
    this.enabled = true,
    this.isLoading = false,
       this.icon,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = textColor ?? Colors.white;
    final effectiveBackgroundColor = backgroundColor ?? AppTheme.primaryColor;
   // final effectiveBorderColor = borderColor ?? AppTheme.primaryColor;
    final effectiveIconSize = iconSize ?? AppTheme.iconSizeMd;

    /* return ElevatedButton(

      onPressed: enabled && !loading ? onPressed : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: loading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  */ return FilledButton(
      onPressed: isLoading ? null : onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: effectiveBackgroundColor,
        foregroundColor: effectiveTextColor,
        padding: AppSpacing.buttonPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMd),
        ),
        textStyle: AppTheme.textTheme(context).labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: effectiveIconSize,
                    color: effectiveTextColor,
                  ),
                if (icon != null) SizedBox(width: AppSpacing.sm),
                Text(
                  text,
                  style: TextStyle(
                    color: effectiveTextColor,
                  ),
                ),
              ],
            ),
    );
  }
}
