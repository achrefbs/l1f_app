import 'package:fantasyapp/vars.dart';
import 'package:fantasyapp/widgets/newscard.dart';
import 'package:flutter/material.dart';
import 'package:fantasyapp/models/news.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool video = false;
  late List<ArticleModel> articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBarColor,
        appBar: AppBar(
          title: const Text(
            'Fantasy News',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection("News").snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text("Something went wrong"));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final docs = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (_, index) {
                    final data = docs[index].data();

                    return NewsCard(
                      imgUrl: data['imgUrl'],
                      title: data['title'],
                      desc: data['desc'],
                      videourl: data['videoUrl'],
                    );
                  });
            }));
  }
}
