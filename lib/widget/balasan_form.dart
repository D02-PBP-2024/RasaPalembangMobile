import 'package:flutter/material.dart';
import 'package:rasapalembang/models/balasan.dart';
import 'package:rasapalembang/services/balasan_service.dart';
import 'package:rasapalembang/utils/print_exception.dart';
import 'package:rasapalembang/widget/rp_button.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';

class BalasanForm extends StatefulWidget {
  final Balasan? balasan;
  final String saveButtonLabel;
  final String forum;
  final bool edit;

  const BalasanForm({
    super.key,
    this.balasan,
    required this.saveButtonLabel,
    required this.forum,
    this.edit = false,
  });

  @override
  State<BalasanForm> createState() => _BalasanFormState();
}

class _BalasanFormState extends State<BalasanForm> {
  final _formKey = GlobalKey<FormState>();
  final _pesanController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.edit) {
      _pesanController.text = widget.balasan!.pesan;
    }
  }

  final balasanService = BalasanService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.edit)
            ? const Text('Edit Balasan')
            : const Text('Tambah Balasan'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RPTextFormField(
                  controller: _pesanController,
                  labelText: 'Pesan Balasan',
                  hintText: 'Masukkan pesan balasan',
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
      final pesan = _pesanController.text;

      String message;
      if (widget.edit) {
        widget.balasan?.pesan = pesan;

        try {
          final response = await balasanService.editBalasan(widget.balasan!);
          message = "Balasan berhasil diubah";
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
          final response = await balasanService.addBalasan(pesan, widget.forum);
          message = "Balasan berhasil ditambah";
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
      }
    }
  }
}
