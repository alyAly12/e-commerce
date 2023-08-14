import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:watches_app/models/wishlist_model.dart';

class WishListProvider with ChangeNotifier
{
  final Map<String,WishListModel>_wishListItem={};
  Map<String,WishListModel>get getWishListItem{
    return _wishListItem;
  }

  bool isProductInWishList({required String productId}){
    return _wishListItem.containsKey(productId);
  }

  void addOrRemoveFromWishList({required String productId}){
    if(_wishListItem.containsKey(productId)){
      _wishListItem.remove(productId);
    }else{
      _wishListItem.putIfAbsent(productId,
              () => WishListModel(
              id:const Uuid().v4(),
              productId: productId));
    }
    notifyListeners();
  }

  void clearLocalWishList(){
    _wishListItem.clear();
    notifyListeners();
  }

}