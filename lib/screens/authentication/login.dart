import 'package:flutter/material.dart';
import 'package:rasapalembang/widget/rp_button.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';
import 'package:rasapalembang/utils/color_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
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
                  label: 'Masuk',
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      String username = _usernameController.text;
                      String password = _passwordController.text;

                      print(username);
                      print(password);
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
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
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
      ),
    );
  }
}
