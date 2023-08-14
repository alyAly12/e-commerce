import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:watches_app/controllers/provider/wishlist_provider.dart';

class CustomHeartButton extends StatelessWidget {
  const CustomHeartButton({super.key, required this.productId});
final String productId;
  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishListProvider>(context);
    return GestureDetector(
      onTap: () {
        wishListProvider.addOrRemoveFromWishList(productId: productId);
      },
      child:  Icon(
        wishListProvider.isProductInWishList(productId: productId)
            ?IconlyBold.heart
            : IconlyLight.heart,
        color: Colors.red,
      ),
    );
  }
}
