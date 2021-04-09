import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Models/addOrder.dart';
import 'package:e_shop/mainHomePage/mainHomePage.dart';
import 'package:flutter/material.dart';
// testing purpose
class AddAddress extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final cName = TextEditingController();
  final cPhoneNumber = TextEditingController();
  final cFlatHomeNumber = TextEditingController();
  final cCity = TextEditingController();
  final cState = TextEditingController();
  final cPinCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        key: scaffoldKey,
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
        "Add Orders",
        style: TextStyle(
            fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
      ),
    ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                if(formKey.currentState.validate())
                {
                  final model = AddressModels(
                    name: cName.text.trim(),
                    state: cState.text.trim(),
                    pincode: cPinCode.text,
                    phoneNumber: cPhoneNumber.text,
                    flatNumber: cFlatHomeNumber.text,
                    city: cCity.text.trim(),
                  ).toJson();

                  EcommerceApp.firestore.collection(EcommerceApp.collectionUser)
                      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                      .collection(EcommerceApp.subCollectionAddresss)
                      .document(DateTime.now().millisecondsSinceEpoch.toString())
                      .setData(model)
                      .then((value){
                    final snack = SnackBar(content: Text("New order added successfully."));
                    scaffoldKey.currentState.showSnackBar(snack);
                    FocusScope.of(context).requestFocus(FocusNode());
                    formKey.currentState.reset();
                  });
                  Route route =MaterialPageRoute(builder: (c)=>MainHomePage());
                  Navigator.pushReplacement(context, route);

                }
              },
              label: Text("Done"),
              backgroundColor: Colors.pink,
              icon: Icon(Icons.check),
            ),
            body: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Add New Order",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            MyTextField(
                              hint: "Name",
                              controller: cName,
                            ),
                            MyTextField(
                              hint: "Phone Number",
                              controller: cPhoneNumber,
                            ),
                            MyTextField(
                              hint: "Address",
                              controller: cFlatHomeNumber,
                            ),
                            MyTextField(
                              hint: "City",
                              controller: cCity,
                            ),
                            MyTextField(
                              hint: "Order List(..Kg)",
                              controller: cState,
                            ),
                            MyTextField(
                              hint: "Want Date",
                              controller: cPinCode,
                            ),
                          ],
                        )),
                  ],
                ))));
  }
}

class MyTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  MyTextField({Key key, this.hint, this.controller,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration.collapsed(hintText: hint),
        validator: (val) => val.isEmpty ? "Field can not be empty." : null,
      ),
    );
  }
}
