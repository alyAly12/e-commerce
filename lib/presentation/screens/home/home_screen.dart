import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watches_app/consts/app_color.dart';
import 'package:watches_app/controllers/provider/product_provider.dart';
import 'package:watches_app/presentation/screens/home/home_widgets/category_rounded_widget.dart';
import 'package:watches_app/presentation/screens/home/home_widgets/latest_arrival_widget.dart';
import 'package:watches_app/widgets/custom_text_widget.dart';
import '../../../consts/assets_manager.dart';
import '../../../widgets/app_animated_name.dart';
import 'home_widgets/home_carousel_swiper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider =Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          leading: Image.asset(AssetsManager.shoppingCart),
          title: const AppAnimatedName(name: 'EL-Shazly Store')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeCarouselSwiper(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: CustomTextWidget(title: 'Latest arrival')),
            ),
            SizedBox(
              height: size.height * 0.2,
              child: ListView.builder(
                  itemCount: productProvider.getProducts.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:ChangeNotifierProvider.value (
                          value: productProvider.getProducts[index],
                          child:  LatestArrivalWidget()),
                    );
                  }),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: CustomTextWidget(title: 'Categories')),
            ),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(AppConsts.categoryList.length, (index) {
                return CategoryRoundedWidget(
                  image: AppConsts.categoryList[index].image,
                  title: AppConsts.categoryList[index].name,
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
