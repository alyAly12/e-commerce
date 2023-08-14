import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:watches_app/consts/assets_manager.dart';
import 'package:watches_app/presentation/auth/login/login_screen.dart';
import 'package:watches_app/presentation/inner_screens/viewed_recently_screen.dart';
import 'package:watches_app/presentation/inner_screens/wishlist_screen.dart';
import 'package:watches_app/widgets/app_animated_name.dart';
import 'package:watches_app/widgets/custom_profile_list.dart';
import 'package:watches_app/widgets/custom_subtitle_widget.dart';
import 'package:watches_app/widgets/custom_text_widget.dart';

import '../../../controllers/provider/theme_provider.dart';
import '../../inner_screens/orders/order_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: Image.asset(AssetsManager.shoppingCart),
          title: const AppAnimatedName(name: 'EL-Shazly Store')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Visibility(
            visible: false,
            child: CustomTextWidget(
              title: 'Please create an account to have unlimited access',
              maxLines: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.background,
                          width: 3),
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png'),
                          fit: BoxFit.fill)),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(title: 'Mohamed aly'),
                    SubTitleWidget(subTitle: 'example@gmail.com')
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextWidget(title: 'Generals'),
                CustomProfileList(
                    title: 'All Orders',
                    imagePath: AssetsManager.order2,
                    fun: ()async {
                      await Navigator.pushNamed(context, OrderScreen.id);
                    }),
                CustomProfileList(
                    title: 'WishList',
                    imagePath: AssetsManager.wishList,
                    fun: ()async {
                     await Navigator.pushNamed(context, WishListScreen.id);
                    }),
                CustomProfileList(
                    title: 'Viewed recently',
                    imagePath: AssetsManager.recent,
                    fun: ()async {
                     await Navigator.pushNamed(context,ViewedRecentlyScreen.id);
                    }),
                CustomProfileList(
                    title: 'Address',
                    imagePath: AssetsManager.address,
                    fun: () {}),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextWidget(title: 'Settings'),
                const SizedBox(
                  height: 23,
                ),
                SwitchListTile(
                    title: CustomTextWidget(
                        title: themeProvider.getDarkTheme ? 'dark' : 'light'),
                    secondary: Image.asset(
                      AssetsManager.theme,
                      height: 30,
                    ),
                    value: themeProvider.getDarkTheme,
                    onChanged: (value) {
                      themeProvider.setDarkTheme(themeValue: value);
                    }),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: ()async {
                 await Navigator.pushNamed(context, LoginScreen.id);
                 // await DialogsServices.appDialog(context: context, title: 'Are you sure?', fct: (){
                 //
                 // });
                },
                icon: const Icon(Icons.login),
                label: const CustomTextWidget(title: 'Log in')),
          )
        ],
      ),
    );
  }
}
