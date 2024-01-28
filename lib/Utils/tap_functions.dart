import 'package:flutter/material.dart';
import 'package:newsnest/Models/news.model.dart';
import 'package:newsnest/Widgets/bottom_sheet.dart';
import 'package:newsnest/constants/colors.dart';

class TapFunctions {
  static void onNewsTileTap(NewsModel singleNews, BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: BgColorPicker.primary,
        builder: (context) {
          return BottomSheetWidget(singleNews: singleNews);
        });
  }
}
