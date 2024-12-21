import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/services/makanan_service.dart';
import 'package:rasapalembang/utils/print_exception.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/rp_button.dart';
import 'package:rasapalembang/widget/rp_image_picker.dart';
import 'package:rasapalembang/widget/rp_multi_select_widget.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';

class MakananForm extends StatefulWidget {
  final Makanan? makanan;
  final String imagePickerLabel;
  final String saveButtonLabel;
  final Restoran restoran;
  final bool edit;

  const MakananForm({
    super.key,
    this.makanan,
    required this.imagePickerLabel,
    required this.saveButtonLabel,
    required this.restoran,
    this.edit = false,
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

  List<String> _categories = [];
  bool _isLoadingCategories = true;
  File? _selectedImage;

  final makananService = MakananService();

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    if (widget.makanan != null) {
      _namaController.text = widget.makanan!.nama;
      _hargaController.text = '${widget.makanan!.harga}';
      _deskripsiController.text = widget.makanan!.deskripsi;
      _kaloriController.text = '${widget.makanan!.kalori}';
      _kategoriController.value = widget.makanan!.kategori;
    }
  }

  Future<void> _fetchCategories() async {
    try {
      final kategoriMap = await makananService.fetchCategories();
      if (kategoriMap.isNotEmpty) {
        setState(() {
          _categories = kategoriMap.values.toList(); // Simpan nama kategori
          _isLoadingCategories = false;
        });
      } else {
        throw Exception("Tidak ada kategori ditemukan.");
      }
    } catch (e) {
      setState(() {
        _isLoadingCategories = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat kategori: ${e.toString()}')),
      );
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
                  initialGambar: widget.makanan?.gambar != null
                      ? RPUrls.baseUrl + widget.makanan!.gambar
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
                  hintText: 'Masukkan deskripsi makanan',
                  maxLines: 5,
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
                _isLoadingCategories
                    ? CircularProgressIndicator()
                    : MultiSelectWidget(
                        items: _categories, // Ambil daftar kategori dari hasil fetch
                        selectedItems: _kategoriController.value, // Pilihan awal
                        onSelectionChanged: (values) {
                          setState(() {
                            _kategoriController.value = values; // Simpan hasil pilihan
                          });
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
      int kalori = int.parse(_kaloriController.text);
      File? gambar = _selectedImage;
      List<String> kategori = _kategoriController.value;

      String message;
      if (widget.edit) {
        widget.makanan?.nama = nama;
        widget.makanan?.harga = int.parse(harga);
        widget.makanan?.deskripsi = deskripsi;
        widget.makanan?.kalori = kalori;
        widget.makanan?.kategori = kategori;

        try {
          await makananService.edit(widget.makanan!, gambar);
          message = 'Makanan berhasil diubah';
        } catch (e) {
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
          Makanan makanan = Makanan(
            nama: nama,
            harga: int.parse(harga),
            deskripsi: deskripsi,
            gambar: '',
            kalori: kalori,
            kategori: kategori,
            restoran: widget.restoran,
          );

          try {
            await makananService.add(makanan, gambar);
            message = 'Makanan berhasil ditambah';
          } catch (e) {
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
            const SnackBar(
              content: Text('Gambar tidak boleh kosong!'),
            ),
          );
        }
      }
    }
  }
}