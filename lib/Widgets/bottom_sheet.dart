import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsnest/Models/news.model.dart';
import 'package:newsnest/Utils/providers/bookmarks_provider.dart';
import 'package:newsnest/Utils/providers/newslist_provider.dart';
import 'package:newsnest/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomSheetWidget extends StatefulWidget {
  final NewsModel singleNews;
  final int newsIndex;
  final bool isBookmarked;
  const BottomSheetWidget(
      {super.key,
      required this.singleNews,
      required this.newsIndex,
      required this.isBookmarked});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  // for this to work we have to add queries and intent in android manifest file
  void _launchNewsURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.inAppWebView);
    } else {
      throw "Not available at this moment";
    }
  }

  bool isBookmarked = false;

  @override
  void initState() {
    isBookmarked = widget.isBookmarked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: ListView(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                // color: const Color.fromARGB(255, 106, 102, 102),
                borderRadius: BorderRadius.circular(10)),
            // height: 100,
            width: 100,
            child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.singleNews.urlToImage,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 106, 102, 102),
                          borderRadius: BorderRadius.circular(10)),
                      height: 100,
                      width: 100,
                      child: const Icon(Icons.error),
                    )),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            widget.singleNews.title,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: TextColorPicker.primary),
          ),
          Text(
            "${widget.singleNews.author.substring(0, min<int>(23, widget.singleNews.author.length))} • ${widget.singleNews.publishedAt}",
            style:
                const TextStyle(fontSize: 14, color: TextColorPicker.secondary),
          ),
          const Divider(),
          Text(widget.singleNews.description,
              style: const TextStyle(
                  fontSize: 16, color: TextColorPicker.primary)),
          const SizedBox(
            height: 12,
          ),
          Text(widget.singleNews.content,
              style: const TextStyle(
                  fontSize: 16, color: TextColorPicker.primary)),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            TextColorPicker.secondary.withOpacity(0.5)),
                        foregroundColor:
                            MaterialStateProperty.all(TextColorPicker.primary),
                        textStyle: MaterialStateProperty.all(const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                        backgroundColor:
                            MaterialStateProperty.all(BgColorPicker.secondary)),
                    onPressed: () {
                      _launchNewsURL(Uri.parse(widget.singleNews.url));
                    },
                    child: const Text("Read More")),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            TextColorPicker.secondary.withOpacity(0.5)),
                        foregroundColor: isBookmarked
                            ? MaterialStateProperty.all(BgColorPicker.secondary)
                            : MaterialStateProperty.all(
                                TextColorPicker.primary),
                        textStyle: MaterialStateProperty.all(const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                        backgroundColor: isBookmarked
                            ? MaterialStateProperty.all(TextColorPicker.primary)
                            : MaterialStateProperty.all(
                                BgColorPicker.secondary)),
                    onPressed: () {
                      isBookmarked = !isBookmarked;
                      context
                          .read<NewsListProvider>()
                          .toggleBookmark(widget.singleNews, isBookmarked);
                      if (isBookmarked) {
                        context
                            .read<BookmarkListProvider>()
                            .addBookmark(widget.singleNews);
                      } else {
                        context
                            .read<BookmarkListProvider>()
                            .removeBookmark(widget.singleNews);
                      }
                      setState(() {});
                    },
                    child: const Text("Bookmark")),
              ),
            ],
          )
        ],
      ),
    );
  }
}
