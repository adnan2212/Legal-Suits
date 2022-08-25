class Contact {
  String contactid;
  String attorneyid;
  String email;
  String title;
  String number;
  String message;
  DateTime dateTime;

  Contact.fromMap(Map map) {
    this.contactid = map["contactid"];
    this.attorneyid = map["attorneyid"];
    this.email = map["email"];
    this.title = map["title"];
    this.number = map["number"];
    this.message = map["message"];
    this.dateTime = map["dateTime"] is DateTime
        ? map["dateTime"]
        : map["dateTime"].toDate();
  }

  Map<String, dynamic> tomap() {
    Map<String, dynamic> map = {
      "contactid": this.contactid,
      "attorneyid": this.attorneyid,
      "email": this.email,
      "title": this.title,
      "number": this.number,
      "message": this.message,
      "dateTime": this.dateTime
    };
    return map;
  }
}
