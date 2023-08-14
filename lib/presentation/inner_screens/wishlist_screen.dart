import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:watches_app/presentation/screens/search/search_screen.dart';
import '../../consts/assets_manager.dart';
import '../../controllers/provider/wishlist_provider.dart';
import '../../services/dailogs_sercices.dart';
import '../../widgets/app_animated_name.dart';
import '../../widgets/empty_screen.dart';
import '../../widgets/product/product_widget.dart';

class WishListScreen extends StatelessWidget {
  static const String id = 'wishlist';
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishListProvider>(context);

    return wishListProvider.getWishListItem.isEmpty
        ? Scaffold(
            body: EmptyScreen(
            title: 'Whoops!',
            secondTitle: 'Your WishList is empty',
            thirdTitle: 'Go ahead & Explore',
            image: AssetsManager.bagWish,
            fun: () {
              Navigator.pushReplacementNamed(context, SearchScreen.id);
            },
          ))
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(onPressed: (){
                Navigator.canPop(context)?Navigator.pop(context):null;
              }, icon: const Icon(Icons.arrow_back_ios)),
              title:  AppAnimatedName(name: 'WishList (${wishListProvider.getWishListItem.length})'),
              actions: [
                IconButton(
                    onPressed: () {
                      DialogsServices.appDialog(
                          context: context,
                          title: 'Empty your cart',
                          fct:(){
                            wishListProvider.clearLocalWishList();
                          });
                    },
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
                    child: ProductWidget(productId:wishListProvider.getWishListItem.values.toList()[index].productId,),
                  );
                },
                itemCount: wishListProvider.getWishListItem.length,
                crossAxisCount: 2)
          );
  }
}
