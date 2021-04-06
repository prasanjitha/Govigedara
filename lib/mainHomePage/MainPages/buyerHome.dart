import 'package:carousel_pro/carousel_pro.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'popularVegiAndFruits.dart';

class buyerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [Colors.green, Colors.lightGreenAccent],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: ListView(
            children: [
              imageSlider,
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Category",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.green,
                  child: Category(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Popular Vegi & Fruits",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.green,
                  child: popularVegiAndFruits(),
                ),
              ),
            ],
          ),
        ));
  }

 Widget imageSlider = Container(
      color: Colors.green,
      width: 140,
      height: 220,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Carousel(
          images: [
            AssetImage("assets/images/homeSlider/s1.jpg"),
            AssetImage("assets/images/homeSlider/p5.jpg"),
            AssetImage("assets/images/homeSlider/s2.jpg"),
            AssetImage("assets/images/homeSlider/s5.jpg"),
            AssetImage("assets/images/homeSlider/s3.jpg"),
            AssetImage("assets/images/homeSlider/s4.jpg"),
            AssetImage("assets/images/homeSlider/s7.jpg"),
            AssetImage("assets/images/homeSlider/s8.jpg"),
            AssetImage("assets/images/homeSlider/s6.jpg"),
          ],
          autoplay: true,
          boxFit: BoxFit.fill,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(seconds: 2),
          dotColor: Colors.black,
          dotSize: 5,

        ),
      ));

}

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        GestureDetector(
          onTap: () {
            Route route = MaterialPageRoute(builder: (c) => StoreHome());
            Navigator.pushReplacement(context, route);
          },
          child: Container(
            height: 200,
            width: 200,
            child: Center(
                child: Container(
                    height: 40,
                    width: 120,
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                        child: Text(
                          "Vegetables",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )))),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage("assets/images/Catagory/fruits.jpg"),
                  fit: BoxFit.cover,
                )),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        GestureDetector(
          onTap: () {
            Route route = MaterialPageRoute(builder: (c) => StoreHome());
            Navigator.pushReplacement(context, route);
          },
          child: Container(
            height: 200,
            width: 200,
            child: Center(
                child: Container(
                    height: 40,
                    width: 120,
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                        child: Text(
                          "Fruits",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )))),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage("assets/images/Catagory/vegitable.jpg"),
                  fit: BoxFit.cover,
                )),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        GestureDetector(
          onTap: () {
            Route route = MaterialPageRoute(builder: (c) => StoreHome());
            Navigator.pushReplacement(context, route);
          },
          child: Container(
            height: 200,
            width: 200,
            child: Center(
                child: Container(
                    height: 40,
                    width: 160,
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                        child: Text(
                          "Sesonal Fruits",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )))),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage("assets/images/Catagory/sesonalFruits.jpg"),
                  fit: BoxFit.cover,
                )),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        GestureDetector(
          onTap: () {
            Route route = MaterialPageRoute(builder: (c) => StoreHome());
            Navigator.pushReplacement(context, route);
          },
          child: Container(
            height: 200,
            width: 200,
            child: Center(
                child: Container(
                    height: 40,
                    width: 160,
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                        child: Text(
                          "Sesonal Vegi",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )))),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage("assets/images/Catagory/sesonalVegi.jpg"),
                  fit: BoxFit.cover,
                )),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        GestureDetector(
          onTap: () {
            Route route = MaterialPageRoute(builder: (c) => StoreHome());
            Navigator.pushReplacement(context, route);
          },
          child: Container(
            height: 200,
            width: 200,
            child: Center(
                child: Container(
                    height: 40,
                    width: 100,
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                        child: Text(
                      "Seeds",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )))),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage("assets/images/Catagory/seeds.jpg"),
                  fit: BoxFit.cover,
                )),
          ),
        ),
        SizedBox(
          width: 2.0,
        ),
      ],
    );
  }
}
