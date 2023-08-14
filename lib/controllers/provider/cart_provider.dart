import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:watches_app/controllers/provider/product_provider.dart';
import 'package:watches_app/models/cart_model.dart';
import 'package:watches_app/models/product_model.dart';

class CartProvider with ChangeNotifier
{
  final Map<String,CartModel> _cartItem={};
  Map<String,CartModel>get getCartItem{
    return _cartItem;
  }

  bool isProductInCart({required String productId}){
    return _cartItem.containsKey(productId);
  }

  void addProductToCart({required String productId}){
    _cartItem.putIfAbsent(productId, () => CartModel(
        cartId: const Uuid().v4(),
        productId: productId,
        quantity: 1
    ),
    );
    notifyListeners();
  }
  void upDateQuantity({required String productId,required int quantity}){
    _cartItem.update(productId,
            (value) => CartModel(
                cartId: value.productId,
                productId: productId,
                quantity: quantity
            ),
    );
    notifyListeners();
  }

  double getTotal({required ProductProvider productProvider}){
    double total =0.0;
    _cartItem.forEach((key, value) {
      final ProductModel? geCurrentProduct = productProvider.findById(value.productId);
      if(geCurrentProduct == null){
        total +=0;
      }else{
        total += double.parse(geCurrentProduct.productPrice)*value.quantity;
      }
    });
    return total;
  }

  void removeOneItem({required String productId}){
    _cartItem.remove(productId);
    notifyListeners();
  }

  void clearLocalCard(){
    _cartItem.clear();
    notifyListeners();
  }

  int getQuantity(){
    int total =0;
    _cartItem.forEach((key, value) {
      total+= value.quantity;
    });
    return total;
  }

}