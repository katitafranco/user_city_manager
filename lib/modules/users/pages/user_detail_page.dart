import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_theme.dart';
import '../../cities/models/city_model.dart';
import '../controller/user_detail_logic.dart';
import '../models/user_model.dart';

class UserDetailPage extends GetView<UserDetailLogic> {
  const UserDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Usuario'),
        actions: [
          Obx(
            () => TextButton(
              onPressed: controller.toggleEdit,
              child: Text(
                controller.state.isEditing.value ? 'Cancelar' : 'Editar',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: AppTheme.screenPadding,
        child: Obx(() {
          if (controller.state.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.state.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                controller.state.errorMessage.value,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            );
          }

          final user = controller.state.user.value;
          if (user == null) {
            return const Center(child: Text('Usuario no disponible'));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _UserHeader(user: user),
                const SizedBox(height: AppSpacing.lg),
                _UserInfoSection(controller: controller),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _UserHeader extends StatelessWidget {
  final UserModel user;

  const _UserHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppTheme.cardPadding,
        child: Row(
          children: [
            const CircleAvatar(radius: 28, child: Icon(Icons.person)),
            const SizedBox(width: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.userFullName} ${user.userLastName}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  user.userEmail,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _UserInfoSection extends StatelessWidget {
  final UserDetailLogic controller;

  const _UserInfoSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppTheme.cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Información del usuario',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: AppSpacing.md),

            // Nombre
            Obx(() => TextField(
                  controller: controller.state.nameCtrl,
                  enabled: controller.state.isEditing.value,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                )),
            const SizedBox(height: AppSpacing.md),

            // Apellido
            Obx(() => TextField(
                  controller: controller.state.lastNameCtrl,
                  enabled: controller.state.isEditing.value,
                  decoration: const InputDecoration(
                    labelText: 'Apellido',
                    border: OutlineInputBorder(),
                  ),
                )),
            const SizedBox(height: AppSpacing.md),

            // Email
            Obx(() => TextField(
                  controller: controller.state.emailCtrl,
                  enabled: controller.state.isEditing.value,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    border: OutlineInputBorder(),
                  ),
                )),
            const SizedBox(height: AppSpacing.md),

            // Ciudad
            Obx(() => DropdownButtonFormField<CityModel>(
                  initialValue: controller.state.selectedCity.value,
                  items: controller.cities
                      .map(
                        (city) => DropdownMenuItem<CityModel>(
                          value: city,
                          child: Text(city.cityName),
                        ),
                      )
                      .toList(),
                  onChanged: controller.state.isEditing.value
                      ? controller.onCityChanged
                      : null,
                  decoration: const InputDecoration(
                    labelText: 'Ciudad',
                    border: OutlineInputBorder(),
                  ),
                )),

            // Botón guardar
            Obx(() {
              if (!controller.state.isEditing.value) {
                return const SizedBox.shrink();
              }
              return Column(
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.saveChanges,
                      child: const Text('Guardar cambios'),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
