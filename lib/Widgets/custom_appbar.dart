import 'package:flutter/material.dart';
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
      decoration: const BoxDecoration(color: Color(0xff1a1a1a)),
      height: 60,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headingText,
            style: const TextStyle(
                fontSize: 24,
                letterSpacing: 0.8,
                fontWeight: FontWeight.w500,
                color: TextColorPicker.primary),
          ),
          showtrailingIcon ? Icon(trailingIcon) : Container()
        ],
      ),
    );
  }
}
