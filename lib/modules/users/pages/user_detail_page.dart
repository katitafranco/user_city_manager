import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_theme.dart';
import '../controller/user_detail_logic.dart';

class UserDetailPage extends GetView<UserDetailLogic> {
  const UserDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de Usuario')),
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
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            );
          }

          final user = controller.state.user.value;
          if (user == null) {
            return const Center(child: Text('Usuario no disponible'));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.userFullName} ${user.userLastName}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.md),

              Text(user.userEmail),
              const SizedBox(height: AppSpacing.lg),

              /// 🔽 Combo de ciudades
              DropdownButtonFormField(
                initialValue: controller.state.selectedCity.value,
                items: controller.state.cities
                    .map(
                      (city) => DropdownMenuItem(
                        value: city,
                        child: Text(city.cityName),
                      ),
                    )
                    .toList(),
                onChanged: controller.onCityChanged,
                decoration: const InputDecoration(
                  labelText: 'Ciudad',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
