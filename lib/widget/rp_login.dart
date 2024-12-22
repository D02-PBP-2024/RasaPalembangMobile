import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/print_exception.dart';
import 'package:rasapalembang/widget/rp_button.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';

class RPLogin extends StatefulWidget {
  final VoidCallback redirect;
  final VoidCallback registerPage;

  const RPLogin({
    super.key,
    required this.redirect,
    required this.registerPage
  });

  @override
  State<RPLogin> createState() => _RPLoginState();
}

class _RPLoginState extends State<RPLogin> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset('assets/images/rasapalembang.png'),
              ),
              const SizedBox(height: 16.0),
              RPTextFormField(
                controller: _usernameController,
                labelText: 'Username',
                hintText: 'Masukkan username',
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Username tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              RPTextFormField(
                controller: _passwordController,
                labelText: 'Kata Sandi',
                hintText: 'Masukkan kata sandi',
                obscureText: true,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Kata sandi tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),
              RPButton(
                  width: double.infinity,
                  label: 'Masuk',
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      String username = _usernameController.text;
                      String password = _passwordController.text;

                      String message;
                      bool success = false;
                      try {
                        final response = await request.login(
                          username,
                          password,
                        );
                        message = 'Selamat datang ${response?.username}!';
                        success = true;
                      } catch (e) {
                        message = printException(e as Exception);
                      }

                      if (context.mounted) {
                        if (success && request.loggedIn) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(content: Text(message)),
                            );
                          widget.redirect();
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Login Gagal'),
                              content: Text(message),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    }
                  }
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Belum memiliki akun? ',
                    ),
                    GestureDetector(
                      onTap: widget.registerPage,
                      child: const Text(
                        'Daftar sekarang',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: RPColors.merahMuda,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
