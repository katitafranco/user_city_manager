import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/widgets/inputs/country_dropdown.dart';

import '../controller/cities_create_logic.dart';

class CityCreatePage extends GetView<CityCreateLogic> {
  const CityCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear ciudad')),
      body: Padding(
        padding: AppTheme.screenPadding,
        child: Obx(() {
          if (controller.state.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (controller.state.errorMessage.isNotEmpty)
                Text(
                  controller.state.errorMessage.value,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),

              const SizedBox(height: AppSpacing.md),

              // 🏙 Nombre
              TextField(
                controller: controller.cityNameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la ciudad',
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // 🌍 País
              CountryDropdown(
                value: controller.selectedCountryCode.value,
                items: controller.countries.map((country) {
                  return DropdownMenuItem<String>(
                    value: country.code,
                    child: Text(country.name),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedCountryCode.value = value;
                },
              ),

              const Spacer(),

              // ✅ BOTÓN REACTIVO CORRECTO
              Obx(() {
  final canSubmit =
      controller.cityName.value.trim().isNotEmpty &&
      controller.selectedCountryCode.value != null;

  return ElevatedButton(
    onPressed: canSubmit ? controller.createCity : null,
    child: const Text('Crear ciudad'),
  );
}),

            ],
          );
        }),
      ),
    );
  }
}
