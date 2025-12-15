import 'package:flutter/material.dart';
import '../models/city_model.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_theme.dart';

class CityDetailScreen extends StatelessWidget {
  /// Modelo de ciudad recibido desde la pantalla anterior
  final CityModel city;

  const CityDetailScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(city.cityName)),
      body: Padding(
        padding: AppTheme.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ID de la ciudad
            Text('ID', style: AppTheme.textTheme(context).labelMedium),
            Text(
              city.id.toString(),
              style: AppTheme.textTheme(context).bodyMedium,
            ),

            const SizedBox(height: AppSpacing.md),

            // Nombre de la ciudad
            Text('Nombre', style: AppTheme.textTheme(context).labelMedium),
            Text(city.cityName, style: AppTheme.textTheme(context).bodyLarge),

            const SizedBox(height: AppSpacing.md),

            // Código de ciudad
            Text('Código', style: AppTheme.textTheme(context).labelMedium),
            Text(city.cityCode, style: AppTheme.textTheme(context).bodyMedium),

            const SizedBox(height: AppSpacing.md),

            // País
            Text('País', style: AppTheme.textTheme(context).labelMedium),
            Text(
              city.cityCountryCode,
              style: AppTheme.textTheme(context).bodyMedium,
            ),

            const SizedBox(height: AppSpacing.md),

            // Estado
            Text('Estado', style: AppTheme.textTheme(context).labelMedium),
            Row(
              children: [
                Icon(
                  city.state == 1 ? Icons.check_circle : Icons.cancel,
                  color: city.state == 1 ? Colors.green : Colors.red,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  city.state == 1 ? 'Activo' : 'Inactivo',
                  style: AppTheme.textTheme(context).bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
