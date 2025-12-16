class CityModel {
  final int id;
  final String cityName;
  final String cityCode;
  final int state;
  final String cityCountryCode;

  CityModel({
    required this.id,
    required this.cityName,
    required this.cityCode,
    required this.state,
    required this.cityCountryCode,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      cityName: json['cityName'],
      cityCode: json['cityCode'],
      state: json['state'],
      cityCountryCode: json['cityCountryCode'],
    );
  }

  /// Crea una copia del modelo permitiendo modificar campos específicos
  CityModel copyWith({
    String? cityName,
    String? cityCode,
    int? state,
    String? cityCountryCode,
  }) {
    return CityModel(
      id: id,
      cityName: cityName ?? this.cityName,
      cityCode: cityCode ?? this.cityCode,
      state: state ?? this.state,
      cityCountryCode: cityCountryCode ?? this.cityCountryCode,
    );
  }
}
