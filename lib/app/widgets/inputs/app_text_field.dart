import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final IconData icon;
  final bool isPassword;
  final VoidCallback? onChanged;

  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.hintText,
    this.isPassword = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          onChanged: (_) {
            if (onChanged != null) onChanged!();
          },
          decoration: InputDecoration(
            labelText: hintText,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          textInputAction: isPassword
              ? TextInputAction.done
              : TextInputAction.next,
        ),
      ],
    );
  }
}
