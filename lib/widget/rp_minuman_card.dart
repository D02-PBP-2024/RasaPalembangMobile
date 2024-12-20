import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/services/minuman_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/screens/minuman/minuman_edit.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/print_exception.dart';
import 'package:rasapalembang/widget/rp_bottom_sheet.dart';
import 'package:rasapalembang/widget/rp_menu_card.dart';
import 'package:rasapalembang/widget/rp_minuman_detail.dart';

class RPMinumanCard extends StatefulWidget {
  final Minuman minuman;

  RPMinumanCard({
    super.key,
    required this.minuman,
  });

  @override
  _RPMinumanCardState createState() => _RPMinumanCardState();
}

class _RPMinumanCardState extends State<RPMinumanCard> {
  MinumanService minumanService = MinumanService();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    return GestureDetector(
      onTap: () {
        RPBottomSheet(
          context: context,
          widgets: [
            RPMenuDetail(minuman: widget.minuman),
          ],
        ).show();
      },
      onLongPress: () {
        if (request.user?.username == widget.minuman.restoran.user) {
          HapticFeedback.lightImpact();
          _showMinumanOption();
        }
      },
      child: RPMenuCard(
        id: widget.minuman.pk!,
        gambar: widget.minuman.gambar,
        nama: widget.minuman.nama,
        harga: widget.minuman.harga,
        restoran: widget.minuman.restoran.nama,
      ),
    );
  }

  void _showMinumanOption() {
    RPBottomSheet(
      context: context,
      widgets: [
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Edit minuman'),
          onTap: () {
            Navigator.pop(context);
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
        ListTile(
          leading: Icon(
            Icons.delete,
            color: RPColors.merahMuda,
          ),
          title: Text(
            'Hapus minuman',
            style: TextStyle(
              color: RPColors.merahMuda,
            ),
          ),
          onTap: () async {
            Navigator.pop(context);
            String message;
            try {
              final response = await minumanService.delete(widget.minuman);
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
            }
          },
        ),
      ],
    ).show();
  }
}
