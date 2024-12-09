import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rasapalembang/utils/color_constants.dart';

class RPTextFormField extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final List<TextInputFormatter>? inputFormatter;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final IconData? prefixIcon;

  const RPTextFormField({
    super.key,
    this.controller,
    this.labelText,
    required this.hintText,
    this.inputFormatter,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null)
          Row(
            children: [
              const SizedBox(width: 8.0),
              Text(
                labelText!,
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        const SizedBox(height: 8.0),
        TextFormField(
          obscureText: obscureText,
          inputFormatters: inputFormatter,
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: RPColors.textFieldPlaceholder,
            ),
            prefixIcon: prefixIcon != null
              ? IconButton(
              icon: Icon(
                prefixIcon,
                color: RPColors.textFieldPlaceholder,
              ),
              onPressed: () {

              },
            ) : null,
          ),
        ),
      ],
    );
  }
}
