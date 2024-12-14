import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RestoranFormPage extends StatefulWidget {
  const RestoranFormPage({super.key});

  @override
  State<RestoranFormPage> createState() => _RestoranFormPageState();
}

class _RestoranFormPageState extends State<RestoranFormPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController jamBukaController = TextEditingController();
  final TextEditingController jamTutupController = TextEditingController();
  final TextEditingController nomorTeleponController = TextEditingController();

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
              _buildTextField(
                controller: namaController,
                label: 'Nama Restoran',
                hintText: 'Masukkan nama restoran',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: alamatController,
                label: 'Alamat Restoran',
                hintText: 'Masukkan alamat restoran',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: jamBukaController,
                label: 'Jam Buka',
                hintText: '08:00',
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: jamTutupController,
                label: 'Jam Tutup',
                hintText: '22:00',
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: nomorTeleponController,
                label: 'Nomor Telepon',
                hintText: 'Masukkan nomor telepon',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _buildImagePicker(),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final newRestoran = {
                      "model": "restoran",
                      "pk": DateTime.now().toString(), // ID unik
                      "fields": {
                        "nama": namaController.text,
                        "alamat": alamatController.text,
                        "jam_buka": jamBukaController.text,
                        "jam_tutup": jamTutupController.text,
                        "nomor_telepon": nomorTeleponController.text,
                        "gambar": selectedImage != null
                            ? selectedImage!.path
                            : "", // Path gambar
                        "user": 0 // User dapat disesuaikan
                      }
                    };

                    Navigator.pop(context, newRestoran);
                  },
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
