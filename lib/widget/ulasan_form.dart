import 'package:flutter/material.dart';
import 'package:rasapalembang/models/ulasan.dart';
import 'package:rasapalembang/services/ulasan_service.dart';
import 'package:rasapalembang/utils/print_exception.dart';
import 'package:rasapalembang/widget/rp_button.dart';
import 'package:rasapalembang/widget/rp_rating_form_field.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';

class UlasanForm extends StatefulWidget {
  final Ulasan? ulasan;
  final String saveButtonLabel;
  final String restoran;
  final bool edit;

  const UlasanForm({
    super.key,
    this.ulasan,
    required this.saveButtonLabel,
    required this.restoran,
    this.edit = false,
  });

  @override
  State<UlasanForm> createState() => _UlasanFormState();
}

class _UlasanFormState extends State<UlasanForm> {
  final _formKey = GlobalKey<FormState>();
  final _nilaiController = TextEditingController();
  final _deskripsiController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.edit) {
      _nilaiController.text = widget.ulasan!.nilai.toString();
      _deskripsiController.text = widget.ulasan!.deskripsi;
    }
  }

  final ulasanService = UlasanService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.edit)
            ? const Text('Edit Ulasan')
            : const Text('Tambah Ulasan'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RPRatingFormField(
                  controller: _nilaiController,
                ),
                const SizedBox(height: 16.0),
                RPTextFormField(
                  controller: _deskripsiController,
                  labelText: 'Deskripsi',
                  hintText: 'Masukkan deskripsi ulasan',
                  maxLines: 5,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Pesan tidak boleh kosong!';
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final nilai = _nilaiController.text;
      final deskripsi = _deskripsiController.text;

      String message;
      if (widget.edit) {
        widget.ulasan?.nilai = int.parse(nilai);
        widget.ulasan?.deskripsi = deskripsi;

        try {
          await ulasanService.editUlasan(widget.ulasan!);
          message = "Ulasan berhasil diubah";
        } catch (e) {
          message = printException(e as Exception);
        }

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          );
          Navigator.pop(context, true);
        }
      } else {
        try {
          await ulasanService.addUlasan(
              int.parse(nilai), deskripsi, widget.restoran);
          message = "Ulasan berhasil ditambah";
        } catch (e) {
          message = e.toString();
        }

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          );
          Navigator.pop(context, true);
        }
      }
    }
  }
}
