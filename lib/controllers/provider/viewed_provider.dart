import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:watches_app/models/viewd_recently_model.dart';

class ViewedProvider with ChangeNotifier
{
  final Map<String,ViewedRecentlyModel> _viewedList={};
  Map<String,ViewedRecentlyModel>get getViewedList{
    return _viewedList;
  }

  void addProductToHistory({required String productId}){
    _viewedList.putIfAbsent(productId,
            () => ViewedRecentlyModel(
                id: const Uuid().v4(),
                productId: productId));
    notifyListeners();
  }
}