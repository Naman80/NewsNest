import 'package:flutter/foundation.dart';
import 'package:newsnest/Models/news.model.dart';
import 'package:newsnest/Utils/connectioncheck.dart';
import 'package:newsnest/Utils/localstore/newslist.dart';
import 'package:newsnest/backend/api/newsapi.dart';

class NewsListProvider extends ChangeNotifier {
  List<NewsModel> _newsList = [];
  bool hasNetwork = false;
  List<NewsModel> get newsList => _newsList;
  // NewsListProvider() {
  //   init();
  // }
  void set(List<NewsModel> val) {
    _newsList = val;
    LocalStorageNewsList.writeData(val);
    notifyListeners();
  }

  void init() async {
    _newsList = await LocalStorageNewsList.readData();
    hasNetwork = await ConnectionCheck.hasNetwork();
    notifyListeners();

    if (hasNetwork) {
      fetchNews();
    }
    notifyListeners();
  }

  void fetchNews() async {
    print("home fetch news is called");
    final newsList = await NewsApi.fetchTopHeadlines();
    // print(newsList);
    set(newsList);
  }
}
