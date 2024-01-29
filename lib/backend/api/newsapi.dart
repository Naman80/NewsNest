import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsnest/Models/news.model.dart';

String apiKey = "7f2fde8120d949e593762165e25e4300";
String apiKey2 = "3a48b8b11bd24c5fa56c16ed52303b91";

class NewsApi {
  static Future<List<NewsModel>> fetchTopHeadlines(
      {String category = ""}) async {
    String url = "";
    if (category != "") {
      url =
          "https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey2&category=$category";
    } else {
      url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey2";
    }
    final apiResponse = await http.get(Uri.parse(url));
    final jsonResponse = jsonDecode(apiResponse.body);
    final articlesList = jsonResponse["articles"] as List<dynamic>;
    final transformedList = articlesList.map((e) {
      return NewsModel.fromJson(e);
    }).toList();
    return transformedList;
  }

  static Future<List<NewsModel>> fetchEverythingNews(
      {String query = ""}) async {
    String url =
        "https://newsapi.org/v2/everything?pageSize=30&relevancy&apiKey=$apiKey2"
        "&q=$query";
    final apiResponse = await http.get(Uri.parse(url));
    final jsonResponse = jsonDecode(apiResponse.body);
    final articlesList = jsonResponse["articles"] as List<dynamic>;
    final transformedList = articlesList.map((e) {
      return NewsModel.fromJson(e);
    }).toList();
    return transformedList;
  }
}
