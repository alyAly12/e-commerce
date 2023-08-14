import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watches_app/controllers/provider/product_provider.dart';
import 'package:watches_app/widgets/custom_text_widget.dart';
import '../../../controllers/provider/cart_provider.dart';


class CheckOutBottomSheet extends StatelessWidget {
  const CheckOutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider =Provider.of<CartProvider>(context);
    final productProvider =Provider.of<ProductProvider>(context);
    return Container(
      decoration: BoxDecoration(
        border: const Border(top: BorderSide(width: 1, color: Colors.grey)),
        color: Theme.of(context).cardColor,
      ),
      height: kBottomNavigationBarHeight + 15,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
              Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(title: 'Total : Prod(${cartProvider.getCartItem.length}) / Items(${cartProvider.getQuantity()})'),
                   CustomTextWidget(
                    title: 'Price \$${cartProvider.getTotal(productProvider: productProvider)}',
                    color: Colors.blue,
                  )
                ],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: () {},
                child: const CustomTextWidget(title: 'Checkout'))
          ],
        ),
      ),
    );
  }
}
