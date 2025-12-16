import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_theme.dart';
import '../controller/cities_logic.dart';
import '../models/city_model.dart';

class CityDetailPage extends GetView<CitiesLogic> {
  CityDetailPage({super.key});

  /// Recibimos SOLO el ID de la ciudad
  final int cityId = Get.arguments as int;

  /// Controller para el nombre (único campo editable)
  final TextEditingController nameCtrl = TextEditingController();

  /// Estado local de edición
  final RxBool isEditing = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final CityModel? city = controller.getCityById(cityId);

      if (city == null) {
        return const Scaffold(
          body: Center(child: Text('Ciudad no encontrada')),
        );
      }

      // Sincronizar input SOLO cuando no se está editando
      if (!isEditing.value) {
        nameCtrl.text = city.cityName;
      }

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (isEditing.value) {
                _confirmExit();
              } else {
                Get.back();
              }
            },
          ),
          title: Text(city.cityName), // 🔥 reactivo
          actions: [
            TextButton(
              onPressed: () {
                isEditing.value = !isEditing.value;
              },
              child: Text(
                isEditing.value ? 'Cancelar' : 'Editar',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: AppTheme.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Nombre (editable)
              _buildEditableField(
                label: 'Nombre de la ciudad',
                controller: nameCtrl,
                enabled: isEditing.value,
              ),

              const SizedBox(height: AppSpacing.md),

              // 🔹 Código (solo lectura)
              _buildReadOnlyField(
                label: 'Código',
                value: city.cityCode,
              ),

              const SizedBox(height: AppSpacing.md),

              // 🔹 País (solo lectura)
              _buildReadOnlyField(
                label: 'País',
                value: city.cityCountryCode,
              ),

              const SizedBox(height: AppSpacing.lg),

              // 🔹 Botón Guardar
              if (isEditing.value)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final success = await controller.updateCity(
                        cityId: city.id,
                        cityName: nameCtrl.text.trim(),
                      );

                      if (success) {
                        isEditing.value = false;
                      }
                    },
                    child: const Text('Guardar cambios'),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  /// Campo editable
  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required bool enabled,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTheme.textTheme(Get.context!).labelMedium),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          enabled: enabled,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  /// Campo solo lectura
  Widget _buildReadOnlyField({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTheme.textTheme(Get.context!).labelMedium),
        const SizedBox(height: 4),
        TextField(
          controller: TextEditingController(text: value),
          enabled: false,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  /// Confirmación al salir sin guardar
  void _confirmExit() {
    Get.defaultDialog(
      title: 'Salir sin guardar',
      middleText: 'Tienes cambios sin guardar. ¿Deseas salir?',
      textConfirm: 'Salir',
      textCancel: 'Cancelar',
      onConfirm: () {
        Get.back(); // cierra diálogo
        Get.back(); // vuelve a la página anterior
      },
    );
  }
}
