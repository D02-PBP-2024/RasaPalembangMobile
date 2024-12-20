import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/forum.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/screens/forum/forum_list.dart';
import 'package:rasapalembang/services/forum_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/print_exception.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/rp_button.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';

class ForumForm extends StatefulWidget {
  final Forum? forum;
  final String? initialTopik;
  final String? initialPesan;
  final String saveButtonLabel;
  final String restoran;
  final bool edit;

  const ForumForm({
    super.key,
    this.forum,
    this.initialTopik,
    this.initialPesan,
    required this.saveButtonLabel,
    required this.restoran,
    this.edit = false,
  });

  @override
  State<ForumForm> createState() => _ForumFormState();
}

class _ForumFormState extends State<ForumForm> {
  final _formKey = GlobalKey<FormState>();
  final _topikController = TextEditingController();
  final _pesanController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.edit) {
      _topikController.text = widget.initialPesan!;
      _pesanController.text = widget.initialTopik!;
    }
  }

  final forumService = ForumService();

  @override
  Widget build(BuildContext context) {
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
      final topik = _topikController.text;
      final pesan = _pesanController.text;

      String message;
      try {
        final response =
            await forumService.addForum(topik, pesan, widget.restoran);
        message = "Berhasil menambahkan forum";
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
