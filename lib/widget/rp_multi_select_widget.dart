import 'package:flutter/material.dart';
import 'package:rasapalembang/widget/rp_bottom_sheet.dart';

class MultiSelectWidget extends StatefulWidget {
  final List<String> items; // Daftar opsi
  final List<String> selectedItems; // Pilihan awal
  final ValueChanged<List<String>> onSelectionChanged; // Callback untuk pilihan baru

  const MultiSelectWidget({
    Key? key,
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _MultiSelectWidgetState createState() => _MultiSelectWidgetState();
}

class _MultiSelectWidgetState extends State<MultiSelectWidget> {
  late List<String> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List<String>.from(widget.selectedItems); // Salin pilihan awal
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showMultiSelectRPBottomSheet(),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Pilih Kategori",
        ),
        child: Text(
          _selectedItems.isEmpty
              ? "Pilih kategori"
              : _selectedItems.join(", "), // Tampilkan kategori yang dipilih
        ),
      ),
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
        ...widget.items.map((item) {
          return ValueListenableBuilder<List<String>>(
            valueListenable: ValueNotifier(_selectedItems),
            builder: (context, selectedItems, _) {
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
                },
              );
            },
          );
        }).toList(),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            widget.onSelectionChanged(_selectedItems); // Kembalikan hasil
            Navigator.pop(context); // Tutup bottom sheet
          },
          child: const Text("Simpan"),
        ),
      ],
    ).show();
  }
}