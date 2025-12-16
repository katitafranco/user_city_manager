import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecureActionDialog {
  static Future<bool> confirm({
    required String title,
    required String description,
    String otpHint = '123456',
  }) async {
    final TextEditingController otpCtrl = TextEditingController();

    final result = await Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(description),
              const SizedBox(height: 16),
              TextField(
                controller: otpCtrl,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'OTP simulado: $otpHint',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(result: false),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final valid = otpCtrl.text.trim() == otpHint;
                        Get.back(result: valid);
                      },
                      child: const Text('Confirmar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    return result ?? false;
  }
}
