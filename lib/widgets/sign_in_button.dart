

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:watches_app/consts/app_color.dart';
import 'package:watches_app/widgets/custom_text_widget.dart';

class SignButton extends StatelessWidget {
  const SignButton({super.key, required this.onPressed, required this.title});
  final void Function() onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GlassmorphicContainer(
          width: 350,
          height: 50,
          borderRadius: 12,
          blur: 10,
          alignment: Alignment.bottomCenter,
          border: 1,
          linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFffffff).withOpacity(0.1),
                const Color(0xFFFFFFFF).withOpacity(0.05),
              ],
              stops: const [
                0.1,
                1,
              ]),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFffffff).withOpacity(0.5),
              const Color((0xFFFFFFFF)).withOpacity(0.5),
            ],
          ),
          child:  Center(
            child: CustomTextWidget(title:title, fontSize: 20,  color: AppColors.lightPrimary),
          ),
        ),
      ),
    );
  }
}

