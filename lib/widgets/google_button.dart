

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:watches_app/widgets/custom_text_widget.dart';


class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
      // TODO add sign in method
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GlassmorphicContainer(
            width: size.width*0.4,
            height: 50,
            borderRadius: 12,
            blur: 10,
            alignment: Alignment.bottomCenter,
            border: 2,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('asset/images/gmail.png'),
                ),
                const Flexible(child:  CustomTextWidget(title: 'Google', fontSize: 20, color: Colors.blue))
              ],
            )
        ),
      ),
    );
  }
}

