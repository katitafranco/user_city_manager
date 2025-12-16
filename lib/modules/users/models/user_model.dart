import '../../cities/models/city_model.dart';

/// Modelo de dominio para un Usuario.
/// Representa un usuario del sistema dentro de la aplicación,
/// no la respuesta completa del backend.
class UserModel {
  final int id;
  final String userUuid;

  final String userFullName;
  final String userLastName;
  final String userEmail;

  /// ID de la ciudad (relación)
  final int userCity;

  /// Objeto ciudad embebido (cuando viene incluido desde la API)
  final CityModel? city;

  /// Estado del usuario (1 = activo, 0 = inactivo)
  final int state;

  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.userUuid,
    required this.userFullName,
    required this.userLastName,
    required this.userEmail,
    required this.userCity,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    this.city,
  });

  /// Crea una instancia de UserModel desde un JSON del backend
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userUuid: json['userUuid'],
      userFullName: json['userFullName'],
      userLastName: json['userLastName'],
      userEmail: json['userEmail'],
      userCity: json['userCity'],
      state: json['state'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      city: json['city'] != null
          ? CityModel.fromJson(json['city'])
          : null,
    );
  }

  /// Permite crear una copia del usuario con cambios parciales
  /// (muy útil para edición y actualización de estado)
  UserModel copyWith({
    int? id,
    String? userUuid,
    String? userFullName,
    String? userLastName,
    String? userEmail,
    int? userCity,
    int? state,
    DateTime? createdAt,
    DateTime? updatedAt,
    CityModel? city,
  }) {
    return UserModel(
      id: id ?? this.id,
      userUuid: userUuid ?? this.userUuid,
      userFullName: userFullName ?? this.userFullName,
      userLastName: userLastName ?? this.userLastName,
      userEmail: userEmail ?? this.userEmail,
      userCity: userCity ?? this.userCity,
      state: state ?? this.state,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      city: city ?? this.city,
    );
  }
}
