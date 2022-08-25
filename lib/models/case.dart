class CaseModel {
  String caseid;
  String caseTitle;
  String caseSubject;
  String caseDescription;
  String uid;
  DateTime dateTime;
  int caseBudget;
  String caseCategory;

  CaseModel.fromMap(Map map) {
    this.caseid = map["caseId"];
    this.caseTitle = map["caseTitle"];
    this.caseSubject = map["caseSubject"];
    this.caseDescription = map["caseDescription"];
    this.uid = map["uid"];
    this.dateTime = map["dateTime"] is DateTime
        ? map["dateTime"]
        : map["dateTime"].toDate();
    this.caseBudget = map["caseBudget"];
    this.caseCategory = map["caseCategory"];
  }

  Map<String, dynamic> tomap() {
    Map<String, dynamic> map = {
      "caseId": this.caseid,
      "caseTitle": this.caseTitle,
      "caseSubject": this.caseSubject,
      "caseDescription": this.caseDescription,
      "uid": this.uid,
      "dateTime": this.dateTime,
      "caseBudget": this.caseBudget,
      "caseCategory": this.caseCategory,
    };
    return map;
  }
}
