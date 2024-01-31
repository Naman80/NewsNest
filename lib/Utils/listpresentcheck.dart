import 'package:newsnest/Models/news.model.dart';

class ListPresentCheck {
  static bool listPresentCheck(
      {required List<NewsModel> list, required NewsModel news}) {
    final newlist =
        list.where((element) => element.title == news.title).toList();

    return newlist.isEmpty ? false : true;
  }
}
