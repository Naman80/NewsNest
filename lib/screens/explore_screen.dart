import 'package:flutter/material.dart';
import 'package:newsnest/Models/news.model.dart';
import 'package:newsnest/Utils/connectioncheck.dart';
import 'package:newsnest/Utils/listpresentcheck.dart';
import 'package:newsnest/Utils/providers/bookmarks_provider.dart';
import 'package:newsnest/Utils/tap_functions.dart';
import 'package:newsnest/Widgets/category_bar.dart';
import 'package:newsnest/Widgets/custom_appbar.dart';
import 'package:newsnest/Widgets/news_tile.dart';
import 'package:newsnest/backend/api/newsapi.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  List<NewsModel> allNewsList = [];
  bool hasConnection = false;
  ExploreScreen({
    super.key,
  });
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<String> categoryList = [
    "General",
    "Entertainment",
    "Technology",
    "Science",
    "Sports",
    "Health",
    "Business",
  ];
  @override
  void initState() {
    fetchNews(categoryList[0]);
    super.initState();
  }

  void fetchNews(String category) async {
    widget.hasConnection = await ConnectionCheck.hasNetwork();
    if (widget.hasConnection) {
      final newsList = await NewsApi.fetchTopHeadlines(category: category);
      setState(() {
        widget.allNewsList = newsList;
      });
    } else {
      widget.allNewsList = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(
          headingText: "Explore",
          showtrailingIcon: true,
        ),
        CategoryBar(categoryList: categoryList, fetchCategoryNews: fetchNews),
        widget.allNewsList.isNotEmpty
            ? Consumer<BookmarkListProvider>(
                builder: (context, bookmarkListProvider, child) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: widget.allNewsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () => TapFunctions.onNewsTileTap(
                                singleNews: widget.allNewsList[index],
                                context: context,
                                newsIndex: index,
                                isBookmarked: ListPresentCheck.listPresentCheck(
                                    list: bookmarkListProvider.bookmarkList,
                                    news: widget.allNewsList[index])),
                            child: NewsTile(
                                singleNews: widget.allNewsList[index]));
                      },
                    ),
                  );
                },
              )
            : widget.hasConnection
                ? const Expanded(
                    child: Center(child: CircularProgressIndicator()))
                : const Expanded(
                    child: Center(
                    child: Text("Please turn on Internet and relaunch the app"),
                  ))
      ],
    );
  }
}
