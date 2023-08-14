import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:watches_app/controllers/provider/cart_provider.dart';
import 'package:watches_app/presentation/screens/cart/cart_widget.dart';
import 'package:watches_app/presentation/screens/cart/checkout_bottom_sheet.dart';
import 'package:watches_app/presentation/screens/search/search_screen.dart';
import 'package:watches_app/services/dailogs_sercices.dart';
import 'package:watches_app/widgets/app_animated_name.dart';
import 'package:watches_app/widgets/empty_screen.dart';
import '../../../consts/assets_manager.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider =Provider.of<CartProvider>(context);
    return cartProvider.getCartItem.isEmpty
        ? Scaffold(
            body: EmptyScreen(
            title: 'Whoops!',
            secondTitle: 'Your cart is empty',
            thirdTitle: 'Go ahead & Explore',
            image: AssetsManager.shoppingBasket,
            fun: () {
              Navigator.pushReplacementNamed(context, SearchScreen.id);
            },
          ))
        : Scaffold(
            bottomSheet: const CheckOutBottomSheet(),
            appBar: AppBar(
              elevation: 0,
              title:  AppAnimatedName(name: 'Cart (${cartProvider.getCartItem.length})'),
              actions: [
                IconButton(
                    onPressed: () {
                     DialogsServices.appDialog(
                         context: context,
                         title: 'Empty your cart',
                         fct:(){
                           cartProvider.clearLocalCard();
                         });
                    },
                    icon: const Icon(
                      IconlyBold.delete,
                      color: Colors.red,
                    ))
              ],
            ),
            body: ListView.builder(
                itemCount: cartProvider.getCartItem.length,
                itemBuilder: (context, index) {
                  return  ChangeNotifierProvider.value(
                      value: cartProvider.getCartItem.values.toList().reversed.toList()[index],
                      child: const CartWidget());
                }),
          );
  }
}
