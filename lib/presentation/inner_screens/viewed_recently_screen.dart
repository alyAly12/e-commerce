import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:watches_app/controllers/provider/viewed_provider.dart';

import '../../consts/assets_manager.dart';
import '../../widgets/app_animated_name.dart';
import '../../widgets/empty_screen.dart';
import '../../widgets/product/product_widget.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  static const String id ='viewed-recently';
  const ViewedRecentlyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewedProvider = Provider.of<ViewedProvider>(context);
    return  viewedProvider.getViewedList.isEmpty
        ? Scaffold(
        body: EmptyScreen(
          title: 'Whoops!',
          secondTitle: 'Your History is empty',
          thirdTitle: 'Go ahead & Explore',
          image: AssetsManager.recent,
          fun: () {},
        ))
        : Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(onPressed: (){
            Navigator.canPop(context)?Navigator.pop(context):null;
          }, icon: const Icon(Icons.arrow_back_ios)),
          title:  AppAnimatedName(name: 'History (${viewedProvider.getViewedList.length})'),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconlyBold.delete,
                  color: Colors.red,
                ))
          ],
        ),
        body: DynamicHeightGridView(
            builder: (context, index) {
              return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductWidget(productId: viewedProvider.getViewedList.values.toList()[index].productId,),
              );
            },
            itemCount: viewedProvider.getViewedList.length,
            crossAxisCount: 2)
    );
  }
}
