import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/app_colors.dart';
import '../controller/cities_logic.dart';
import '../models/city_model.dart';
import 'city_detail_screen.dart';

class CitiesPage extends GetView<CitiesLogic> {
  const CitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciudades'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshCities,
          ),
        ],
      ),
      body: Padding(
        padding: AppTheme.screenPadding,
        child: Obx(() {
          // 🔄 Loading
          if (controller.state.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ Error
          if (controller.state.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                controller.state.errorMessage.value,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            );
          }

          // 📭 Empty
          if (controller.state.cities.isEmpty) {
            return const Center(child: Text('No hay ciudades registradas'));
          }

          // 📋 List
          return ListView.separated(
            itemCount: controller.state.cities.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (_, index) {
              final CityModel city = controller.state.cities[index];
              /* // Tarjeta de ciudad
              return Card(
                elevation: 2,
                child: ListTile(                  
                  leading: const Icon(Icons.location_city),
                  // Nombre y país
                  title: Text(city.cityName),
                  subtitle: Text('País: ${city.cityCountryCode}'),
                  trailing: Icon(
                    city.state == 1 ? Icons.check_circle : Icons.cancel,
                    color: city.state == 1
                        ? AppColors.success
                        : AppColors.error,
                  ),

                  onTap: () {
                    Get.to(() => CityDetailPage(city: city));
                  },
                ),
              );
             */
              return Card(
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.location_city),

                  // Nombre de la ciudad
                  title: Text(
                    city.cityName,
                    style: TextStyle(
                      decoration: city.state == 0
                          ? TextDecoration.lineThrough
                          : null,
                      color: city.state == 0
                          ? Theme.of(context).disabledColor
                          : null,
                    ),
                  ),

                  // País
                  subtitle: Text('País: ${city.cityCountryCode}'),

                  // Estado + acciones
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Indicador visual de estado
                      Icon(
                        city.state == 1 ? Icons.check_circle : Icons.cancel,
                        color: city.state == 1
                            ? AppColors.success
                            : AppColors.error,
                      ),

                      // Menú de acciones
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'deactivate') {
                            controller.deactivateCity(city.id);
                          }
                        },
                        itemBuilder: (_) => [
                          if (city.state == 1)
                            const PopupMenuItem(
                              value: 'deactivate',
                              child: Text('Desactivar'),
                            ),
                        ],
                      ),
                    ],
                  ),

                  // Navegar al detalle solo si está activa
                  onTap: city.state == 1
                      ? () {
                          Get.to(() => CityDetailPage(city: city));
                        }
                      : null,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
