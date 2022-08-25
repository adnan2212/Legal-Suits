class Attorney {
  String uid;
  String username;
  String phoneNo;
  String attorneyNo;
  String category;
  int ratePh;
  String casePriceSheet;
  String casePortfolio;
  bool llb;
  bool llm;
  String bio;

  Attorney.fromMap(Map map) {
    this.uid = map["uid"];
    this.username = map["username"];
    this.phoneNo = map["phoneNo"];
    this.attorneyNo = map["attorneyNo"];
    this.category = map["category"];
    this.ratePh = map["ratePh"];
    this.llb = map["llb"];
    this.llm = map["llm"];
    this.bio = map["bio"];
  }

  Map<String, dynamic> tomap() {
    Map<String, dynamic> map = {
      "uid": this.uid,
      "username": this.username,
      "phoneNo": this.phoneNo,
      "attorneyNo": this.attorneyNo,
      "category": this.category,
      "ratePh": this.ratePh,
      "llb": this.llb,
      "llm": this.llm,
      "bio": this.bio,
    };
    return map;
  }
}
