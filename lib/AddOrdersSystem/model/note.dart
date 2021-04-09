class Note {
  final String title;
  final String description;
  final String location;
  final String mobileNo;
  final String expDate;
  final String id;

  Note({this.title, this.description,this.location,this.mobileNo,this.expDate, this.id});

  Note.fromMap(Map<String,dynamic> data, String id):
        title=data["title"],
        description=data['description'],
        location=data['location'],
        mobileNo=data['mobileNo'],
        expDate=data['expDate'],
        id=id;

  Map<String, dynamic> toMap() {
    return {
      "title" : title,
      "description":description,
      "location":location,
      "mobileNo":mobileNo,
      "expDate":expDate,
    };
  }

}