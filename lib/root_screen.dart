import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:watches_app/consts/app_color.dart';
import 'package:watches_app/presentation/screens/cart/cart_screen.dart';
import 'package:watches_app/presentation/screens/home/home_screen.dart';
import 'package:watches_app/presentation/screens/profile/profile_screen.dart';
import 'package:watches_app/presentation/screens/search/search_screen.dart';
import 'package:watches_app/widgets/custom_subtitle_widget.dart';

import 'controllers/provider/cart_provider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late PageController controller;
  int currentScreen = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];
  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentScreen);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider =Provider.of<CartProvider>(context);
    return Scaffold(
        body: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: screens,
        ),
        bottomNavigationBar: NavigationBar(
            indicatorColor: AppColors.lightPrimary,
            elevation: 2,
            selectedIndex: currentScreen,
            height: kBottomNavigationBarHeight,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            onDestinationSelected: (int index) {
              setState(() {
                currentScreen = index;
              });
              controller.jumpToPage(currentScreen);
            },
            destinations:  [
              const NavigationDestination(
                icon: Icon(IconlyLight.home),
                label: '',
              ),
              const NavigationDestination(icon: Icon(IconlyLight.search), label: ''),
              NavigationDestination(
                  icon: Badge(
                      alignment: Alignment.topRight,
                      backgroundColor: Colors.blue,
                      label: SubTitleWidget(
                        subTitle: '${cartProvider.getCartItem.length}',
                        fontSize: 15,
                      ),
                      child: const Icon(IconlyLight.bag_2)),
                  label: ''),
              const NavigationDestination(icon: Icon(IconlyLight.profile), label: ''),
            ]));
  }
}
