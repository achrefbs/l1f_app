import 'package:fantasyapp/models/news.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<ArticleModel>> getArticle() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var data = await firestore.collection('News').get();

  var articless = data.docs.map((e) => e.data()).toList();
  return articless.map((e) => ArticleModel.fromJson(e)).toList();
}
