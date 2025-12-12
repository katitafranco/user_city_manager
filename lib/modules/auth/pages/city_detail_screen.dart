import 'package:flutter/material.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_theme.dart';

class CityDetailScreen extends StatelessWidget {
  final Map<String, dynamic> city;

  const CityDetailScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(city['cityName'])),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre: ${city['cityName']}',
              style: AppTheme.textTheme(context).bodyLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Código: ${city['cityCode']}',
              style: AppTheme.textTheme(context).bodyMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Estado: ${city['state']}',
              style: AppTheme.textTheme(context).bodyMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'País: ${city['cityCountryCode']}',
              style: AppTheme.textTheme(context).bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
