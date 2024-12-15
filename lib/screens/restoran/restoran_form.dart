import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RestoranFormPage extends StatefulWidget {
  const RestoranFormPage({super.key});

  @override
  State<RestoranFormPage> createState() => _RestoranFormPageState();
}

class _RestoranFormPageState extends State<RestoranFormPage> {
  final Map<String, TextEditingController> controllers = {
    "Nama restoran": TextEditingController(),
    "Alamat restoran": TextEditingController(),
    "Jam buka": TextEditingController(),
    "Jam tutup": TextEditingController(),
    "Nomor telepon": TextEditingController(),
  };

  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        selectedImage = File(photo.path);
      });
    }
  }

  void _validateAndSave() {
    List<String> errors = [];

    // Validasi semua field secara otomatis
    controllers.forEach((key, controller) {
      if (controller.text.isEmpty) {
        errors.add('$key tidak boleh kosong');
      }
    });

    // Validasi gambar
    if (selectedImage == null) {
      errors.add('Gambar restoran harus dipilih');
    }

    if (errors.isNotEmpty) {
      // Tampilkan semua pesan kesalahan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errors.join('\n')),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    // Buat data restoran baru jika validasi berhasil
    final newRestoran = {
      "model": "restoran",
      "pk": DateTime.now().toString(), // ID unik
      "fields": {
        "nama": controllers["Nama restoran"]!.text,
        "alamat": controllers["Alamat restoran"]!.text,
        "jam_buka": controllers["Jam buka"]!.text,
        "jam_tutup": controllers["Jam tutup"]!.text,
        "nomor_telepon": controllers["Nomor telepon"]!.text,
        "gambar": selectedImage!.path, // Path gambar
        "user": 0 // User dapat disesuaikan
      }
    };

    // Kembali ke halaman sebelumnya dengan data restoran baru
    Navigator.pop(context, newRestoran);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Restoran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...controllers.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      controller: entry.value,
                      label: entry.key,
                      hintText: entry.key.contains("Jam")
                          ? "08:00"
                          : "Masukkan ${entry.key.toLowerCase()}",
                      keyboardType: entry.key.contains("Jam")
                          ? TextInputType.datetime
                          : TextInputType.text,
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }).toList(),
              _buildImagePicker(),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: _validateAndSave,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: const Text(
                    'Simpan Restoran',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: Colors.grey[100],
          ),
        ),
      ],
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gambar Restoran',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (selectedImage != null)
          Image.file(
            selectedImage!,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          )
        else
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Center(
              child: Text(
                'Tidak ada gambar',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pilih dari Galeri'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: _takePhoto,
              child: const Text('Ambil Foto'),
            ),
          ],
        ),
      ],
    );
  }
}
