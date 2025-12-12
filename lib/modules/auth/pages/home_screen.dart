import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
  
  HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final userData = _authController.getCurrentUser();
    final cityData = userData?['city'];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _authController.logout,
            tooltip: 'Cerrar Sesión',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Card
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          child: Icon(
                            Icons.person,
                            color: Colors.blue[700],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${userData?['userFullName']} ${userData?['userLastName']}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                userData?['userEmail'] ?? '',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // City Info
                    if (cityData != null) ...[
                      const Divider(),
                      const Text(
                        'Ciudad',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Nombre: ${cityData['cityName']}'),
                      Text('Código: ${cityData['cityCode']}'),
                      Text('País: ${cityData['cityCountryCode']}'),
                    ],
                    
                    // User Details
                    const Divider(),
                    const Text(
                      'Detalles del Usuario',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Teléfono: ${userData?['userPhone'] ?? 'No especificado'}'),
                    Text('Rol actual: ${userData?['userCurrentRole'] ?? 'No especificado'}'),
                    Text('Estado: ${userData?['state'] == 1 ? 'Activo' : 'Inactivo'}'),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Action Buttons
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _buildActionButton(
                    icon: Icons.people,
                    label: 'Usuarios',
                    color: Colors.blue,
                    onTap: () {
                      Get.snackbar(
                        'Próximamente',
                        'Gestión de usuarios',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.location_city,
                    label: 'Ciudades',
                    color: Colors.green,
                    onTap: () {
                      Get.snackbar(
                        'Próximamente',
                        'Gestión de ciudades',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.settings,
                    label: 'Configuración',
                    color: Colors.orange,
                    onTap: () {
                      Get.snackbar(
                        'Próximamente',
                        'Configuración',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.info,
                    label: 'Acerca de',
                    color: Colors.purple,
                    onTap: () {
                      Get.defaultDialog(
                        title: 'Acerca de',
                        content: const Column(
                          children: [
                            Text('Gestión de Usuarios y Ciudades'),
                            SizedBox(height: 8),
                            Text('v1.0.0'),
                            SizedBox(height: 8),
                            Text('Conectado a FeathersJS API'),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}