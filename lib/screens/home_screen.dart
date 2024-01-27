import 'package:flutter/material.dart';
import 'package:newsnest/Models/news.model.dart';
import 'package:newsnest/Widgets/custom_appbar.dart';
import 'package:newsnest/Widgets/news_tile.dart';

class HomeScreen extends StatelessWidget {
  final List<NewsModel> newsList;
  final ScrollController scrollController;
  const HomeScreen(this.scrollController, {super.key, required this.newsList});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(
          headingText: "Top Headlines",
          showtrailingIcon: false,
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            controller: scrollController,
            scrollDirection: Axis.vertical,
            itemCount: newsList.length,
            itemBuilder: (BuildContext context, int index) {
              return NewsTile(singleNews: newsList[index]);
            },
          ),
        ),
      ],
    );
  }
}
