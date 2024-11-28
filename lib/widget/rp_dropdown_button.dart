import 'package:flutter/material.dart';
import 'package:rasapalembang/utils/color_constants.dart';

class RPDropdownButton<T> extends StatelessWidget {
  final String labelText;
  final String hintText;
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;

  const RPDropdownButton({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.items,
    this.validator,
    this.selectedItem,
    required this.onChanged,
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
              labelText,
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        DropdownButtonFormField<T>(
          value: selectedItem,
          hint: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              hintText,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: RPColors.textFieldPlaceholder,
              ),
            ),
          ),
          items: items.map((item) => DropdownMenuItem<T>(
            value: item,
            child: Text(
              item.toString(),
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          )).toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
