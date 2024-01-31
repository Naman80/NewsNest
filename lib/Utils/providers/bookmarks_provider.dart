import 'package:flutter/foundation.dart';
import 'package:newsnest/Models/news.model.dart';
import 'package:newsnest/Utils/localstore/bookmarks.dart';
import 'package:provider/provider.dart';

class BookmarkListProvider extends ChangeNotifier {
  List<NewsModel> bookmarkList = [];

  void init() async {
    bookmarkList = await LocalStorageBookmarkList.readData();
  }

  void addBookmark(NewsModel bookmark) {
    bookmarkList.add(bookmark);
    LocalStorageBookmarkList.writeData(bookmarkList);
    notifyListeners();
  }

  void removeBookmark(NewsModel bookmark) {
    // bookmarkList.removeAt(index);
    final filteredBookmarkList = bookmarkList
        .where((element) => element.title != bookmark.title)
        .toList();
    bookmarkList = filteredBookmarkList;
    LocalStorageBookmarkList.writeData(filteredBookmarkList);
    notifyListeners();
  }
}
