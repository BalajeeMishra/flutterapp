// import 'dart:ffi';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';
import '../widgets/user_productitem.dart';
import '../widgets/maindrawer.dart';
import './edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = "/user-products";
  Future<void> _refreshProducts(BuildContext context) async {
    // i have passed true so that it will filter by user
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    // here i have used consumer because of ki infinite loop na chale okayy.
                    //otherwise kya hoga ki refreshproducts chal jaega then again build hoga aur fir
                    //se fuurebuilder chalega thats not good at all.
                    child: Consumer<Products>(
                      builder: (ctx, productsData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: productsData.item.length,
                          itemBuilder: (_, i) => Column(
                            children: [
                              UserProductItem(
                                productsData.item[i].id as String,
                                productsData.item[i].title,
                                productsData.item[i].imageUrl,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
