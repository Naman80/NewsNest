import 'package:intl/intl.dart';

class NewsModel {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  bool isBookmarked;
  NewsModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.isBookmarked,
  });

  // Factory constructor for creating NewsModel from a Map
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      source: Source.fromJson(json['source']),
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: DateFormat.yMMMd()
          .format(DateTime.parse(json['publishedAt']))
          .toString(),
      content: json['content'] ?? '',
      isBookmarked: json['isBookmarked'] ?? false,
    );
  }
  // Convert NewsModel object to a map
  Map<String, dynamic> toJson() {
    return {
      'source': source.toJson(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': DateFormat.yMMMd().parse(publishedAt).toString(),
      'content': content,
      'isBookmarked': isBookmarked
    };
  }
}

class Source {
  dynamic id;
  String name;

  Source({
    required this.id,
    required this.name,
  });

  // Factory constructor for creating Source from a Map
  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
