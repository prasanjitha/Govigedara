import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart.dart';

class ProductPage extends StatefulWidget {
  final ItemModel itemModel;
  ProductPage({this.itemModel});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantityOfItems = 0;
  int total = 0;
  int feeeCharges=120;
  void _increment() {
    setState(() {
      quantityOfItems++;
      total = quantityOfItems * widget.itemModel.price.toInt()+feeeCharges;
    });
  }

  void _decrement() {
    setState(() {
      quantityOfItems--;
      total = quantityOfItems * widget.itemModel.price.toInt()+feeeCharges;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
             Route route =MaterialPageRoute(builder: (c)=>StoreHome());
             Navigator.pushReplacement(context, route);
           },

         ),
       ),

        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Image.network(widget.itemModel.thumbnailUrl),
                      ),
                      Container(
                        color: Colors.grey[300],
                        child: SizedBox(
                          height: 1.0,
                          width: double.infinity,
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.itemModel.shortInfo,
                                style: boldTextStyle,
                              ),
                              Spacer(),
                              Text(widget.itemModel.status,style: TextStyle(color: Colors.green),)
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Text(
                                widget.itemModel.longDescription,
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Text("Price(1 Kg)",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                  SizedBox(width: 30,),
                                  Text("Rs "+widget.itemModel.price.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on,size: 18,),
                                SizedBox(width: 5.0,),
                                Text(widget.itemModel.address,style: TextStyle(fontSize: 16),),

                                ],
                              ),
                              SizedBox(height: 10.0,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.phone,size: 18,),
                                  SizedBox(height: 5.0,),
                                  Text(widget.itemModel.contactNo,style: TextStyle(fontSize: 16),),

                                ],
                              ),
                            ],
                          ),
                         SizedBox(height: 15.0,),

                          Row(
                            children: [
                              GestureDetector(
                                  onTap: _decrement,
                                  child: Icon(Icons.horizontal_rule)),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                  '$quantityOfItems',
                                ),
                              ),
                              GestureDetector(
                                  onTap: _increment, child: Icon(Icons.add)),
                              Spacer(),
                              Text(
                                'Rs $total',
                                style: boldTextStyle,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Center(
                      child: InkWell(
                        onTap: () => checkItemInCart(
                            widget.itemModel.shortInfo, context),
                        child: Container(
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                              colors: [
                                Colors.green[900],
                                Colors.lightGreenAccent[700]
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp,
                            ),
                          ),
                          width: MediaQuery.of(context).size.width - 40.0,
                          height: 50.0,
                          child: Center(
                            child: Text(
                              "Add to Cart ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
