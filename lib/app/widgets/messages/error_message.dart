import 'package:flutter/material.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_colors.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;

  const ErrorMessage({
    super.key,
    required this.message,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = backgroundColor ?? theme.colorScheme.errorContainer;
    final textCol = textColor ?? theme.colorScheme.onErrorContainer;
    final iconCol = iconColor ?? theme.colorScheme.error;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMd),
        border: Border.all(color: iconColor ?? AppColors.error),
      ),
      child: Row(
        children: [
          Icon(
            icon ?? Icons.error_outline,
            color: iconCol,
            size: AppSpacing.iconSizeMd,
          ),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textCol,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
