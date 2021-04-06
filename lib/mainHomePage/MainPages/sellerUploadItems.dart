import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminShiftOrders.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImD;


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
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:[Colors.pink,Colors.lightGreenAccent],
            begin: const FractionalOffset(0.0,0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp,

          )
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shop_two,color: Colors.white,size: 200.0,),
            Padding(padding: EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),
                child: Text("Add New Items",style: TextStyle(fontSize: 20.0,color: Colors.white),),
                color: Colors.grey,
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
              colors: [Colors.pink, Colors.lightGreenAccent],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: ClearFormInfo),
        title: Text(
          "New Product",
          style: TextStyle(
              color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          FlatButton(
            child: Text(
              "Add",
              style: TextStyle(
                  color: Colors.pink,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: uploading ? null : () => uploadImageAndSaveItemInfo(),
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
              color: Colors.pink,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _shortInfoTextEdditingController,
                decoration: InputDecoration(
                  hintText: "Short Info",
                  hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.pink,
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.pink,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _titleTextEdditingController,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.pink,
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.pink,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _descriptionTextEdditingController,
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.pink,
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.pink,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: _priceTextEdditingController,
                decoration: InputDecoration(
                  hintText: "price",
                  hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.pink,
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
    });
    setState(() {
      file = null;
      uploading = false;
      productId = DateTime.now().microsecondsSinceEpoch.toString();
      _descriptionTextEdditingController.clear();
      _titleTextEdditingController.clear();
      _shortInfoTextEdditingController.clear();
      _priceTextEdditingController.clear();

    });
  }

}
