import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsnest/Models/news.model.dart';

class NewsApi {
  static Future<List<NewsModel>> fetchNewsList() async {
    String apiKey = "7f2fde8120d949e593762165e25e4300";
    String url =
        "https://newsapi.org/v2/top-headlines?category=technology&country=in&apiKey=$apiKey";
    final apiResponse = await http.get(Uri.parse(url));
    final jsonResponse = jsonDecode(apiResponse.body);
    final articlesList = jsonResponse["articles"] as List<dynamic>;
    final transformedList = articlesList.map((e) {
      return NewsModel.fromJson(e);
    }).toList();
    return transformedList;
  }
}
