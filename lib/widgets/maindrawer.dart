import 'package:flutter/material.dart';
import '../screen/user_product_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              "Hey You!",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text(
              "Shop",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text(
              "Orders",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/orders");
            },
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(
              "Manage Products",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
