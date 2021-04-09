import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Counters/changesAddress.dart';
import 'package:e_shop/Models/addOrder.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Widgets/wideButton.dart';
import 'package:e_shop/mainHomePage/MainPages/BitOrders/addOrders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// testing purpose
class Address extends StatefulWidget {
  final double totalAmount;
  const Address({Key key, this.totalAmount}) : super(key: key);
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
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
            "Available Orders",
            style: TextStyle(
                fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Select Order & Contact Buyer",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0,),
                ),
              ),
            ),
            Consumer<AddressChangers>(builder: (context, address, c){
              return Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  stream: EcommerceApp.firestore
                      .collection(EcommerceApp.collectionUser)
                      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                      .collection(EcommerceApp.subCollectionAddresss).snapshots(),

                  builder: (context, snapshot)
                  {
                    return !snapshot.hasData
                        ? Center(child:circularProgress(),)
                        : snapshot.data.documents.length == 0
                        ? noAddressCard()
                        :ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index)
                      {
                        return AddressCard(//////////////
                          currentIndex: address.counter,
                          value: index,
                          addressId: snapshot.data.documents[index].documentID,
                          totalAmount: widget.totalAmount,
                          model: AddressModels.fromJson(snapshot.data.documents[index].data),
                        );
                      },
                    );
                  },
                ),
              );
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Route route = MaterialPageRoute(builder: (c) => AddAddress());
            Navigator.pushReplacement(context, route);
          },
          label: Text("Add New Orders"),
          backgroundColor: Colors.pink,
          icon: Icon(Icons.add_location),
        ),
      ),
    );
  }

  noAddressCard() {
    return Card(
      color: Colors.pink.withOpacity(0.5),
      child: Container(
        height: 100.0,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_location, color:Colors.white,),
            Text("No Shipment address has been saved."),
            Text("Please add your shipment Address so that we can deliever product."),

          ],
        ),
      ),
    );
  }
}

class AddressCard extends StatefulWidget {
  final AddressModels model;
  final String addressId;
  final double totalAmount;
  final int currentIndex;
  final int value;
  AddressCard(
      {Key key,
        this.model,
        this.currentIndex,
        this.addressId,
        this.totalAmount,
        this.value})
      : super(key: key);

  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: ()
      {
        Provider.of<AddressChangers>(context, listen: false).displayResult(widget.value);
      },
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  groupValue: widget.currentIndex,
                  value: widget.value,
                  activeColor: Colors.pink,
                  onChanged: (val) {
                    Provider.of<AddressChangers>(context, listen: false)
                        .displayResult(val);
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: screenWidth * 0.8,
                      child: Table(
                        children: [
                          TableRow(children: [
                            KeyText(
                              msg: "Name",
                            ),
                            Text(widget.model.name),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: "Phone Number",
                            ),
                            Text(widget.model.phoneNumber),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: "Address",
                            ),
                            Text(widget.model.flatNumber),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: "City",
                            ),
                            Text(widget.model.city),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: "Order List",
                            ),
                            Text(widget.model.state),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: "Exp. Date",
                            ),
                            Text(widget.model.pincode),
                          ]),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),//////////////////////////count--> counter
            widget.value == Provider.of<AddressChangers>(context).counter
                ?WideButton(
              message: "Proceed",
              onPressed: ()
              {
               // Route route = MaterialPageRoute(builder: (c) => PaymentPage(
               //   addressId: widget.addressId,
                //  totalAmount: widget.totalAmount,
                //));//MaterialPageRoute
                //Navigator.push(context, route);
              },
            ):Container()
          ],
        ),
      ),
    );
  }
}

class KeyText extends StatelessWidget {
  final String msg;

  KeyText({Key key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
