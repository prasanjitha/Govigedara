
import 'package:e_shop/mainHomePage/MainPages/BitOrders/addOrders.dart';
import 'package:e_shop/mainHomePage/MainPages/BitOrders/viewOrders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../mainHomePage.dart';

class chooseOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [Colors.green, Colors.amberAccent],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(

            child: Dialog(

              backgroundColor: Colors.blue[100],
              child: Container(
                width: 100,
                height: 300,
                color: Colors.white,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          "Choose option",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),

                        Divider(
                          height: 20.0,

                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>AddAddress()));
                          },
                          child: Text("Add Orders",style: TextStyle(
                              fontSize: 20.0
                          )),
                        ),
                        Divider(
                          height: 20.0,
                             color: Colors.pinkAccent,
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>Address()));
                          },
                          child: Text("View Orders",style: TextStyle(
                              fontSize: 20.0
                          )),
                        ),
                        Divider(
                          height: 10.0,
                          color: Colors.pink,
                        ),

                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>MainHomePage()));
                          },
                          child: Text("Cancel",style: TextStyle(
                              fontSize: 20.0
                          )),
                        ),
                        Divider(
                          height: 1.0,
                          color: Colors.pink,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            )
        ),
      ),

    );
  }
}
