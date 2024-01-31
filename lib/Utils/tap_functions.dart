import 'package:flutter/material.dart';
import 'package:newsnest/Models/news.model.dart';
import 'package:newsnest/Widgets/bottom_sheet.dart';
import 'package:newsnest/constants/colors.dart';

class TapFunctions {
  static void onNewsTileTap(
      {required NewsModel singleNews,
      required BuildContext context,
      required int newsIndex,
      required bool isBookmarked}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: BgColorPicker.primary,
        builder: (context) {
          return BottomSheetWidget(
            singleNews: singleNews,
            newsIndex: newsIndex,
            isBookmarked: isBookmarked,
          );
        });
  }
}
