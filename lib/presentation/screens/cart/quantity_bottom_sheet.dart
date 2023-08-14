import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watches_app/models/cart_model.dart';
import 'package:watches_app/widgets/custom_subtitle_widget.dart';

import '../../../controllers/provider/cart_provider.dart';

class QuantityBottomSheet extends StatelessWidget {
  const QuantityBottomSheet({super.key, required this.cartModel});
final CartModel cartModel;
  @override
  Widget build(BuildContext context) {
    final cartProvider =Provider.of<CartProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 6,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(12)),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      cartProvider.upDateQuantity(productId: cartModel.productId, quantity: index+1);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Center(
                          child: SubTitleWidget(subTitle: '${index + 1}')),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
