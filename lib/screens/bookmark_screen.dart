import 'package:flutter/material.dart';
import 'package:newsnest/Widgets/custom_appbar.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      CustomAppBar(
        headingText: "Bookmarks",
        showtrailingIcon: true,
        trailingIcon: Icons.edit,
      ),
    ]);
  }
}
