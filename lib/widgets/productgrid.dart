import 'package:flutter/material.dart';
import '../provider/product.dart';
// import './widgets/product_item.dart;
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';

class ProductGrid extends StatelessWidget {
  final bool favoriteOrNot;
  ProductGrid(this.favoriteOrNot);
  @override
  Widget build(BuildContext context) {
    final productsdata = Provider.of<Products>(context);
    final products = favoriteOrNot ? productsdata.favorites : productsdata.item;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // create: (c) => products[i],
        value: products[i],
        child: ProductItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
