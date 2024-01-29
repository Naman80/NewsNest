import 'package:flutter/material.dart';
import 'package:newsnest/Models/news.model.dart';
import 'package:newsnest/Utils/tap_functions.dart';
import 'package:newsnest/Widgets/news_tile.dart';
import 'package:newsnest/backend/api/newsapi.dart';
import 'package:newsnest/constants/colors.dart';

class CustomAppBar extends StatelessWidget {
  final String headingText;
  final bool showtrailingIcon;
  final IconData? trailingIcon;
  const CustomAppBar({
    super.key,
    this.trailingIcon = Icons.search,
    required this.headingText,
    required this.showtrailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headingText,
            style: const TextStyle(
                fontSize: 24,
                letterSpacing: 0.8,
                fontWeight: FontWeight.w600,
                color: TextColorPicker.primary),
          ),
          showtrailingIcon
              ? GestureDetector(
                  onTap: () async {
                    await showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  },
                  child: Icon(
                    trailingIcon,
                  ))
              : Container()
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> news = [
    "first news",
    "Second news",
    "Third news",
    "Fourth news",
    "Fifth news",
  ];
  List<NewsModel> newsList = [];

  Future<List<NewsModel>> fetchNews(String query) async {
    if (query == "") return Future(() => throw Exception());
    final result = await NewsApi.fetchEverythingNews(query: query);
    newsList = result;
    return result;
  }

  @override
  String? get searchFieldLabel => "Search News";
  @override
  TextStyle? get searchFieldStyle =>
      const TextStyle(fontSize: 17, fontWeight: FontWeight.w500);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Container(
        margin: const EdgeInsets.only(right: 10),
        child: IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = "";
              }
            },
            icon: const Icon(Icons.cancel)),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 5),
        child: IconButton(
            onPressed: () {
              close(context, null);
            },
            icon: const Icon(Icons.arrow_back)));
  }

  @override
  Widget buildResults(BuildContext context) {
    print("serach results build is called");
    return FutureBuilder(
        future: fetchNews(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.hasData
                ? snapshot.data!.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => TapFunctions.onNewsTileTap(
                                snapshot.data![index], context),
                            child: NewsTile(singleNews: snapshot.data![index]),
                          );
                        },
                        itemCount: snapshot.data!.length,
                      )
                    : const Center(child: Text("No results found"))
                : const Center(child: Text("Search field is empty"));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print("serach suggestions build is called");
    return ListView.separated(
        itemBuilder: (context, index) {
          return NewsTile(singleNews: newsList[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 5,
            ),
        itemCount: newsList.length);
  }
}
