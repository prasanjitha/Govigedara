
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class questionAndAnswer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Question & Answer"),
        ),
        body:ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0,left: 10.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Is there any delivery charges ?",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 5.0,),
                    Text("There is no any delivery charges within 3 Km."),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Colors.grey,
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: displayQuestion(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.greenAccent,
                  height: 100,
                child:addQuestion(),
              ),
            )

          ],

        ),
      ),
    );
  }
}

class addQuestion extends StatelessWidget {
  TextEditingController _addQuestion=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextFormField(
              controller: _addQuestion,
              decoration: InputDecoration(
                hintText: "Enter Question"
              ),

            ),
            FlatButton(
                onPressed: (){
                  Map<String ,dynamic> data={"Question&Answer":_addQuestion.text};
                  Firestore.instance.collection("Question").add(data);
                },
              child: Text("submit"),
              color: Colors.green,
               )
          ],
        ),

      ),
    );
  }
}

class displayQuestion extends StatefulWidget {
  @override
  _displayQuestionState createState() => _displayQuestionState();
}

class _displayQuestionState extends State<displayQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection('Question').snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapShot){
          if(!snapShot.hasData){
            return Text("no value");
          }
          return ListView(
            children:snapShot.data.documents.map((document){
              return Text(document['Question&Answer'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),);
            }).toList(),
          );
        },
      ),
    );
  }
}


