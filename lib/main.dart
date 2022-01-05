import 'package:flutter/material.dart';
import 'package:shopapp/provider/cart.dart';
import 'package:shopapp/screen/cartStore.dart';
import 'package:shopapp/screen/orders_screen.dart';
import './screen/products_overview_screen.dart';
import './screen/product_detail_screen.dart';
import './provider/products.dart';
import 'package:provider/provider.dart';
import './provider/auth.dart';
import './provider/cart.dart';
import './provider/orders.dart';
import './screen/user_product_screen.dart';
import './screen/edit_product_screen.dart';
import './screen/auth_screen.dart';
import './screen/splash_screen.dart';

// in place of stateful widget we can run futurebuilder
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          //below provider will rebuild whenever auth will change because its dependency on Auth();
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (_) => Products(null, null, []),
            update: (_, auth, previousProducts) => Products(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.item),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (ctx) => Orders(null, null, []),
            update: (ctx, auth, previousOrders) => Orders(
                auth.token,
                auth.userId,
                previousOrders == null ? [] : previousOrders.orders),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
              title: 'MyShop',
              theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                // fontFamily: 'Lato',
              ),
              // home: ProductsOverviewScreen(),
              // home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
              home: auth.isAuth
                  ? ProductsOverviewScreen()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authResultSnapshot) =>
                          authResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? SplashScreen()
                              : AuthScreen(),
                    ),
              routes: {
                ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                CartStore.routeName: (ctx) => CartStore(),
                OrdersScreen.routeName: (ctx) => OrdersScreen(),
                UserProductScreen.routeName: (ctx) => UserProductScreen(),
                EditProductScreen.routeName: (ctx) => EditProductScreen(),
              }),
        ));
  }
}
