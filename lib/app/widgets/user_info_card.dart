import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  final Map<String, dynamic>? userData;
  final Map<String, dynamic>? cityData;

  const UserInfoCard({
    super.key,
    required this.userData,
    required this.cityData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar + Header
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
                        '${userData?["userFullName"] ?? ""} ${userData?["userLastName"] ?? ""}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userData?["userEmail"] ?? "",
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
            const Divider(),

            // City Info  
            if (cityData != null) ...[
              const Text(
                "Ciudad",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text('Nombre: ${cityData!["cityName"]}'),
              Text('Código: ${cityData!["cityCode"]}'),
              Text('País: ${cityData!["cityCountryCode"]}'),
              const SizedBox(height: 16),
              const Divider(),
            ],

            // User Info
            const Text(
              "Detalles del Usuario",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text('Teléfono: ${userData?["userPhone"] ?? "No especificado"}'),
            Text('Rol actual: ${userData?["userCurrentRole"] ?? "No especificado"}'),
            Text('Estado: ${userData?["state"] == 1 ? "Activo" : "Inactivo"}'),
          ],
        ),
      ),
    );
  }
}
