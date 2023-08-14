import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeCarouselSwiper extends StatelessWidget {
  const HomeCarouselSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> homeBanner = [
      Image.asset('asset/images/banners/banner1.png'),
      Image.asset('asset/images/banners/banner2.png'),
    ];
    return CarouselSlider(
        items: homeBanner,
        options: CarouselOptions(
          height: 200,
          aspectRatio: 16 / 9,
          viewportFraction: 0.9,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
        ));
  }
}
