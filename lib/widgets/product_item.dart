import 'package:flutter/material.dart';
import 'package:shopapp/provider/product.dart';
import '../screen/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
import '../provider/auth.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () {
                product.toggleProductStatus(authData.token, authData.userId);
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              cart.addItem(product.id as String, product.price, product.title);
              //isse first wala ko khatam hone se pehle agar dusra dilog aa jaega..
              Scaffold.of(context).hideCurrentSnackBar();
              //snackbar ka use karke after adding item to a cart then
              //niche me confirmation type ka message aa jata hai...
              //here we need scaffold because it is attached with pages..
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Added item to cart!",
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "undo",
                    onPressed: () {
                      cart.removeSingleItem(product.id as String);
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
