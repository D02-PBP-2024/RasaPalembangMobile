import 'package:flutter/material.dart';
import 'package:rasapalembang/models/forum.dart';
import 'package:rasapalembang/screens/forum/forum_detail.dart';
import 'package:rasapalembang/widget/rp_forum_card.dart';

class ForumListPage extends StatelessWidget {
  final List<Map<String, dynamic>> forumList = [
    {
        "pk": "0eb37f18-88e2-4256-8276-30fa70c4faf7",
        "fields": {
            "topik": "Harga dan Porsi di RM Pondok Kelapo",
            "pesan": "Bagaimana harga dan porsi makanan di RM Pondok Kelapo? Apakah porsi tersebut memuaskan untuk harga yang ditawarkan?",
            "tanggal_posting": "2024-02-14T12:14:00.000Z",
            "user": 15,
            "restoran": "f000d91a-908f-46b6-8dc0-c5e7a370aae1"
        }
    },
    {
        "pk": "11505b49-dc56-4c36-9d30-2717a7a9ac74",
        "fields": {
            "topik": "Kualitas Makanan dan Menu Rekomendasi di Tamken Resto and Cafe",
            "pesan": "Bagaimana kualitas makanan di Tamken Resto and Cafe? Ada menu yang jadi favorit atau rekomendasi?",
            "tanggal_posting": "2024-06-08T05:19:00.000Z",
            "user": 13,
            "restoran": "bfb5f51b-9dec-4269-a42f-d94753b6a2c4"
        }
    },
    {
        "pk": "17519dc9-3238-45d7-8dc1-d3409fa7843e",
        "fields": {
            "topik": "Harga dan Porsi di Saoenk Kito Restaurant",
            "pesan": "Bagaimana harga dan porsi makanan di Saoenk Kito Restaurant? Apakah porsinya sesuai dengan harga dan kualitas?",
            "tanggal_posting": "2023-04-17T18:02:00.000Z",
            "user": 14,
            "restoran": "a9b8eff7-f3c4-4d66-ae28-afef240b0960"
        }
    },
  ];

  ForumListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forum Diskusi"),
      ),
      body: ListView.builder(
        itemCount: forumList.length,
        itemBuilder: (context, index) {
          final forum = Forum.fromJson(forumList[index]);
          return RPForumCard(
            topik: forum.fields.topik,
            pesan: forum.fields.pesan,
            tanggalPosting: forum.fields.tanggalPosting,
            user: "userDummy", // TODO: masih userDummy, nanti benerin lagi
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ForumDetailPage(forum: forum),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
