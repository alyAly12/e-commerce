import 'package:flutter/cupertino.dart';

class ViewedRecentlyModel with ChangeNotifier
{
  final String id;
  final String productId;

  ViewedRecentlyModel({required this.id,required this.productId});
}