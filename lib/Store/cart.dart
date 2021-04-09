import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Address/address.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/Counters/totalMoney.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:e_shop/mainHomePage/MainPages/TopProducts.dart';
import 'package:e_shop/mainHomePage/mainHomePage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  final PreferredSizeWidget bottom;
  CartPage({this.bottom});
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalAmount;
  @override
  void initState() {
    super.initState();
    totalAmount=0;
    Provider.of<TotalAmount>(context,listen: false).display(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        if(EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length==1)
          {
            Fluttertoast.showToast(msg: "your cart is empty");
          }else{
          Route route=MaterialPageRoute(builder: (c)=>Address(totalAmount: totalAmount,));
          Navigator.pushReplacement(context, route);
        }
      },
        label: Text("Check Out"),
        backgroundColor: Colors.green,
        icon: Icon(Icons.navigate_next),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
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
        centerTitle: true,
        title: Text(
          "govigedara",
          style: TextStyle(
              fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.pink,
                  ),
                  onPressed: () {
                    Route route = MaterialPageRoute(builder: (c) => CartPage());
                    Navigator.pushReplacement(context, route);
                  }),
              Positioned(
                child: Stack(
                  children: [
                    Icon(
                      Icons.brightness_1,
                      size: 20.0,
                      color: Colors.green,
                    ),
                    Positioned(
                        top: 3.0,
                        bottom: 4.0,
                        left: 4.0,
                        child: Consumer<CartItemCounter>(
                          builder: (context, counter, _) {
                            return Text(
                              (EcommerceApp.sharedPreferences
                                  .getStringList(
                                  EcommerceApp.userCartList)
                                  .length -
                                  1)
                                  .toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500),
                            );
                          },
                        )),
                  ],
                ),
              )
            ],
          )
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: (){
            Route route =MaterialPageRoute(builder: (c)=>MainHomePage());
            Navigator.pushReplacement(context, route);
          },

        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Consumer2<TotalAmount,CartItemCounter>(builder: (context,amountProvider,cartProvider,c){
              return Padding(padding: EdgeInsets.all(8.0),
              child: Center(
                child: cartProvider.count==0
                    ?Text(
                  "Total Price: Rs ${amountProvider.totalAmount.toString()}"
                  ,style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.w500),
                )
                    :Container()
              ),
              );
            },),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: EcommerceApp.firestore.collection("items")
                .where("shortInfo",whereIn: EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList)).snapshots(),
            builder: (context,snapshot)
            {
              return !snapshot.hasData
                  ?SliverToBoxAdapter(child: Center(child: circularProgress(),),)
                  :snapshot.data.documents.length==0
                  ?beginBuildingCart()
                  :SliverList(
                  delegate:SliverChildBuilderDelegate(
                      (context, index){
                        ItemModel model=ItemModel.fromJson(snapshot.data.documents[index].data);
                        if(index==0)
                          {
                            totalAmount=0;
                            totalAmount=model.price+totalAmount;
                          }
                        else{
                          totalAmount=model.price+ totalAmount;
                        }
                        if(snapshot.data.documents.length-1==index)
                          {
                            WidgetsBinding.instance.addPostFrameCallback((t){
                              Provider.of<TotalAmount>(context,listen: false).display(totalAmount);
                            });
                          }
                        return sourceInfo(model, context,removeCartFunction: ()=>removeItemFromUserCart(model.shortInfo));
                      },
                    childCount: snapshot.hasData ? snapshot.data.documents.length:0,
                  ));
            },
          )
        ],
      ),

    );
  }
  beginBuildingCart(){
    return SliverToBoxAdapter(
      child: Card(
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        child: Container(
          height: 100.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.insert_emoticon,color: Colors.white,),
              Text("cart is empty"),
              Text("Start adding items to your Cart"),
            ],

          ),
        ),
      ),
    );
  }
  removeItemFromUserCart(String shortInfoAsId){
    List tempCartList=EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
    tempCartList.remove(shortInfoAsId);
    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .updateData({
      EcommerceApp.userCartList: tempCartList,
    }).then((v) {
      Fluttertoast.showToast(msg: "Item removed cart successfully");
      EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, tempCartList);
      Provider.of<CartItemCounter>(context, listen: false).displayResult();
      totalAmount=0;
    });

  }
}
