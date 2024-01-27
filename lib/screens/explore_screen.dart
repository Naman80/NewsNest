import 'package:flutter/material.dart';
import 'package:newsnest/Models/news.model.dart';
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
        Container(
            height: 40,
            margin: const EdgeInsets.all(10),
            // decoration: const BoxDecoration(color: Colors.pink),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    fetchNews(categoryList[index]);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                    decoration: BoxDecoration(
                        color: BgColorPicker.secondary,
                        border: Border.all(
                            width: 1, color: BgColorPicker.secondary),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      categoryList[index],
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: TextColorPicker.primary),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
            )),
        widget.newsList.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: widget.scrollController,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.newsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NewsTile(singleNews: widget.newsList[index]);
                  },
                ),
              )
            : const Expanded(child: Center(child: CircularProgressIndicator()))
      ],
    );
  }
}
