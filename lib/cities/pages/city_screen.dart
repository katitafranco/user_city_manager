import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/city_controller.dart';
import '../models/city_model.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_theme.dart';
import '../../app/utils/logger.dart';
import 'city_detail_screen.dart';

class CityScreen extends StatelessWidget {
  CityScreen({super.key});

  /// Controller de ciudades (GetX)
  final CityController controller = Get.put(CityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ciudades')),
      body: Padding(
        padding: AppTheme.screenPadding,
        child: Obx(() {
          // =============================
          // Loading
          // =============================
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // =============================
          // Error
          // =============================
          if (controller.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                controller.errorMessage.value,
                style: AppTheme.textTheme(
                  context,
                ).bodyMedium?.copyWith(color: Colors.red),
              ),
            );
          }

          // =============================
          // Empty state
          // =============================
          if (controller.cities.isEmpty) {
            return const Center(child: Text('No hay ciudades registradas'));
          }

          // =============================
          // Listado de ciudades
          // =============================
          return ListView.separated(
            itemCount: controller.cities.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final CityModel city = controller.cities[index];

              return Card(
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.location_city),

                  // Nombre de la ciudad
                  title: Text(city.cityName),

                  // País
                  subtitle: Text('País: ${city.cityCountryCode}'),

                  // Estado visual
                  trailing: Icon(
                    city.state == 1 ? Icons.check_circle : Icons.cancel,
                    color: city.state == 1 ? Colors.green : Colors.red,
                  ),

                  // =============================
                  // Navegar al detalle
                  // =============================
                  onTap: () {
                    AppLogger.debug('Ciudad seleccionada: ${city.cityName}');

                    Get.to(() => CityDetailScreen(city: city));
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
