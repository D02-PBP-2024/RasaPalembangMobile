import 'package:flutter/material.dart';
import 'package:rasapalembang/widget/rp_makanan_card.dart';
import 'package:rasapalembang/widget/rp_menu_card_skeleton.dart';
import 'package:rasapalembang/widget/rp_minuman_card.dart';
import 'package:rasapalembang/widget/rp_restoran_card.dart';

class RPHorizontalListAll extends StatelessWidget {
  final String title;
  final int itemCount;
  final List? data;
  final String? type;

  const RPHorizontalListAll({
    super.key,
    required this.title,
    required this.itemCount,
    this.data,
    this.type,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 287,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(itemCount, (index) {
              final EdgeInsets padding = EdgeInsets.only(
                left: index == 0 ? 8.0 : 4.0,
                right: index == itemCount - 1 ? 8.0 : 4.0,
              );

              Widget item;
              if (type == 'minuman') {
                final minuman = data![index];
                item = RPMinumanCard(minuman: minuman);
              } else if (type == 'makanan') {
                final makanan = data![index];
                item = RPMakananCard(makanan: makanan);
              } else if (type == 'restoran') {
                final restoran = data![index];
                item = RPRestoCard(restoran: restoran);
              } else {
                item = RPMenuCardSkeleton();
              }

              return Padding(
                padding: padding,
                child: SizedBox(
                  width: 200,
                  child: item,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}