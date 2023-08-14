import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:watches_app/widgets/custom_text_widget.dart';

class CustomProfileList extends StatelessWidget {
  const CustomProfileList(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.fun});
  final String title;
  final String imagePath;

  final void Function() fun;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        fun();
      },
      leading: Image.asset(
        imagePath,
        height: 30,
      ),
      title: CustomTextWidget(title: title),
      trailing: const Icon(IconlyLight.arrow_right_2),
    );
  }
}
