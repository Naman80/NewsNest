import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsnest/Models/news.model.dart';
import 'package:newsnest/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  final List<NewsModel> newsList;
  final ScrollController scrollController;
  const HomeScreen(this.scrollController, {super.key, required this.newsList});
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20),
          decoration: const BoxDecoration(color: Color(0xff1a1a1a)),
          height: 60,
          alignment: Alignment.centerLeft,
          child: const Text(
            "Top Headlines",
            style: TextStyle(
                fontSize: 24,
                letterSpacing: 0.8,
                fontWeight: FontWeight.w500,
                color: TextColorPicker.primary),
          ),
        ),
        Expanded(
          child: ListView.builder(
            // physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            controller: scrollController,
            scrollDirection: Axis.vertical,
            itemCount: newsList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: const BoxDecoration(
                    // border: Border.all(width: 1, color: Colors.pink)
                    ),
                margin: const EdgeInsets.all(5),
                child: ListTile(
                  trailing: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        // color: const Color.fromARGB(255, 106, 102, 102),
                        borderRadius: BorderRadius.circular(10)),
                    // height: 100,
                    width: 100,
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: newsList[index].urlToImage,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 106, 102, 102),
                                  borderRadius: BorderRadius.circular(10)),
                              height: 100,
                              width: 100,
                              child: const Icon(Icons.error),
                            )),
                  ),
                  // shape: const RoundedRectangleBorder(
                  //   side: BorderSide(width: 1, color: Colors.green),
                  // ),
                  title: Text(
                    newsList[index].title.length > 60
                        ? "${newsList[index].title.substring(0, 60)}..."
                        : newsList[index].title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: TextColorPicker.primary),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
