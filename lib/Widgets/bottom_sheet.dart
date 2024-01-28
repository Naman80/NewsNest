import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsnest/Models/news.model.dart';
import 'package:newsnest/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomSheetWidget extends StatelessWidget {
  final NewsModel singleNews;
  const BottomSheetWidget({super.key, required this.singleNews});
  // for this to work we have to add queries and intent in android manifest file
  // we can add various intents like send sms , email , dialpad , another app ,etc.
  void _launchNewsURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.inAppWebView);
    } else {
      throw "Not available at this moment";
    }
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
                imageUrl: singleNews.urlToImage,
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
            singleNews.title,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: TextColorPicker.primary),
          ),
          Text(
            "${singleNews.author.substring(0, min<int>(23, singleNews.author.length))} • ${singleNews.publishedAt}",
            style:
                const TextStyle(fontSize: 14, color: TextColorPicker.secondary),
          ),
          const Divider(),
          Text(singleNews.description,
              style: const TextStyle(
                  fontSize: 16, color: TextColorPicker.primary)),
          const SizedBox(
            height: 12,
          ),
          Text(singleNews.content,
              style: const TextStyle(
                  fontSize: 16, color: TextColorPicker.primary)),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
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
                _launchNewsURL(Uri.parse(singleNews.url));
              },
              child: const Text("Read More"))
        ],
      ),
    );
  }
}
