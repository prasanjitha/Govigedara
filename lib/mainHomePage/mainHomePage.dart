import 'package:e_shop/Admin/adminShiftOrders.dart';
import 'package:e_shop/Orders/myOrders.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:e_shop/mainHomePage/MainPages/CartPageTabBar/tabBarCart.dart';
import 'package:e_shop/mainHomePage/MainPages/TopProducts.dart';
import 'package:flutter/material.dart';
import 'MainPages/AlertDialogBox/ChooseOption.dart';
import 'MainPages/buyerHome.dart';
import 'MainPages/sellerUploadItems.dart';

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
    _scrollController = ScrollController();
  }

  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(
                "Govigedara",
                style: TextStyle(
                    fontSize: 55.0,
                    color: Colors.white,
                    fontFamily: "Signatra"),
              ),
              centerTitle: true,
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,

              flexibleSpace: Container(
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [Colors.green[900], Colors.lightGreenAccent[700]],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                ),
              ),
              //expandedHeight: 200.0,
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: 'Home', icon: Icon(Icons.home)),
                  Tab(text: 'Seller', icon: Icon(Icons.person)),
                  Tab(text: 'deliver', icon: Icon(Icons.directions_car)),
                  Tab(text: '‍My Orders', icon: Icon(Icons.store)),
                  Tab(text: 'My Cart', icon: Icon(Icons.shopping_cart)),
                  Tab(text: 'Add Orders', icon: Icon(Icons.bookmark_border)),
                  Tab(text: 'Newly Products', icon: Icon(Icons.star_border)),
                  Tab(text: 'My Account', icon: Icon(Icons.account_circle)),
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [Colors.white, Colors.lightGreen[100]],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: TabBarView(
            children: [
              buyerHome(),
              UploadPage(),
              AdminShiftOrders(),
              MyOrders(),
              CartPage(),
              chooseOption(),
              StoreHome(),
              MyDrawer()
            ],
            controller: _tabController,
          ),
        ),
      ),
    );
  }
}
