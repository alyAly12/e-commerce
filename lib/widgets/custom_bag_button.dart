import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/provider/cart_provider.dart';
import '../controllers/provider/product_provider.dart';

class CustomBagButton extends StatelessWidget {
  const CustomBagButton({super.key, required this.productId});
  final String productId;


  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrentProduct = productProvider.findById(productId);
    final cartProvider = Provider.of<CartProvider>(context);
    return GestureDetector(
      onTap: () {
        if (cartProvider.isProductInCart(
            productId: getCurrentProduct!.productId)) {
          return;
        }
        cartProvider.addProductToCart(productId: getCurrentProduct.productId);
      },
      child: Icon(
        cartProvider.isProductInCart(productId: productId)
            ? Icons.check
            : Icons.add_shopping_cart_rounded,
        color: Colors.blue,
      ),
    );
  }
}
