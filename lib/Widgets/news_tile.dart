import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsnest/Models/news.model.dart';
import 'package:newsnest/constants/colors.dart';
import 'dart:math';

class NewsTile extends StatelessWidget {
  final NewsModel singleNews;
  const NewsTile({super.key, required this.singleNews});
  @override
  Widget build(BuildContext context) {
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
              imageUrl: singleNews.urlToImage,
              placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 106, 102, 102),
                        borderRadius: BorderRadius.circular(10)),
                  ),
              errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 106, 102, 102),
                        borderRadius: BorderRadius.circular(10)),
                    height: 100,
                    child: const Icon(Icons.error),
                  )),
        ),
        shape: const RoundedRectangleBorder(
            // side: BorderSide(width: 1, color: ColorPicker.primary),
            ),
        title: Text(
          singleNews.title.length > 60
              ? "${singleNews.title.substring(0, 60)}..."
              : singleNews.title,
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: TextColorPicker.primary),
        ),
        subtitle: Text(
          "${singleNews.author.substring(0, min<int>(23, singleNews.author.length))} • ${singleNews.publishedAt}",
          style:
              const TextStyle(fontSize: 12, color: TextColorPicker.secondary),
        ),
      ),
    );
  }
}
