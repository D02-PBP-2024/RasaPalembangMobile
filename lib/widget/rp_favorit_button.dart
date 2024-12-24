import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasapalembang/models/makanan.dart';
import 'package:rasapalembang/models/minuman.dart';
import 'package:rasapalembang/models/restoran.dart';
import 'package:rasapalembang/screens/authentication/show_login_bottom.dart';
import 'package:rasapalembang/services/favorit_service.dart';
import 'package:rasapalembang/services/user_service.dart';
import 'package:rasapalembang/utils/color_constants.dart';

class RPFavoritButton extends StatefulWidget {
  final String? favorit;
  final Makanan? makanan;
  final Minuman? minuman;
  final Restoran? restoran;

  const RPFavoritButton({
    super.key,
    this.favorit,
    this.makanan,
    this.minuman,
    this.restoran,
  });

  @override
  State<RPFavoritButton> createState() => _RPFavoritButtonState();
}

class _RPFavoritButtonState extends State<RPFavoritButton> {
  FavoritService favoritService = FavoritService();
  late bool _favorited;

  @override
  void initState() {
    super.initState();
    _favorited = widget.favorit != null;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<UserService>();
    return Positioned(
      top: 4,
      right: 4,
      child: GestureDetector(
        onTap: () async {
          _handleFavorit(context, request);
        },
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: _favorited
            ? Icon(
              Icons.favorite_rounded,
              color: RPColors.merahMuda,
            )
            : Icon(
              Icons.favorite_outline_rounded,
              color: Colors.white,
            ),
        ),
      ),
    );
  }

  void _handleFavorit(BuildContext context, UserService request) async {
    if (_favorited) {
      await favoritService.delete(widget.favorit!);
      setState(() {
        _favorited = false;
      });
    } else {
      if (request.loggedIn) {
        if (widget.makanan != null) {
          await favoritService.add(widget.makanan, null, null);
        } else if (widget.minuman != null) {
          await favoritService.add(null, widget.minuman, null);
        } else if (widget.restoran != null) {
          await favoritService.add(null, null, widget.restoran);
        }
        setState(() {
          _favorited = true;
        });
      } else {
        showLoginBottom(context);
      }
    }
  }
}