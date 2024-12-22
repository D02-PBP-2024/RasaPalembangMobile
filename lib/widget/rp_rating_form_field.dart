import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rasapalembang/utils/color_constants.dart';

class RPRatingFormField extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatter;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final VoidCallback? iconOnPressed;
  final int? maxLines;
  final FocusNode? focusNode;

  const RPRatingFormField({
    super.key,
    this.controller,
    this.inputFormatter,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.maxLines,
    this.focusNode,
    this.iconOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const SizedBox(width: 8.0),
            Text(
              "Rating",
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          focusNode: focusNode,
          maxLines: maxLines ?? 1,
          obscureText: obscureText,
          inputFormatters: inputFormatter,
          keyboardType: keyboardType,
          controller: controller,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Rating tidak boleh kosong';
            } else if (int.tryParse(value) == null) {
              return 'Rating harus berupa angka';
            } else if (int.parse(value) < 1 || int.parse(value) > 5) {
              return 'Rating harus diantara 1 sampai 5';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "Masukkan rating (1-5)",
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
                    onPressed: iconOnPressed,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
