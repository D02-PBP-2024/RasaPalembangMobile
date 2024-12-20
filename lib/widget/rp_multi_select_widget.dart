import 'package:flutter/material.dart';

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
      onTap: () => _showMultiSelectModal(context),
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

  void _showMultiSelectModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Pilih Kategori",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ...widget.items.map((item) {
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
                  }).toList(),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      widget.onSelectionChanged(_selectedItems); // Kembalikan hasil
                      Navigator.pop(context);
                    },
                    child: const Text("Simpan"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}