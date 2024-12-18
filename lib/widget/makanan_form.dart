import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rasapalembang/widget/rp_button.dart';
import 'package:rasapalembang/widget/rp_dropdown_button.dart';
import 'package:rasapalembang/widget/rp_image_picker.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';

class MakananForm extends StatefulWidget {
  final String? initialNama;
  final String? initialHarga;
  final String? initialDeskripsi;
  final int? initialKalori;
  final String? initialGambar;
  final List<String>? initialKategori;
  final String imagePickerLabel;
  final String saveButtonLabel;

  const MakananForm({
    super.key,
    this.initialNama,
    this.initialHarga,
    this.initialDeskripsi,
    this.initialKalori,
    this.initialGambar,
    this.initialKategori,
    required this.imagePickerLabel,
    required this.saveButtonLabel,
  });

  @override
  State<MakananForm> createState() => _MakananFormState();
}

class _MakananFormState extends State<MakananForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _kaloriController = TextEditingController();
  final ValueNotifier<List<String>> _kategoriController = ValueNotifier<List<String>>([]);

  File? _selectedImage;

  void _onImagePicked(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Initialize controllers with initial values if available
    if (widget.initialNama != null) {
      _namaController.text = widget.initialNama!;
    }
    if (widget.initialHarga != null) {
      _hargaController.text = widget.initialHarga!;
    }
    if (widget.initialDeskripsi != null) {
      _deskripsiController.text = widget.initialDeskripsi!;
    }
    if (widget.initialKalori != null) {
      _kaloriController.text = widget.initialKalori!.toString();
    }
    if (widget.initialKategori != null) {
      _kategoriController.value = widget.initialKategori!;
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                RPImagePicker(
                  initialGambar: widget.initialGambar,
                  buttonLabel: widget.imagePickerLabel,
                  onImagePicked: _onImagePicked,
                ),
                const SizedBox(height: 16.0),
                RPTextFormField(
                  controller: _namaController,
                  labelText: 'Nama',
                  hintText: 'Masukkan nama makanan',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                RPTextFormField(
                  controller: _hargaController,
                  labelText: 'Harga',
                  hintText: 'Masukkan harga makanan',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Harga tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                RPTextFormField(
                  controller: _deskripsiController,
                  labelText: 'Deskripsi',
                  hintText: 'Masukkan deskripsi makanan',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Deskripsi tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                RPTextFormField(
                  controller: _kaloriController,
                  labelText: 'Kalori',
                  hintText: 'Masukkan jumlah kalori makanan',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Kalori tidak boleh kosong!';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Kalori harus berupa angka!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                RPDropdownButton<List<String>>(
                  labelText: 'Kategori',
                  hintText: 'Pilih kategori',
                  items: const ['Tradisional', 'Cepat Saji', 'Vegan', 'Seafood'],
                  selectedItem: widget.initialKategori,
                  onChanged: (List<String>? value) {
                    _kategoriController.value = value ?? [];
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kategori tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32.0),
                RPButton(
                  width: double.infinity,
                  label: widget.saveButtonLabel,
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      String nama = _namaController.text;
                      String harga = _hargaController.text;
                      String deskripsi = _deskripsiController.text;
                      int kalori = int.parse(_kaloriController.text);
                      File? gambar = _selectedImage;
                      List<String> kategori = _kategoriController.value;

                      // TODO: Handle the submission of the form data
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}