import 'package:flutter/material.dart';
import 'package:newsnest/Utils/providers/newslist_provider.dart';
import 'package:newsnest/Utils/tap_functions.dart';
import 'package:newsnest/Widgets/custom_appbar.dart';
import 'package:newsnest/Widgets/news_tile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final ScrollController scrollController;
  const HomeScreen(this.scrollController, {super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(
          headingText: "Top Headlines",
          showtrailingIcon: false,
        ),
        Consumer<NewsListProvider>(
          builder: (context, newsListProvider, child) {
            return newsListProvider.newsList.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: scrollController,
                      scrollDirection: Axis.vertical,
                      itemCount: newsListProvider.newsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () => TapFunctions.onNewsTileTap(
                                newsListProvider.newsList[index], context),
                            child: NewsTile(
                                singleNews: newsListProvider.newsList[index]));
                      },
                    ),
                  )
                : newsListProvider.hasNetwork
                    ? const Expanded(
                        child: Center(child: CircularProgressIndicator()))
                    : const Expanded(
                        child: Center(
                        child: Text(
                            "Please turn on Internet and relaunch the app"),
                      ));
          },
        ),
      ],
    );
  }
}
