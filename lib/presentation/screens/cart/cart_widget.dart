import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watches_app/consts/app_color.dart';
import 'package:watches_app/controllers/provider/cart_provider.dart';
import 'package:watches_app/models/cart_model.dart';
import 'package:watches_app/presentation/screens/cart/quantity_bottom_sheet.dart';
import 'package:watches_app/widgets/custom_heart_button.dart';
import 'package:watches_app/widgets/custom_text_widget.dart';

import '../../../controllers/provider/product_provider.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider =Provider.of<ProductProvider>(context);
    final cartModelProvider =Provider.of<CartModel>(context);
    final getCurrentProduct = productProvider.findById(cartModelProvider.productId);
    final cartProvider =Provider.of<CartProvider>(context);

    Size size = MediaQuery.of(context).size;
    return getCurrentProduct ==null?const SizedBox.shrink() :FittedBox(
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  imageUrl: getCurrentProduct.productImage,
                  height: size.height * 0.2,
                  width: size.height * 0.2,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IntrinsicWidth(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.6,
                          child: CustomTextWidget(
                            title: getCurrentProduct.productTitle,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         CustomTextWidget(
                          title: '\$${getCurrentProduct.productPrice}',
                          color: Colors.green,
                        ),
                        OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    width: 1, color: AppColors.lightPrimary),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                )),
                            onPressed: () async {
                              await showModalBottomSheet(
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          topLeft: Radius.circular(12))),
                                  context: context,
                                  builder: (context) {
                                    return  QuantityBottomSheet(cartModel: cartModelProvider,);
                                  });
                            },
                            icon: const Icon(Icons.keyboard_arrow_down_sharp),
                            label:  CustomTextWidget(title:'${cartModelProvider.quantity}'))
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      cartProvider.removeOneItem(productId:getCurrentProduct.productId);
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomHeartButton(productId: getCurrentProduct.productId,),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
