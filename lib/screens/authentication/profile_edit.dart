import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/user.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/print_exception.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/rp_button.dart';
import 'package:rasapalembang/widget/rp_image_picker.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';

class ProfileEditPage extends StatefulWidget {
  final Function(String, String, String) onChanged;
  final String nama;
  final String deskripsi;
  final String foto;

  const ProfileEditPage({
    super.key,
    required this.onChanged,
    required this.nama,
    required this.deskripsi,
    required this.foto
  });

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _deskripsiController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _namaController.text = widget.nama;
    _deskripsiController.text = widget.deskripsi;
  }

  void _onImagePicked(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
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
                  initialGambar: widget.foto != ''
                      ? RPUrls.baseUrl + widget.foto
                      : RPUrls.noProfileUrl,
                  onImagePicked: _onImagePicked,
                  buttonLabel: 'Edit foto',
                  imagePreviewWidth: 100,
                  imagePreviewHeight: 100,
                  rounded: true,
                ),
                RPTextFormField(
                  controller: _namaController,
                  labelText: 'Nama',
                  hintText: 'Nama',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                RPTextFormField(
                  controller: _deskripsiController,
                  labelText: 'Deskripsi',
                  hintText: 'Deskripsi',
                  maxLines: 5,
                ),
                const SizedBox(height: 32.0),
                RPButton(
                  width: double.infinity,
                  label: 'Simpan',
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      String nama = _namaController.text;
                      String deskripsi = _deskripsiController.text;
                      File? foto = _selectedImage;

                      final user = request.user;
                      if (user != null) {
                        String message;
                        User? response;
                        try {
                          response = await request.editProfile(
                            nama,
                            deskripsi,
                            foto,
                          );
                          message = 'Berhasil mengubah profile!';
                        } catch(e) {
                          message = printException(e as Exception);
                        }
                        if (context.mounted) {
                          widget.onChanged(
                            nama,
                            deskripsi,
                            response!.foto,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                            ),
                          );
                        }
                      }
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
