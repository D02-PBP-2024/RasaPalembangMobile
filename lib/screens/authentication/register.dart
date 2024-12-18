import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/providers/tab_provider.dart';
import 'package:rasapalembang/screens/home.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/widget/rp_button.dart';
import 'package:rasapalembang/widget/rp_dropdown_button.dart';
import 'package:rasapalembang/widget/rp_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final ValueNotifier<String?> _peranController = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    final selectedTab = Provider.of<TabProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
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
                  controller: _nameController,
                  labelText: 'Nama Lengkap',
                  hintText: 'Masukkan nama lengkap Anda',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama lengkap tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                RPTextFormField(
                  controller: _usernameController,
                  labelText: 'Username',
                  hintText: 'Buat username unik Anda',
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
                  hintText: 'Masukkan kata sandi Anda',
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Kata sandi tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                RPTextFormField(
                  controller: _confirmPasswordController,
                  labelText: 'Konfirmasi Kata Sandi',
                  hintText: 'Konfirmasi kata sandi Anda',
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Konfirmasi kata sandi tidak boleh kosong!';
                    }
                    if (value != _passwordController.text) {
                      return 'Kata sandi tidak cocok!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                RPDropdownButton<String>(
                  labelText: 'Role',
                  hintText: 'Pilih role Anda',
                  items: const ['Pengulas', 'Pemilik Restoran'],
                  selectedItem: null,
                  onChanged: (String? value) {
                    if (value == 'Pengulas') {
                      _peranController.value = 'pengulas';
                    } else if (value == 'Pemilik Restoran') {
                      _peranController.value = 'pemilik_restoran';
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Role tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32.0),
                RPButton(
                  label: 'Daftar',
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      String nama = _nameController.text;
                      String username = _usernameController.text;
                      String password1 = _passwordController.text;
                      String password2 = _confirmPasswordController.text;
                      String? peran = _peranController.value;

                      final response = await request.register(
                        nama,
                        username,
                        password1,
                        password2,
                        peran!,
                      );

                      if (context.mounted) {
                        if (request.loggedIn) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(response['message']),
                            ),
                          );
                          selectedTab.tab = 0;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Registrasi Gagal'),
                              content: Text(response['message']),
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
                        'Sudah memiliki akun? ',
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Masuk',
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
