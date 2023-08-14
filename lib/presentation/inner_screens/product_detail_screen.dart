import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watches_app/widgets/custom_heart_button.dart';
import '../../controllers/provider/cart_provider.dart';
import '../../controllers/provider/product_provider.dart';
import '../../widgets/app_animated_name.dart';
import '../../widgets/custom_subtitle_widget.dart';
import '../../widgets/custom_text_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String id = 'Product-Detail';
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrentProduct = productProvider.findById(productId);
    final cartProvider =Provider.of<CartProvider>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        elevation: 0,
        title: const AppAnimatedName(name: 'Shop Smart'),

      ),
      body: SingleChildScrollView(
        child: getCurrentProduct == null
            ? const SizedBox.shrink()
            : Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: FancyShimmerImage(
                      imageUrl: getCurrentProduct.productImage,
                      height: size.height * 0.45,
                      width: double.infinity,
                      boxFit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 3,
                            child: CustomTextWidget(
                              title: getCurrentProduct.productTitle,
                              fontSize: 25,
                              maxLines: 2,
                            )),
                        Flexible(
                          flex: 1,
                          child: SubTitleWidget(
                            subTitle: '\$${getCurrentProduct.productPrice} ',
                            maxLines: 1,
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                         CustomHeartButton(productId: getCurrentProduct.productId,),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () {
                              if (cartProvider.isProductInCart(
                                  productId: getCurrentProduct.productId)) {
                                return;
                              }
                              cartProvider.addProductToCart(productId: getCurrentProduct.productId);
                            },
                            icon:  Icon(cartProvider.isProductInCart(productId: productId)
                                ? Icons.check
                                : Icons.add_shopping_cart_rounded,),
                            label:  CustomTextWidget(title:cartProvider.isProductInCart(productId: productId)
                                ?'In cart'
                                :'Add to cart'))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                            flex: 3,
                            child: CustomTextWidget(title: 'About this item')),
                        Flexible(
                          flex: 1,
                          child: SubTitleWidget(
                            subTitle:
                                ' in ${getCurrentProduct.productCategory}',
                            maxLines: 1,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SubTitleWidget(
                      subTitle: getCurrentProduct.productDescription,
                      maxLines: 50,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
