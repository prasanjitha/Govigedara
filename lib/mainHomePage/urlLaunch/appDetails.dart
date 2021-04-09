import 'package:flutter/material.dart';


class appInfromation extends StatefulWidget {
  @override
  _appInfromationState createState() => _appInfromationState();
}

class _appInfromationState extends State<appInfromation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/images/list/m2.jpg",fit: BoxFit.cover,),
          ),
          SizedBox(height: 5.0,),
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/images/list/m1.jpg",fit: BoxFit.cover,),
          ),
          SizedBox(height: 5.0,),
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/images/list/m3.jpg",fit: BoxFit.cover,),
          ), SizedBox(height: 5.0,),
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/images/list/m4.jpg",fit: BoxFit.cover,),
          ),
          SizedBox(height: 5.0,),
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/images/list/m5.jpg",fit: BoxFit.cover,),
          ) , SizedBox(height: 5.0,),
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/images/list/m6.png",fit: BoxFit.cover,),
          )


        ],
      )


    );


  }


}
