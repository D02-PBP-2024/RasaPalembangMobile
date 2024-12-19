import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/screens/minuman/minuman_edit.dart';
import 'package:rasapalembang/services/minuman_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/print_exception.dart';
import 'package:rasapalembang/utils/urls_constants.dart';
import 'package:rasapalembang/widget/rp_bottom_sheet.dart';

class RPMenuDetail extends StatefulWidget {
  final Minuman minuman;

  const RPMenuDetail({
    super.key,
    required this.minuman,
  });

  @override
  _RPMenuDetailState createState() => _RPMenuDetailState();
}

class _RPMenuDetailState extends State<RPMenuDetail> {

  MinumanService minumanService = MinumanService();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    Minuman minuman = widget.minuman;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (minuman.restoran.user == request.user?.username)
            TextButton(
              onPressed: () => _showMinumanOption(),
              child: Icon(Icons.more_vert)
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      '${RPUrls.baseUrl}${minuman.gambar}',
                      width: double.infinity,
                      height: screenWidth - 32,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: menambah ke favorit
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Text(
                minuman.nama,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: RPColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                minuman.deskripsi,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: RPColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                'Rp${minuman.harga.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: RPColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20.0),
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Informasi Restoran'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMinumanOption() {
    List<BottomSheetOption> options = [
      BottomSheetOption(
        icon: Icons.edit,
        title: 'Edit minuman',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MinumanEditPage(
                minuman: widget.minuman,
              ),
            ),
          );
        },
      ),
      BottomSheetOption(
        icon: Icons.delete,
        title: 'Hapus minuman',
        textColor: RPColors.merahMuda,
        iconColor: RPColors.merahMuda,
        onTap: () {
          String message;
          try {
            final response = minumanService.delete(widget.minuman);
            message = 'Minuman berhasil dihapus';
          } catch(e) {
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
        },
      ),
    ];

    RPBottomSheet(context: context, options: options).show();
  }
}
