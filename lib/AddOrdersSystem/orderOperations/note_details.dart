
import 'package:e_shop/AddOrdersSystem/model/note.dart';
import 'package:flutter/material.dart';

class NoteDetailsPage extends StatelessWidget {
  final Note note;

  const NoteDetailsPage({Key key, @required this.note}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text("Name",style: TextStyle(fontSize: 20),),
                Spacer(),
                Text(note.title, style: Theme.of(context).textTheme.title.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Text("Order",style: TextStyle(fontSize: 20),),
                Spacer(),
                Text(note.description,style: TextStyle(
                    fontSize: 16.0
                ),),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Icon(Icons.location_on),
                Spacer(),
                SafeArea(
                  child: Text(note.location,style: TextStyle(
                      fontSize: 16.0
                  ),),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Icon(Icons.phone),
                Spacer(),
                Text(note.mobileNo,style: TextStyle(
                    fontSize: 16.0
                ),),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Text("Exp. Date",style: TextStyle(fontSize: 20),),
                Spacer(),
                Text(note.expDate,style: TextStyle(
                    fontSize: 16.0
                ),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}