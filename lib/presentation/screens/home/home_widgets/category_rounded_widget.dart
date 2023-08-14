import 'package:flutter/material.dart';
import 'package:watches_app/presentation/screens/search/search_screen.dart';
import 'package:watches_app/widgets/custom_subtitle_widget.dart';

class CategoryRoundedWidget extends StatelessWidget {
  const CategoryRoundedWidget(
      {super.key, required this.image, required this.title, });
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
          await Navigator.pushNamed(context, SearchScreen.id,arguments: title);
      },
      child: Column(
        children: [
          Image.asset(
            image,
            width: 50,
            height: 50,
          ),
          const SizedBox(
            height: 15,
          ),
          SubTitleWidget(
            subTitle: title,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
