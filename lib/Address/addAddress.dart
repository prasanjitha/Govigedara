import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Models/address.dart';
import 'package:flutter/material.dart';

import 'address.dart';

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
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: (){
                    Route route =MaterialPageRoute(builder: (c)=>Address());
                    Navigator.pushReplacement(context, route);
                  },

            ),
            ),

            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                if(formKey.currentState.validate())
                  {
                    final model = AddressModel(
                      name: cName.text.trim(),
                      state: cState.text.trim(),
                      pincode: cPinCode.text,
                      phoneNumber: cPhoneNumber.text,
                      flatNumber: cFlatHomeNumber.text,
                      city: cCity.text.trim(),
                    ).toJson();

                    EcommerceApp.firestore.collection(EcommerceApp.collectionUser)
                        .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                        .collection(EcommerceApp.subCollectionAddress)
                        .document(DateTime.now().millisecondsSinceEpoch.toString())
                        .setData(model)
                        .then((value){
                      final snack = SnackBar(content: Text("New Orders added successfully."));
                      scaffoldKey.currentState.showSnackBar(snack);
                      FocusScope.of(context).requestFocus(FocusNode());
                      formKey.currentState.reset();
                    });
                    Route route =MaterialPageRoute(builder: (c)=>AddAddress());
                    Navigator.pushReplacement(context, route);

                  }
              },
              label: Text("Done"),
              backgroundColor: Colors.green,
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
                      "Add New Address",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        MyTextField(
                          hint: "Name",
                          controller: cName,
                        ),
                        Divider(height: 1.0,),
                        MyTextField(
                          hint: "Mobile",
                          controller: cPhoneNumber,
                        ),
                        Divider(height: 1.0,),
                        MyTextField(
                          hint: "Street Address",
                          controller: cFlatHomeNumber,
                        ),
                        Divider(height: 1.0,),
                        MyTextField(
                          hint: "City",
                          controller: cCity,
                        ),
                        Divider(height: 1.0,),
                        MyTextField(
                          hint: "State/Province/Region ",
                          controller: cState,
                        ),
                        Divider(height: 1.0,),
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
