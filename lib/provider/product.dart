import 'package:flutter/material.dart';
import 'cart.dart';
import 'products.dart';

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});
  void toggleProductStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  // void shoppingCart(proid) {
  //   final product =
  //       Products().item.firstWhere((element) => element.id == proid);
  //   CartItem(
  //       id: DateTime.now() as String,
  //       title: product.title,
  //       quantity: 1,
  //       price: product.price);
  // }
}
