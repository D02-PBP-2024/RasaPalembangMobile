import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/screens/makanan/makanan_edit.dart';
import 'package:rasapalembang/services/makanan_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/color_constants.dart';
import 'package:rasapalembang/utils/print_exception.dart';
import 'package:rasapalembang/widget/restoran_detail.dart';
import 'package:rasapalembang/widget/rp_bottom_sheet.dart';
import 'package:rasapalembang/widget/rp_favorit_button.dart';
import 'package:rasapalembang/widget/rp_makanan_detail.dart';
import 'package:rasapalembang/widget/rp_menu_card.dart';

class RPMakananCard extends StatefulWidget {
  final Makanan makanan;
  final bool lihatRestoran;

  const RPMakananCard({
    super.key,
    required this.makanan,
    this.lihatRestoran = true,
  });

  @override
  State<RPMakananCard> createState() => _RPMakananCardState();
}

class _RPMakananCardState extends State<RPMakananCard> {
  MakananService makananService = MakananService();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    return GestureDetector(
      onTap: () {
        RPBottomSheet(
          context: context,
          widgets: [
            RPMakananDetail(
              makanan: widget.makanan,
              lihatRestoran: widget.lihatRestoran,
            ),
          ],
        ).show();
      },
      onLongPress: () {
        if (widget.lihatRestoran ||
            request.user?.username == widget.makanan.restoran.user) {
          HapticFeedback.lightImpact();
          _showMakananOption(request);
        }
      },
      child: RPMenuCard(
        id: widget.makanan.pk!,
        gambar: widget.makanan.gambar,
        nama: widget.makanan.nama,
        harga: widget.makanan.harga,
        restoran: widget.makanan.restoran.nama,
        favoritButton: RPFavoritButton(
          favorit: widget.makanan.favorit,
          makanan: widget.makanan,
        ),
      ),
    );
  }

  void _showMakananOption(UserService request) {
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
                    restoran: widget.makanan.restoran,
                  ),
                ),
              );
            },
          ),
        if (request.user?.username == widget.makanan.restoran.user)
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Edit makanan'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MakananEditPage(
                    makanan: widget.makanan,
                  ),
                ),
              );
            },
          ),
        if (request.user?.username == widget.makanan.restoran.user)
          ListTile(
            leading: Icon(
              Icons.delete,
              color: RPColors.merahMuda,
            ),
            title: Text(
              'Hapus makanan',
              style: TextStyle(
                color: RPColors.merahMuda,
              ),
            ),
            onTap: () async {
              Navigator.pop(context);
              String message;
              try {
                final response = await makananService.delete(widget.makanan);
                message = 'Makanan berhasil dihapus';
              } catch (e) {
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
