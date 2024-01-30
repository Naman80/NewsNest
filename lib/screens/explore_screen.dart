import 'package:flutter/material.dart';
import 'package:newsnest/Models/news.model.dart';
import 'package:newsnest/Utils/connectioncheck.dart';
import 'package:newsnest/Utils/providers/newslist_provider.dart';
import 'package:newsnest/Utils/tap_functions.dart';
import 'package:newsnest/Widgets/category_bar.dart';
import 'package:newsnest/Widgets/custom_appbar.dart';
import 'package:newsnest/Widgets/news_tile.dart';
import 'package:newsnest/backend/api/newsapi.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  final ScrollController scrollController;
  List<NewsModel> allNewsList = [];
  ExploreScreen(
    this.scrollController, {
    super.key,
  });

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  void initState() {
    print("explore init state is called");
    super.initState();
    if (widget.allNewsList.isEmpty) {
      widget.allNewsList = context.read<NewsListProvider>().newsList;
    }
  }

  void fetchNews(String category) async {
    print("explore fetch news is called");
    bool hasNetwork = await ConnectionCheck.hasNetwork();
    if (hasNetwork) {
      final newsList = await NewsApi.fetchTopHeadlines(category: category);
      setState(() {
        widget.allNewsList = newsList;
      });
    }
  }

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
  Widget build(BuildContext context) {
    print("explore build is called");
    return Column(
      children: [
        const CustomAppBar(
          headingText: "Explore",
          showtrailingIcon: true,
        ),
        CategoryBar(categoryList: categoryList, fetchCategoryNews: fetchNews),
        widget.allNewsList.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: widget.scrollController,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.allNewsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () => TapFunctions.onNewsTileTap(
                            widget.allNewsList[index], context),
                        child: NewsTile(singleNews: widget.allNewsList[index]));
                  },
                ),
              )
            : const Expanded(
                child: Center(
                    child:
                        Text("Please turn on Internet and relaunch the app")))
      ],
    );
  }
}
