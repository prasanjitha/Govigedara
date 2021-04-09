import 'package:e_shop/AddOrdersSystem/model/note.dart';
import 'package:flutter/material.dart';

import '../firestore_service.dart';
class AddNotePage extends StatefulWidget {
  final Note note;

  const AddNotePage({Key key, this.note}) : super(key: key);
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _locationController;
  TextEditingController _mobileNoController;
  TextEditingController _expDateController;
  FocusNode _descriptionNode;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: isEditMote ? widget.note.title : '');
    _locationController =
        TextEditingController(text: isEditMote ? widget.note.location : '');
   _mobileNoController =
        TextEditingController(text: isEditMote ? widget.note.mobileNo : '');
    _expDateController =
        TextEditingController(text: isEditMote ? widget.note.expDate : '');
    _descriptionController =
        TextEditingController(text: isEditMote ? widget.note.description : '');
    _descriptionNode = FocusNode();
  }

  get isEditMote => widget.note != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMote ? 'Change Order' : 'Add Order'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_descriptionNode);
                },
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Name cannot be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Name ",
                  hintText: "eg: Kasun",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _mobileNoController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "mobile",
                  hintText: "076 8975463",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _descriptionController,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: "description",
                  hintText: "   Order List\n\nleeks - 10kg\nbeet root - 15kg\nonion - 20kg\ntomato - 20kg",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _locationController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "Address",
                  hintText: "No:456/A maharama mawatha,colombo",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _expDateController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "Exp Date",
                  hintText: "16/04/2021",
                  border: OutlineInputBorder(),
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text(isEditMote ? "Update" : "Save"),
                onPressed: () async {
                  if (_key.currentState.validate()) {
                    try {
                      if (isEditMote) {
                        Note note = Note(
                          description: _descriptionController.text,
                          title: _titleController.text,
                          location: _locationController.text,
                          mobileNo: _mobileNoController.text,
                          expDate: _expDateController.text,
                          id: widget.note.id,
                        );
                        await FirestoreService().updateNote(note);
                      } else {
                        Note note = Note(
                          description: _descriptionController.text,
                          title: _titleController.text,
                          location: _locationController.text,
                          mobileNo: _mobileNoController.text,
                          expDate: _expDateController.text,
                        );
                        await FirestoreService().addNote(note);
                      }
                      Navigator.pop(context);
                    } catch (e) {
                      print(e);
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
