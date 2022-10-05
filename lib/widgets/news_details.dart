import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

// ignore: must_be_immutable
class NewsDetail extends StatelessWidget {
   NewsDetail(
      {super.key,
      required this.imgUrl,
      required this.desc,
      required this.title});
  String title;
  String desc;
  String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(title),
      ),
      backgroundColor: Colors.white,
      body: SizedBox(child: Column(
        children: [
          Image.network(imgUrl),
          Text(desc)
        ],
      ),),
    );
  }
}
