import 'package:flutter/material.dart';
import 'package:newsnest/Utils/providers/bookmarks_provider.dart';
import 'package:newsnest/Utils/tap_functions.dart';
import 'package:newsnest/Widgets/custom_appbar.dart';
import 'package:newsnest/Widgets/news_tile.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const CustomAppBar(
        headingText: "Bookmarks",
        showtrailingIcon: false,
        // trailingIcon: Icons.edit,
      ),
      Consumer<BookmarkListProvider>(
          builder: (context, bookmarklistProvider, child) {
        return Expanded(
            child: ListView.builder(
          itemCount: bookmarklistProvider.bookmarkList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () => TapFunctions.onNewsTileTap(
                    singleNews: bookmarklistProvider.bookmarkList[index],
                    context: context,
                    newsIndex: index,
                    isBookmarked: true),
                child: NewsTile(
                    singleNews: bookmarklistProvider.bookmarkList[index]));
          },
        ));
      })
    ]);
  }
}
