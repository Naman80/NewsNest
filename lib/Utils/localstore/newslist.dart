import 'dart:convert';
import 'package:newsnest/Models/news.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageNewsList {
  static Future<List<NewsModel>> readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String newsList = prefs.getString('newsList') ?? "";
    final result = newsList != "" ? jsonDecode(newsList) as List<dynamic> : [];
    final transformedList = result.map((e) {
      return NewsModel.fromJson(e);
    }).toList();
    return transformedList;
  }

  static void writeData(List<NewsModel> newsList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('newsList', jsonEncode(newsList));
  }
}
