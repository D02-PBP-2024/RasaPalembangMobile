import 'package:flutter/material.dart';
import 'package:rasapalembang/widget/rp_button.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';

class ForumForm extends StatefulWidget {
  final String? initialTopik;
  final String? initialPesan;
  final String saveButtonLabel;

  const ForumForm({
    super.key,
    this.initialTopik,
    this.initialPesan,
    required this.saveButtonLabel,
  });

  @override
  State<ForumForm> createState() => _ForumFormState();
}

class _ForumFormState extends State<ForumForm> {
  final _formKey = GlobalKey<FormState>();
  final _topikController = TextEditingController();
  final _pesanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.initialTopik != null) {
      _topikController.text = widget.initialTopik!;
    }
    if (widget.initialPesan != null) {
      _pesanController.text = widget.initialPesan!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Forum'),
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
                  controller: _topikController,
                  labelText: 'Topik',
                  hintText: 'Masukkan topik forum',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Topik tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                RPTextFormField(
                  controller: _pesanController,
                  labelText: 'Pesan',
                  hintText: 'Masukkan pesan forum',
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
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      String topik = _topikController.text;
                      String pesan = _pesanController.text;
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
