import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watches_app/models/product_model.dart';
import 'package:watches_app/widgets/custom_bag_button.dart';
import 'package:watches_app/widgets/custom_heart_button.dart';
import '../../../../controllers/provider/viewed_provider.dart';
import '../../../../widgets/custom_subtitle_widget.dart';
import '../../../../widgets/custom_text_widget.dart';
import '../../../inner_screens/product_detail_screen.dart';

class LatestArrivalWidget extends StatelessWidget {
  const LatestArrivalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productModel =Provider.of<ProductModel>(context);
    final viewedProvider = Provider.of<ViewedProvider>(context);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        viewedProvider.addProductToHistory(productId: productModel.productId);
        await Navigator.pushNamed(context, ProductDetailScreen.id,arguments: productModel.productId);
      },
      child: SizedBox(
        width: size.width * 0.50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FancyShimmerImage(
                imageUrl: productModel.productImage,
                height: double.infinity,
                width: size.width * 0.28,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    title: productModel.productTitle,
                    maxLines: 2,
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       CustomHeartButton(productId: productModel.productId),
                      CustomBagButton(productId: productModel.productId,)],
                  ),
                   SubTitleWidget(
                    subTitle: '\$ ${productModel.productPrice}',
                    maxLines: 1,
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
