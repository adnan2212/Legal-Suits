class UserinApp {
  String uid;
  String email;
  String password;
  String type;

  UserinApp.fromMap(Map map) {
    this.email = map["email"];
    this.uid = map["uid"];
    this.password = map["password"];
    this.type = map["type"];
  }

  Map<String, dynamic> tomap() {
    Map<String, dynamic> map = {
      "uid": this.uid,
      "email": this.email,
      "password": this.password,
      "type": this.type,
    };
    return map;
  }
}
