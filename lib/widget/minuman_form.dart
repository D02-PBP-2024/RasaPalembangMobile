import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/services/minuman_service.dart';
import 'package:rasapalembang/utils/print_exception.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/rp_button.dart';
import 'package:rasapalembang/widget/rp_dropdown_button.dart';
import 'package:rasapalembang/widget/rp_image_picker.dart';
import 'package:rasapalembang/widget/rp_number_picker.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';

class MinumanForm extends StatefulWidget {
  final Minuman? minuman;
  final String imagePickerLabel;
  final String saveButtonLabel;
  final Restoran restoran;
  final bool edit;

  const MinumanForm({
    super.key,
    this.minuman,
    required this.imagePickerLabel,
    required this.saveButtonLabel,
    required this.restoran,
    this.edit = false,
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

  @override
  void initState() {
    super.initState();
    if (widget.minuman != null) {
      _namaController.text = widget.minuman!.nama;
      _hargaController.text = '${widget.minuman!.harga}';
      _deskripsiController.text = widget.minuman!.deskripsi;
      _ukuranController.value = widget.minuman!.ukuran;
      _tingkatKemanisan = widget.minuman!.tingkatKemanisan;
    }
  }

  void _onImagePicked(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  final minumanService = MinumanService();

  @override
  Widget build(BuildContext context) {
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
                  initialGambar: widget.minuman?.gambar != null
                    ? RPUrls.baseUrl + widget.minuman!.gambar
                    : null,
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
                    if (int.tryParse(value) == null) {
                      return "Harga harus berupa angka!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                RPTextFormField(
                  controller: _deskripsiController,
                  labelText: 'Deskripsi',
                  hintText: 'Masukkan deskripsi minuman',
                  maxLines: 5,
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
                  selectedItem: widget.minuman?.ukuran != null
                    ? _title(widget.minuman!.ukuran)
                    : null,
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
                    _onSubmit();
                  },
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      String nama = _namaController.text;
      String harga = _hargaController.text;
      String deskripsi = _deskripsiController.text;
      File? gambar = _selectedImage;
      String? ukuran = _ukuranController.value;
      int tingkatKemanisan = _tingkatKemanisan;

      String message;
      if (widget.edit) {
        widget.minuman?.nama = nama;
        widget.minuman?.harga = int.parse(harga);
        widget.minuman?.deskripsi = deskripsi;
        widget.minuman?.ukuran = ukuran!;
        widget.minuman?.tingkatKemanisan = tingkatKemanisan;

        try {
          final response = await minumanService.edit(
            widget.minuman!,
            gambar,
          );
          message = 'Minuman berhasil diubah';
        } catch(e) {
          message = printException(e as Exception);
        }

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          );
        }
      } else {
        if (gambar != null) {
          Minuman minuman = Minuman(
            nama: nama,
            harga: int.parse(harga),
            deskripsi: deskripsi,
            gambar: '',
            ukuran: ukuran!,
            tingkatKemanisan: tingkatKemanisan,
            restoran: widget.restoran,
          );

          try {
            final response = await minumanService.add(
              minuman,
              gambar,
            );
            message = 'Minuman berhasil ditambah';
          } catch(e) {
            message = printException(e as Exception);
          }

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
            Navigator.pop(context);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gambar tidak boleh kosong!'),
            ),
          );
        }
      }
    }
  }

  String _title(String string) {
    return "${string[0].toUpperCase()}${string.substring(1).toLowerCase()}";
  }
}
