// To parse this JSON data, do
//
//     final modelNews = modelNewsFromJson(jsonString);

import 'dart:convert';

ModelNews modelNewsFromJson(String str) => ModelNews.fromJson(json.decode(str));

String modelNewsToJson(ModelNews data) => json.encode(data.toJson());

class ModelNews {
  String message;
  int status;
  List<Article> article;

  ModelNews({
    this.message,
    this.status,
    this.article,
  });

  factory ModelNews.fromJson(Map<String, dynamic> json) => ModelNews(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    article: json["article"] == null ? null : List<Article>.from(json["article"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "article": article == null ? null : List<dynamic>.from(article.map((x) => x.toJson())),
  };
}

class Article {
  String idNews;
  String titleNews;
  String imageNews;
  String contentNews;
  String descriptionNews;
  DateTime dateNews;

  Article({
    this.idNews,
    this.titleNews,
    this.imageNews,
    this.contentNews,
    this.descriptionNews,
    this.dateNews,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    idNews: json["id_news"] == null ? null : json["id_news"],
    titleNews: json["title_news"] == null ? null : json["title_news"],
    imageNews: json["image_news"] == null ? null : json["image_news"],
    contentNews: json["content_news"] == null ? null : json["content_news"],
    descriptionNews: json["description_news"] == null ? null : json["description_news"],
    dateNews: json["date_news"] == null ? null : DateTime.parse(json["date_news"]),
  );

  Map<String, dynamic> toJson() => {
    "id_news": idNews == null ? null : idNews,
    "title_news": titleNews == null ? null : titleNews,
    "image_news": imageNews == null ? null : imageNews,
    "content_news": contentNews == null ? null : contentNews,
    "description_news": descriptionNews == null ? null : descriptionNews,
    "date_news": dateNews == null ? null : "${dateNews.year.toString().padLeft(4, '0')}-${dateNews.month.toString().padLeft(2, '0')}-${dateNews.day.toString().padLeft(2, '0')}",
  };
}
