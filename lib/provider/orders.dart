import 'package:flutter/material.dart';
import 'cart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  final String? authToken;
  final String? userId;
  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        "https://shopapp-36cb1-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken");
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData.isEmpty) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    print(cartProducts);
    print(total);
    final url = Uri.parse(
        "https://shopapp-36cb1-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken");
    final timestamp = DateTime.now();
    print("hello world");
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );
    print("heyyyy");
    print(json.decode(response.body));
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timestamp,
        products: cartProducts,
      ),
    );
    print("donee");
    notifyListeners();
    print("donny");
  }
}




  // Future<void> addOrder(List<CartItem> cartProducts, double total) async {
  //   //here userid in url is subfolder i mean folder inside folder..
  //   final url = Uri.parse(
  //       "https://shopapp-36cb1-default-rtdb.firebaseio.com/orders/$userId.json?auth=authToken");
  //   final timestamp = DateTime.now();
  //   print("hello worlddd");

  //   final response = await http.post(
  //     url,
  //     body: json.encode({
  //       "amount": total,
  //       "dateTime": timestamp.toIso8601String(),
  //       "products": cartProducts
  //           .map((cp) => {
  //                 "id": cp.id,
  //                 "title": cp.title,
  //                 "quantity": cp.quantity,
  //                 "price": cp.price,
  //               })
  //           .toList(),
  //     }),
  //   );
  //   print("letssss seee");
  //   _orders.insert(
  //     0,
  //     OrderItem(
  //       id: json.decode(response.body)["name"],
  //       amount: total,
  //       dateTime: DateTime.now(),
  //       products: cartProducts,
  //     ),
  //   );
  //   notifyListeners();
  // }

