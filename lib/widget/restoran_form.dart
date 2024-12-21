import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/services/restoran_service.dart';
import 'package:rasapalembang/utils/print_exception.dart';
import 'package:rasapalembang/widget/rp_image_picker.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';
import 'package:rasapalembang/widget/rp_button.dart';

class RestoranFormPage extends StatefulWidget {
  final Restoran? restoran; // Null untuk tambah, tidak null untuk edit
  final String imagePickerLabel;
  final String saveButtonLabel;
  final bool edit;

  const RestoranFormPage({
    super.key,
    this.restoran,
    required this.imagePickerLabel,
    required this.saveButtonLabel,
    this.edit = false,
  });

  @override
  State<RestoranFormPage> createState() => _RestoranFormPageState();
}

class _RestoranFormPageState extends State<RestoranFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _jamBukaController = TextEditingController();
  final _jamTutupController = TextEditingController();
  final _nomorTeleponController = TextEditingController();
  File? _selectedImage;

  final RestoranService _restoranService = RestoranService();

  @override
  void initState() {
    super.initState();
    if (widget.restoran != null) {
      _namaController.text = widget.restoran!.nama;
      _alamatController.text = widget.restoran!.alamat;
      _jamBukaController.text = widget.restoran!.jamBuka;
      _jamTutupController.text = widget.restoran!.jamTutup;
      _nomorTeleponController.text = widget.restoran!.nomorTelepon;
    } else {
      _jamBukaController.text = "08:00";
      _jamTutupController.text = "22:00";
    }
  }

  void _onImagePicked(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.edit ? 'Edit Restoran' : 'Tambah Restoran'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RPImagePicker(
                  initialGambar: widget.restoran?.gambar,
                  buttonLabel: widget.imagePickerLabel,
                  onImagePicked: _onImagePicked,
                  imagePreviewWidth: 400,
                  imagePreviewHeight: 400,
                ),
                const SizedBox(height: 16),
                RPTextFormField(
                  controller: _namaController,
                  labelText: 'Nama Restoran',
                  hintText: 'Masukkan nama restoran',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                RPTextFormField(
                  controller: _alamatController,
                  labelText: 'Alamat Restoran',
                  hintText: 'Masukkan alamat restoran',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Alamat tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                RPTextFormField(
                  controller: _jamBukaController,
                  labelText: 'Jam Buka',
                  hintText: '08:00',
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jam buka tidak boleh kosong!';
                    }
                    if (!_isValidTimeFormat(value)) {
                      return 'Format jam buka harus HH:mm!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                RPTextFormField(
                  controller: _jamTutupController,
                  labelText: 'Jam Tutup',
                  hintText: '22:00',
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jam tutup tidak boleh kosong!';
                    }
                    if (!_isValidTimeFormat(value)) {
                      return 'Format jam tutup harus HH:mm!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                RPTextFormField(
                  controller: _nomorTeleponController,
                  labelText: 'Nomor Telepon',
                  hintText: 'Masukkan nomor telepon restoran',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor telepon tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                RPButton(
                  width: double.infinity,
                  label: widget.saveButtonLabel,
                  onPressed: _onSubmit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isValidTimeFormat(String time) {
    final timeRegex = RegExp(r'^\d{2}:\d{2}$');
    return timeRegex.hasMatch(time);
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedImage == null && !widget.edit) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gambar restoran harus dipilih!')),
        );
        return;
      }

      try {
        final userData = await _restoranService.fetchUserData();
        final String userId = userData['id'].toString();

        final restoran = Restoran(
          pk: widget.restoran?.pk ?? '',
          nama: _namaController.text.trim(),
          alamat: _alamatController.text.trim(),
          jamBuka: _jamBukaController.text.trim(),
          jamTutup: _jamTutupController.text.trim(),
          nomorTelepon: _nomorTeleponController.text.trim(),
          gambar: widget.restoran?.gambar ?? '',
          user: userId,
        );

        if (widget.edit) {
          await _restoranService.edit(restoran, _selectedImage);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Restoran berhasil diperbarui')),
          );
        } else {
          await _restoranService.add(restoran, _selectedImage!);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Restoran berhasil ditambahkan')),
          );
        }

        if (context.mounted) Navigator.pop(context);
      } catch (e) {
        String errorMessage = e is Exception
            ? printException(e)
            : 'Terjadi kesalahan yang tidak terduga: ${e.toString()}';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }
}
