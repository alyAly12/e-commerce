import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:watches_app/consts/app_theme.dart';
import 'package:watches_app/controllers/provider/cart_provider.dart';
import 'package:watches_app/controllers/provider/product_provider.dart';
import 'package:watches_app/controllers/provider/theme_provider.dart';
import 'package:watches_app/controllers/provider/viewed_provider.dart';
import 'package:watches_app/controllers/provider/wishlist_provider.dart';
import 'package:watches_app/presentation/auth/login/forget_password_screen.dart';
import 'package:watches_app/presentation/auth/login/login_screen.dart';
import 'package:watches_app/presentation/auth/login/sign_up_screen.dart';
import 'package:watches_app/presentation/inner_screens/orders/order_screen.dart';
import 'package:watches_app/presentation/inner_screens/product_detail_screen.dart';
import 'package:watches_app/presentation/inner_screens/viewed_recently_screen.dart';
import 'package:watches_app/presentation/inner_screens/wishlist_screen.dart';
import 'package:watches_app/presentation/screens/search/search_screen.dart';
import 'package:watches_app/root_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishListProvider()),
        ChangeNotifierProvider(create: (_) => ViewedProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, themeProvider, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Watches App',
            theme: AppTheme.themeData(
                isDarkTheme: themeProvider.getDarkTheme, context: context),
            home: const RootScreen(),
            routes: {
              ProductDetailScreen.id: (context) => const ProductDetailScreen(),
              WishListScreen.id: (context) => const WishListScreen(),
              ViewedRecentlyScreen.id:(context)=> const ViewedRecentlyScreen(),
              LoginScreen.id: (context) => const LoginScreen(),
              SignUpScreen.id:(context)=> const SignUpScreen(),
              OrderScreen.id: (context) => const OrderScreen(),
              ForgetPassWordScreen.id: (context) => const ForgetPassWordScreen(),
              SearchScreen.id: (context) => const SearchScreen(),
            },
          );
        },
      ),
    );
  }
}
