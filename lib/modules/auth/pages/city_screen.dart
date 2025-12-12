import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_spacing.dart';
import '../controllers/city_controller.dart';
import 'city_detail_screen.dart';

class CityScreen extends StatelessWidget {
  final CityController _cityController = Get.put(CityController());

  CityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ciudades')),
      body: Obx(() {
        if (_cityController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_cityController.errorMessage.isNotEmpty) {
          return Center(child: Text(_cityController.errorMessage.value));
        }

        if (_cityController.cities.isEmpty) {
          return const Center(child: Text('No hay ciudades disponibles'));
        }

        return RefreshIndicator(
          onRefresh: _cityController.fetchCities,
          child: ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: _cityController.cities.length,
            separatorBuilder: (context, _) =>
                const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final city = _cityController.cities[index];
              return ListTile(
                title: Text(city['cityName']),
                subtitle: Text('Código: ${city['cityCode']}'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => Get.to(() => CityDetailScreen(city: city)),
              );
            },
          ),
        );
      }),
    );
  }
}
