import 'package:flutter/material.dart';
import 'package:shopapp/provider/cart.dart';
import 'package:shopapp/screen/cartStore.dart';
import 'package:shopapp/screen/orders_screen.dart';
import './screen/products_overview_screen.dart';
import './screen/product_detail_screen.dart';
import './provider/products.dart';
import 'package:provider/provider.dart';
import './provider/cart.dart';
import './provider/orders.dart';
import './screen/user_product_screen.dart';
import './screen/edit_product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          // create: (ctx) => Products(),
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            // fontFamily: 'Lato',
          ),
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartStore.routeName: (ctx) => CartStore(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductScreen.routeName: (ctx) => UserProductScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          }),
    );
  }
}
