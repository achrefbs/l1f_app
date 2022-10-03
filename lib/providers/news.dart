import 'package:fantasyapp/models/news.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<ArticleModel>> getArticle() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<ArticleModel>> articles;
  var data = await firestore.collection('News').get();

  var articless = await data.docs.map((e) => e.data()).toList();
  print(articless);
  return articless.map((e) => ArticleModel.fromJson(e)).toList();
}
