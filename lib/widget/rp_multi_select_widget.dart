import 'package:flutter/material.dart';
import 'package:rasapalembang/widget/rp_bottom_sheet.dart';
import 'package:rasapalembang/widget/rp_button.dart';

class RPMultiSelectWidget extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;
  final ValueChanged<List<String>> onSelectionChanged;

  const RPMultiSelectWidget({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
  });

  @override
  State<RPMultiSelectWidget> createState() => _MultiSelectWidgetState();
}

class _MultiSelectWidgetState extends State<RPMultiSelectWidget> {
  late List<String> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List<String>.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 8.0),
            Text(
              'Pilih kategori',
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        GestureDetector(
          onTap: () => _showMultiSelectRPBottomSheet(),
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            child: Text(
              _selectedItems.isEmpty
                  ? ""
                  : _selectedItems.join(", "),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showMultiSelectRPBottomSheet() {
    RPBottomSheet(
      context: context,
      widgets: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Pilih Kategori",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        StatefulBuilder(
          builder: (context, setStateInBottomSheet) {
            return Column(
              children: widget.items.map((item) {
                return CheckboxListTile(
                  value: _selectedItems.contains(item),
                  title: Text(item),
                  onChanged: (isChecked) {
                    setState(() {
                      if (isChecked ?? false) {
                        _selectedItems.add(item);
                      } else {
                        _selectedItems.remove(item);
                      }
                    });
                    setStateInBottomSheet(() {});
                  },
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: RPButton(
            label: 'Simpan',
            width: double.infinity,
            onPressed: () {
              widget.onSelectionChanged(_selectedItems);
              Navigator.pop(context);
            },
          ),
        ),
      ],
    ).show();
  }
}
