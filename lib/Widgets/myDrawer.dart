import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/addAddress.dart';
import 'package:e_shop/Store/Search.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Orders/myOrders.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/mainHomePage/mainHomePage.dart';
import 'package:e_shop/q&a/questionAndAnswer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 5.0, bottom: 2.0),
           color: Colors.white,
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  elevation: 8.0,
                  child: Container(
                    height: 160.0,
                    width: 160.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        EcommerceApp.sharedPreferences
                            .getString(EcommerceApp.userAvatarUrl),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.0,
                ),
                Text(
                  EcommerceApp.sharedPreferences
                      .getString(EcommerceApp.userName),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35.0,
                      fontFamily: "Signatra"),
                )
              ],
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Container(
            padding: EdgeInsets.only(top: 1.0),
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.green,
                  ),
                  title: Text(
                    "Home",
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text("selling, buying, delivering"),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => MainHomePage());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.reorder,
                    color: Colors.green,
                  ),
                  title: Text(
                    "My Orders",
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text("conform, check"),
                  onTap: () {
                    Route route = MaterialPageRoute(builder: (c) => MyOrders());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Colors.green,
                  ),
                  title: Text(
                    "My Cart",
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text("Add, view, check, remove items"),
                  onTap: () {
                    Route route = MaterialPageRoute(builder: (c) => CartPage());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Colors.green,
                  ),
                  title: Text(
                    "Search",
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text("vegitable, fruits, seeds"),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => SearchProduct());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Colors.green,
                  ),
                  title: Text(
                    "Customer FeedBack",
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text("popular question, help"),
                  onTap: () {
                    Route route =
                    MaterialPageRoute(builder: (c) => questionAndAnswer());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.add_location,
                    color: Colors.green,
                  ),
                  title: Text(
                    "Add New Address",
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text("your location"),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => AddAddress());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.green,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    EcommerceApp.auth.signOut().then((c) {
                      Route route =
                          MaterialPageRoute(builder: (c) => AuthenticScreen());
                      Navigator.pushReplacement(context, route);
                    });
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.white,
                  thickness: 6.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
