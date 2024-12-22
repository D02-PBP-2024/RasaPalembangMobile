import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  final _deskripsiController = TextEditingController();
  late int _rating;

  @override
  void initState() {
    super.initState();
    _rating = 0;
    if (widget.edit) {
      _rating = widget.ulasan!.nilai;
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
                RatingBar.builder(
                  itemSize: 48,
                  initialRating: _rating.toDouble(),
                  minRating: 1,
                  itemCount: 5,
                  glow: false,
                  unratedColor: Colors.grey,
                  itemBuilder: (context, index) => Icon(
                    Icons.star_rounded,
                    color: index < _rating.toDouble() ? Colors.amber : Colors.grey,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating.toInt();
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                RPTextFormField(
                  controller: _deskripsiController,
                  labelText: 'Deskripsi',
                  hintText: 'Masukkan deskripsi ulasan',
                  maxLines: 5,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Deskripsi tidak boleh kosong!';
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
      final deskripsi = _deskripsiController.text;

      if (_rating != 0) {
      String message;
      if (widget.edit) {
        widget.ulasan?.nilai = _rating;
        widget.ulasan?.deskripsi = deskripsi;

        try {
          await ulasanService.editUlasan(widget.ulasan!);
          message = "Ulasan berhasil diubah";
        } catch (e) {
          message = printException(e as Exception);
        }

        if (mounted) {
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
                _rating, deskripsi, widget.restoran);
            message = "Ulasan berhasil ditambah";
          } catch (e) {
            message = e.toString();
          }

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
            Navigator.pop(context, true);
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Jangan lupa kasih bintang!'),
          ),
        );
      }
    }
  }
}
