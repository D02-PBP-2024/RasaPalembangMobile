import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rasapalembang/widget/rp_button.dart';
import 'package:rasapalembang/widget/rp_dropdown_button.dart';
import 'package:rasapalembang/widget/rp_image_picker.dart';
import 'package:rasapalembang/widget/rp_number_picker.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';

class MinumanForm extends StatefulWidget {
  final String?initialNama;
  final String? initialHarga;
  final String? initialDeskripsi;
  final int? initialTingkatKemanisan;
  final String? initialUkuran;
  final String? initialGambar;
  final String imagePickerLabel;
  final String saveButtonLabel;
  final bool? requiredImage;

  const MinumanForm({
    super.key,
    this.initialNama,
    this.initialHarga,
    this.initialDeskripsi,
    this.initialTingkatKemanisan,
    this.initialUkuran,
    this.initialGambar,
    required this.imagePickerLabel,
    required this.saveButtonLabel,
    this.requiredImage = true,
  });

  @override
  State<MinumanForm> createState() => _MinumanFormState();
}

class _MinumanFormState extends State<MinumanForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final ValueNotifier<String?> _ukuranController = ValueNotifier<String?>(null);
  int _tingkatKemanisan = 0;

  File? _selectedImage;

  void _onImagePicked(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialNama != null) {
      _namaController.text = widget.initialNama!;
    }
    if (widget.initialHarga != null) {
      _hargaController.text = widget.initialHarga!;
    }
    if (widget.initialDeskripsi != null) {
      _deskripsiController.text = widget.initialDeskripsi!;
    }
    if (widget.initialTingkatKemanisan != null) {
      _tingkatKemanisan = widget.initialTingkatKemanisan!;
    }
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RPImagePicker(
                  initialGambar: widget.initialGambar,
                  buttonLabel: widget.imagePickerLabel,
                  onImagePicked: _onImagePicked,
                  imagePreviewHeight: 200,
                  imagePreviewWidth: 200,
                ),
                const SizedBox(height: 16.0),
                RPTextFormField(
                  controller: _namaController,
                  labelText: 'Nama',
                  hintText: 'Masukkan nama minuman',
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
                  hintText: 'Masukkan harga minuman',
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
                  hintText: 'Masukkan deskripsi minuman',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Deskripsi tidak boleh kosong!';
                    }
                    return null;
                  },
                ), const SizedBox(height: 16.0),
                RPNumberPicker(
                  labelText: 'Tingkat Kemanisan',
                  initialValue: _tingkatKemanisan,
                  minValue: 0,
                  maxValue: 100,
                  onChanged: (newValue) {
                    setState(() {
                      _tingkatKemanisan = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                RPDropdownButton<String>(
                  labelText: 'Ukuran',
                  hintText: 'Pilih ukuran',
                  items: const ['Kecil', 'Sedang', 'Besar'],
                  selectedItem: widget.initialUkuran,
                  onChanged: (String? value) {
                    if (value == 'Kecil') {
                      _ukuranController.value = 'KECIL';
                    } else if (value == 'Sedang') {
                      _ukuranController.value = 'SEDANG';
                    } else if (value == 'Besar') {
                      _ukuranController.value = 'BESAR';
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Ukuran tidak boleh kosong!';
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
                      File? gambar = _selectedImage;
                      String? ukuran = _ukuranController.value;
                      int tingkatKemanisan = _tingkatKemanisan;
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
