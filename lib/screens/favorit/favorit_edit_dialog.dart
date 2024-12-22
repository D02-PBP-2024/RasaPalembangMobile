import 'package:flutter/material.dart';

class FavoritEditDialog extends StatelessWidget {
  final String catatan;

  FavoritEditDialog({
    super.key,
    required this.catatan,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: catatan);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Catatan:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: controller,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Masukkan catatan favorit',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context, controller.text);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Save'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
