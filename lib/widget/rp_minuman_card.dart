import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/services/minuman_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/screens/minuman/minuman_edit.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/print_exception.dart';
import 'package:rasapalembang/widget/restoran_detail.dart';
import 'package:rasapalembang/widget/rp_bottom_sheet.dart';
import 'package:rasapalembang/widget/rp_menu_card.dart';
import 'package:rasapalembang/widget/rp_minuman_detail.dart';

class RPMinumanCard extends StatefulWidget {
  final Minuman minuman;
  final bool lihatRestoran;

  const RPMinumanCard({
    super.key,
    required this.minuman,
    this.lihatRestoran = true,
  });

  @override
  State<RPMinumanCard> createState() => _RPMinumanCardState();
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
            RPMinumanDetail(
              minuman: widget.minuman,
              lihatRestoran: widget.lihatRestoran,
            ),
          ],
        ).show();
      },
      onLongPress: () {
        if (widget.lihatRestoran || request.user?.username == widget.minuman.restoran.user) {
          HapticFeedback.lightImpact();
          _showMinumanOption(request);
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

  void _showMinumanOption(UserService request) {
    RPBottomSheet(
      context: context,
      widgets: [
        if (widget.lihatRestoran)
          ListTile(
            leading: Icon(Icons.storefront),
            title: Text('Lihat restoran'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestoranDetail(
                    restoran: widget.minuman.restoran,
                  ),
                ),
              );
            },
          ),
        if (request.user?.username == widget.minuman.restoran.user)
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
        if (request.user?.username == widget.minuman.restoran.user)
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

              if (mounted) {
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
