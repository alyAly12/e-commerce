import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../consts/assets_manager.dart';
import '../../widgets/app_animated_name.dart';
import '../../widgets/empty_screen.dart';
import '../../widgets/product/product_widget.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  static const String id ='viewed-recently';
  const ViewedRecentlyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bool _isEmpty = false;
    return  _isEmpty
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
          title: const AppAnimatedName(name: 'History (5)'),
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
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: ProductWidget(productId: '',),
              );
            },
            itemCount: 10,
            crossAxisCount: 2)
    );
  }
}
