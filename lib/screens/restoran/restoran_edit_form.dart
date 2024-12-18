import 'package:flutter/material.dart';
import 'dart:io';

class RestoranEditForm extends StatefulWidget {
  final Map<String, dynamic> restoran;

  const RestoranEditForm({super.key, required this.restoran});

  @override
  State<RestoranEditForm> createState() => _RestoranEditFormState();
}

class _RestoranEditFormState extends State<RestoranEditForm> {
  late TextEditingController namaController;
  late TextEditingController alamatController;
  late TextEditingController jamBukaController;
  late TextEditingController jamTutupController;
  late TextEditingController nomorTeleponController;

  File? selectedImage;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.restoran['nama']);
    alamatController = TextEditingController(text: widget.restoran['alamat']);
    jamBukaController = TextEditingController(text: widget.restoran['jamBuka']);
    jamTutupController = TextEditingController(text: widget.restoran['jamTutup']);
    nomorTeleponController = TextEditingController(text: widget.restoran['nomorTelepon']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Restoran"),
        backgroundColor: const Color(0xFF54BAB9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(namaController, "Nama Restoran"),
              const SizedBox(height: 16.0),
              _buildTextField(alamatController, "Alamat Restoran"),
              const SizedBox(height: 16.0),
              _buildTextField(jamBukaController, "Jam Buka (HH:MM)", TextInputType.datetime),
              const SizedBox(height: 16.0),
              _buildTextField(jamTutupController, "Jam Tutup (HH:MM)", TextInputType.datetime),
              const SizedBox(height: 16.0),
              _buildTextField(nomorTeleponController, "Nomor Telepon", TextInputType.phone),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'nama': namaController.text,
                    'alamat': alamatController.text,
                    'jamBuka': jamBukaController.text,
                    'jamTutup': jamTutupController.text,
                    'nomorTelepon': nomorTeleponController.text,
                    'gambar': selectedImage?.path ?? widget.restoran['gambar'],
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.cyan[400],
                ),
                child: const Text(
                  "Simpan Perubahan",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      [TextInputType keyboardType = TextInputType.text]) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
