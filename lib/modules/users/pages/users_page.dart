import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_city_manager/app/theme/app_theme.dart';
import 'package:user_city_manager/modules/users/models/user_model.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../routes/app_pages.dart';
import '../controller/users_logic.dart';

class UsersPage extends GetView<UsersLogic> {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshUsers,
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
          if (controller.state.users.isEmpty) {
            return const Center(child: Text('No hay usuarios registrados'));
          }

          // 📋 List
          return ListView.separated(
            itemCount: controller.state.users.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSpacing.sm),
            itemBuilder: (_, index) {
              final UserModel user = controller.state.users[index];

              return Card(
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(
                    '${user.userFullName} ${user.userLastName}',
                    style: TextStyle(
                      decoration: user.state == 0
                          ? TextDecoration.lineThrough
                          : null,
                      color: user.state == 0
                          ? Theme.of(context).disabledColor
                          : null,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.userEmail),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        user.city?.cityName ?? 'Sin ciudad',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ],
                  ),

                  //Estado + acciones
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Indicador visual de estado
                      Icon(
                        user.state == 1 ? Icons.check_circle : Icons.cancel,
                        color: user.state == 1
                            ? AppColors.success
                            : AppColors.error,
                      ),

                      // Menú de acciones
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          controller.toggleUserState(user.id);
                        },
                        itemBuilder: (_) => [
                          if (user.state == 1)
                            const PopupMenuItem(
                              value: 'deactivate',
                              child: Text('Desactivar'),
                            ),
                          if (user.state == 0)
                            const PopupMenuItem(
                              value: 'reactivate',
                              child: Text('Reactivar'),
                            ),
                        ],
                      ),
                    ],
                  ),
                  // Navegar a detalle si está activo y si fue actualizado 
                  // hay que refrescar la lista                  
                  onTap: user.state == 1
                      ? () async {
                          final updated = await Get.toNamed(
                            AppRoutes.UserDetailPage,
                            arguments: user.id,
                          );

                          if (updated == true) {
                            controller.refreshUsers();
                          }
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
