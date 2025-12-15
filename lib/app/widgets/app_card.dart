/* import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? elevation;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.elevation = 2,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: elevation ?? theme.cardTheme.elevation,
      color: backgroundColor ?? theme.cardTheme.color ?? theme.cardColor,
      shape:
          theme.cardTheme.shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusLg),
          ),
      margin: theme.cardTheme.margin,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusLg),
        child: Padding(
          padding: padding ?? AppTheme.cardPadding, 
          child: child),
      ),
    );
  }
}
 */

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? color;
  final Color? backgroundColor;
  final double? elevation;

  const AppCard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.color,
    this.elevation = 2,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: elevation ?? theme.cardTheme.elevation,
      color: backgroundColor ?? theme.cardTheme.color ?? theme.cardColor,
      shape:
          theme.cardTheme.shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusLg),
          ),
      margin: theme.cardTheme.margin,
      child: InkWell(
       // onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusLg),
        child: Padding(
          padding: padding ?? AppTheme.cardPadding, 
          child: child),
      ),
    );
  }
}
