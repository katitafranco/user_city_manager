import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_theme.dart';
import '../controller/cities_logic.dart';
import '../models/city_model.dart';

class CityDetailPage extends StatefulWidget {
  final CityModel city;
  const CityDetailPage({super.key, required this.city});

  @override
  State<CityDetailPage> createState() => _CityDetailPageState();
}

class _CityDetailPageState extends State<CityDetailPage> {
  final CitiesLogic controller = Get.find<CitiesLogic>();

  late final TextEditingController nameCtrl;
  late final TextEditingController codeCtrl;
  late final TextEditingController countryCtrl;

  bool isEditing = false;

  @override
  void initState() {
    super.initState();

    nameCtrl = TextEditingController(text: widget.city.cityName);
    codeCtrl = TextEditingController(text: widget.city.cityCode);
    countryCtrl =
        TextEditingController(text: widget.city.cityCountryCode);
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    codeCtrl.dispose();
    countryCtrl.dispose();
    super.dispose();
  }

  /// Activa / desactiva modo edición
  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;

      // Si cancela, vuelve a valores originales
      if (!isEditing) {
        nameCtrl.text = widget.city.cityName;
        codeCtrl.text = widget.city.cityCode;
        countryCtrl.text = widget.city.cityCountryCode;
      }
    });
  }

  /// Guarda los cambios llamando al controller
  Future<void> saveChanges() async {
    final success = await controller.updateCity(
      cityId: widget.city.id,
      cityName: nameCtrl.text.trim(),
      cityCode: codeCtrl.text.trim(),
      countryCode: countryCtrl.text.trim(),
    );

    if (success) {
      setState(() => isEditing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city.cityName),
        actions: [
          TextButton(
            onPressed: toggleEdit,
            child: Text(
              isEditing ? 'Cancelar' : 'Editar',
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
            // ID
            Text('ID', style: AppTheme.textTheme(context).labelMedium),
            Text(widget.city.id.toString()),

            const SizedBox(height: AppSpacing.md),

            // Nombre
            Text('Nombre',
                style: AppTheme.textTheme(context).labelMedium),
            TextField(
              controller: nameCtrl,
              readOnly: !isEditing,
              decoration: const InputDecoration(
                hintText: 'Nombre de la ciudad',
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Código
            Text('Código',
                style: AppTheme.textTheme(context).labelMedium),
            TextField(
              controller: codeCtrl,
              readOnly: !isEditing,
              decoration: const InputDecoration(
                hintText: 'Código de ciudad',
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // País
            Text('País',
                style: AppTheme.textTheme(context).labelMedium),
            TextField(
              controller: countryCtrl,
              readOnly: !isEditing,
              decoration: const InputDecoration(
                hintText: 'Código de país',
              ),
            ),

            const Spacer(),

            // Guardar
            if (isEditing)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: saveChanges,
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar cambios'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
