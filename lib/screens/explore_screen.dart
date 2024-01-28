import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsnest/Models/news.model.dart';
import 'package:newsnest/Utils/tap_functions.dart';
import 'package:newsnest/Widgets/bottom_sheet.dart';
import 'package:newsnest/Widgets/category_bar.dart';
import 'package:newsnest/Widgets/custom_appbar.dart';
import 'package:newsnest/Widgets/news_tile.dart';
import 'package:newsnest/backend/api/newsapi.dart';
import 'package:newsnest/constants/colors.dart';

class ExploreScreen extends StatefulWidget {
  List<NewsModel> newsList;
  final ScrollController scrollController;
  ExploreScreen(this.scrollController, {super.key, required this.newsList});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // List<NewsModel> allNewsList = [];
  @override
  void initState() {
    // print("explore init state is called");
    super.initState();
    // fetchNews();
  }

  void fetchNews(String category) async {
    print("explore fetch news is called");
    final newsList = await NewsApi.fetchTopHeadlines(category: category);
    setState(() {
      widget.newsList = newsList;
    });
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
        widget.newsList.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: widget.scrollController,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.newsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () => TapFunctions.onNewsTileTap(
                            widget.newsList[index], context),
                        child: NewsTile(singleNews: widget.newsList[index]));
                  },
                ),
              )
            : const Expanded(child: Center(child: CircularProgressIndicator()))
      ],
    );
  }
}
