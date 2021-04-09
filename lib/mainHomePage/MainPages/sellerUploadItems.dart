import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class UploadPage extends StatefulWidget
{
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with AutomaticKeepAliveClientMixin<UploadPage>
{

  bool get wantKeepAlive => true;
  File file;
  TextEditingController _descriptionTextEdditingController =
  TextEditingController();
  TextEditingController _priceTextEdditingController = TextEditingController();
  TextEditingController _titleTextEdditingController = TextEditingController();
  TextEditingController _shortInfoTextEdditingController = TextEditingController();
  String productId = DateTime.now().microsecondsSinceEpoch.toString();
  bool uploading =false;
  //new
  TextEditingController  _quentityTextEdditingController=TextEditingController();
  TextEditingController  _nearestTownTextEdditingController=TextEditingController();
  TextEditingController _addressTownTextEdditingController=TextEditingController();
  TextEditingController _contactNoTextEdditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return file ==null ? displayAdminHomeScreen():displayAdminUploadFormScreen();
  }
  displayAdminHomeScreen(){
    return Scaffold(
      body: getAdminHomeScreenBody(),

    );
  }
  getAdminHomeScreenBody(){
    return Container(
   color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shop_two,color: Colors.green,size: 200.0,),
            Padding(padding: EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),
                child: Text("Add New Items",style: TextStyle(fontSize: 20.0,color: Colors.white),),
                color: Colors.green[200],
                onPressed: ()=>takeImage(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  takeImage(mContext){
    return showDialog(context: context, builder:(con){
      return SimpleDialog(
        title: Text("Item Image",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
        children: [
          SimpleDialogOption(
            child: Text(
              "Capture with camera",
              style: TextStyle(color: Colors.green),
            ),
            onPressed: capturePhotoWithCamera,
          ),
          SimpleDialogOption(
            child: Text(
              "Select from Gallery",
              style: TextStyle(color: Colors.green),
            ),
            onPressed: pickPhotoFromGallery,
          ),
          SimpleDialogOption(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.green),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    });

  }
  capturePhotoWithCamera() async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0);
    setState(() {
      file = imageFile;
    });
  }

  pickPhotoFromGallery() async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      file = imageFile;
    });
  }
  displayAdminUploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          "New Product",
          style: TextStyle(
              color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              border:Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(50)
            ),
            child: FlatButton(
              child: Text(
                "Add",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: uploading ? null : () => uploadImageAndSaveItemInfo(),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          uploading ? circularProgress() : Text(""),
          Container(
            height: 230.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(file), fit: BoxFit.cover)),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 12.0)),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.green[900],
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _shortInfoTextEdditingController,
                decoration: InputDecoration(
                  //change short info--->Item Name
                  hintText: "Item Name",
                  hintStyle: TextStyle(color: Colors.green),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.green[700],
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.green[900],
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _titleTextEdditingController,
                decoration: InputDecoration(
                  hintText: "Category",
                  hintStyle: TextStyle(color: Colors.green),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.green[700],
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.green[900],
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _descriptionTextEdditingController,
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.green),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.green[700],
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.green[900],
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _quentityTextEdditingController,
                decoration: InputDecoration(
                  hintText: "Quentity(Kg)",
                  hintStyle: TextStyle(color: Colors.green),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.green[700],
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.green[900],
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _priceTextEdditingController,
                decoration: InputDecoration(
                  hintText: "price(1 Kg)",
                  hintStyle: TextStyle(color: Colors.green),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.green[700],
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.green[900],
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _nearestTownTextEdditingController,
                decoration: InputDecoration(
                  hintText: "Nearest Town",
                  hintStyle: TextStyle(color: Colors.green),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.green[700],
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.green[900],
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _addressTownTextEdditingController,
                decoration: InputDecoration(
                  hintText: "Address",
                  hintStyle: TextStyle(color: Colors.green),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.green[700],
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.green[900],
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _contactNoTextEdditingController,
                decoration: InputDecoration(
                  hintText: "ContactNo",
                  hintStyle: TextStyle(color: Colors.green),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.green[700],
          ),
        ],
      ),
    );
  }
  ClearFormInfo() {
    setState(() {
      file = null;
      _descriptionTextEdditingController.clear();
      _priceTextEdditingController.clear();
      _titleTextEdditingController.clear();
      _shortInfoTextEdditingController.clear();
      _nearestTownTextEdditingController.clear();
      _quentityTextEdditingController.clear();
      _addressTownTextEdditingController.clear();
      _contactNoTextEdditingController.clear();

    });
  }
  uploadImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });
    String imageDownloadUrl = await uploadItemImage(file);
    saveItemInfo(imageDownloadUrl);
  }

  Future<String> uploadItemImage(mFileImage) async {
    final StorageReference storageReference =
    FirebaseStorage.instance.ref().child("Items");
    StorageUploadTask uploadTask =
    storageReference.child("product_$productId.jpg").putFile(mFileImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  saveItemInfo(String downloadUrl) {
    final itemsRef = Firestore.instance.collection("items");
    itemsRef.document(productId).setData({
      "shortInfo": _shortInfoTextEdditingController.text.trim(),
      "longDescription": _descriptionTextEdditingController.text.trim(),
      "price": int.parse(_priceTextEdditingController.text),
      "publishedDate": DateTime.now(),

      "status": "available",
      "thumbnailUrl": downloadUrl,
      "title": _titleTextEdditingController.text.trim(),
      "nearestTown":_nearestTownTextEdditingController.text.trim(),
      "quentity":_quentityTextEdditingController.text.trim(),
      "address":_addressTownTextEdditingController.text.trim(),
      "contactNo":_contactNoTextEdditingController.text.trim(),

    });
    setState(() {
      file = null;
      uploading = false;
      productId = DateTime.now().microsecondsSinceEpoch.toString();
      _descriptionTextEdditingController.clear();
      _titleTextEdditingController.clear();
      _shortInfoTextEdditingController.clear();
      _priceTextEdditingController.clear();
      _quentityTextEdditingController.clear();
      _nearestTownTextEdditingController.clear();
      _addressTownTextEdditingController.clear();
      _contactNoTextEdditingController.clear();

    });
  }

}
