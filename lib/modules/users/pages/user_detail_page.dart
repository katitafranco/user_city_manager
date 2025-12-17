import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/widgets/inputs/country_dropdown.dart';
import '../controller/user_detail_logic.dart';

class UserDetailPage extends GetView<UserDetailLogic> {
  const UserDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.state.isEditing.value
                ? 'Editar usuario'
                : 'Crear usuario',
          ),
        ),
      ),
      body: Padding(
        padding: AppTheme.screenPadding,
        child: Obx(() {
          if (controller.state.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// ERROR
                if (controller.state.errorMessage.isNotEmpty)
                  Text(
                    controller.state.errorMessage.value,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),

                const SizedBox(height: AppSpacing.md),

                /// NOMBRE
                _input(controller: controller.state.nameCtrl, label: 'Nombre'),

                /// APELLIDO
                _input(
                  controller: controller.state.lastNameCtrl,
                  label: 'Apellido',
                ),

                /// EMAIL
                _input(
                  controller: controller.state.emailCtrl,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),

                /// TELÉFONO
                _input(
                  controller: controller.state.phoneCtrl,
                  label: 'Teléfono',
                  keyboardType: TextInputType.phone,
                  enabled: !controller.state.isEditing.value,
                ),

                /// CONTRASEÑA (solo CREATE)
                if (!controller.state.isEditing.value)
                  _input(
                    controller: controller.state.passwordCtrl,
                    label: 'Contraseña',
                    obscure: true,
                  ),

                const SizedBox(height: AppSpacing.md),

                /*  /// CIUDAD
                CityDropdown(
                  value: controller.state.selectedCity.value,
                  items: controller.cities,
                  onChanged: controller.onCityChanged,
                ), */
                CountryDropdown(
                  value: controller.state.selectedCityId.value,
                  items: controller.cities
                      .map(
                        (city) => DropdownMenuItem<String>(
                          value: city.id.toString(),
                          child: Text(city.cityName),
                        ),
                      )
                      .toList(),
                  onChanged: controller.onCityIdChanged,
                ),
                const SizedBox(height: AppSpacing.lg),

                /// BOTÓN
                ElevatedButton(
                  onPressed: controller.saveChanges,
                  child: Text(
                    controller.state.isEditing.value
                        ? 'Actualizar usuario'
                        : 'Crear usuario',
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// =========================
  /// INPUT REUTILIZABLE
  /// =========================
  Widget _input({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscure,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
