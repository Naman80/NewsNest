import 'package:flutter/material.dart';
import 'package:newsnest/constants/colors.dart';

class CategoryBar extends StatelessWidget {
  final List<String> categoryList;
  final Function(String) fetchCategoryNews;
  const CategoryBar(
      {super.key, required this.categoryList, required this.fetchCategoryNews});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                fetchCategoryNews(categoryList[index]);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                decoration: BoxDecoration(
                    color: BgColorPicker.secondary,
                    border:
                        Border.all(width: 1, color: BgColorPicker.secondary),
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
        ));
  }
}
