import 'package:json_annotation/json_annotation.dart';
part 'news_model.g.dart';

@JsonSerializable()
class ArticleModel {
  String? author;
  String? title;
  String? description;
  String? publishedAt;
  String? urlToImage;
  String? url;
  ArticleModel({
    this.author,
    this.title,
    this.description,
    this.publishedAt,
    this.urlToImage,
    this.url,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
