import 'package:flutter/material.dart';
import 'package:rasapalembang/widget/rp_bottom_sheet.dart';

class MultiSelectWidget extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;
  final ValueChanged<List<String>> onSelectionChanged;

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
    _selectedItems = List<String>.from(widget.selectedItems);
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
              ? ""
              : _selectedItems.join(", "),
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
        ElevatedButton(
          onPressed: () {
            widget.onSelectionChanged(_selectedItems);
            Navigator.pop(context);
          },
          child: const Text("Simpan"),
        ),
      ],
    ).show();
  }
}