import 'package:flutter/material.dart';
import 'package:newsnest/Widgets/custom_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      CustomAppBar(
        headingText: "Profile",
        showtrailingIcon: false,
      ),
    ]);
  }
}
