class ArticleModel {
  ArticleModel(this.author, this.title, this.description, this.url,
      this.urlToImage, this.publishedAt, this.content);

  String? author, description, urlToImage, content;
  String title, url, publishedAt;

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
        json['author'],
        json['title'],
        json['desc'],
        json['url'],
        json['urlToImage'],
        json['publishedAt'],
        json['content']);
  }
}