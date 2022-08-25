import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:legalsuits/models/attorney.dart';
import 'package:legalsuits/models/client.dart';
import 'package:legalsuits/models/contact.dart';
import 'package:legalsuits/models/user.dart';
import 'package:legalsuits/models/case.dart';
import 'package:legalsuits/globals.dart' as g;

class DBServices {
  //adding data
  Future registerUser(UserinApp user) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .set(user.tomap());
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
    return user;
  }

  Future registerClient(Client user) async {
    try {
      await FirebaseFirestore.instance
          .collection("clients")
          .doc(user.uid)
          .set(user.tomap());
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  Future registerAttorney(Attorney user) async {
    try {
      await FirebaseFirestore.instance
          .collection("attorneys")
          .doc(user.uid)
          .set(user.tomap());
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  Future addcase(CaseModel newcase) async {
    try {
      await FirebaseFirestore.instance
          .collection("cases")
          .doc(newcase.caseid)
          .set(newcase.tomap());
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  Future addcontact(Contact contact) async {
    try {
      await FirebaseFirestore.instance
          .collection("contact")
          .doc(contact.contactid)
          .set(contact.tomap());
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  Future addinterest(String caseid, String attorneyid) async {
    try {
      List v = await FirebaseFirestore.instance
          .collection("interest")
          .where("caseid", isEqualTo: caseid)
          .where("attorneyid", isEqualTo: attorneyid)
          .get()
          .then((value) => value.docs.map((e) => e.id).toList());
      if (v.length == 0) {
        await FirebaseFirestore.instance
            .collection("interest")
            .add({"caseid": caseid, "attorneyid": attorneyid});
      }
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  //addphoto
  Future addFile(filepath) async {
    await FirebaseFirestore.instance
        .collection("docs")
        .doc()
        .set({"docid": filepath});
  }

  //retreiving data
  Future getpassword(String email) async {
    try {
      var v = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: email)
          .get()
          .then((value) => value.docs.map((element) {
                return element.data()["password"];
              }).toList());
      if (v.isEmpty) {
        return "User not registered";
      } else {
        return v;
      }
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  Future getType(uid) async {
    try {
      var v =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      return v.data()["type"];
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  Future getuser(String uid, String type) async {
    try {
      var v = await FirebaseFirestore.instance.collection(type).doc(uid).get();
      return v.data();
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  Future getattorney(String uid) async {
    try {
      var v = await FirebaseFirestore.instance
          .collection("attorneys")
          .doc(uid)
          .get()
          .then((value) => Attorney.fromMap(value.data()));
      return v;
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  Future getallattorneys(String filter) async {
    try {
      if (filter == "") {
        var v = await FirebaseFirestore.instance
            .collection("attorneys")
            .get()
            .then((value) =>
                value.docs.map((e) => Attorney.fromMap(e.data())).toList());
        return v;
      } else if (filter == "Low to High") {
        var v = await FirebaseFirestore.instance
            .collection("attorneys")
            .orderBy("ratePh", descending: false)
            .get()
            .then((value) =>
                value.docs.map((e) => Attorney.fromMap(e.data())).toList());
        return v;
      } else if (filter == "High to Low") {
        var v = await FirebaseFirestore.instance
            .collection("attorneys")
            .orderBy("ratePh", descending: true)
            .get()
            .then((value) =>
                value.docs.map((e) => Attorney.fromMap(e.data())).toList());
        return v;
      } else if (filter == "LLB") {
        var v = await FirebaseFirestore.instance
            .collection("attorneys")
            .where("llb", isEqualTo: true)
            .get()
            .then((value) =>
                value.docs.map((e) => Attorney.fromMap(e.data())).toList());
        return v;
      } else if (filter == "LLM") {
        var v = await FirebaseFirestore.instance
            .collection("attorneys")
            .where("llm", isEqualTo: true)
            .get()
            .then((value) =>
                value.docs.map((e) => Attorney.fromMap(e.data())).toList());
        return v;
      }
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  Future getattorneyscat(String category, String filter) async {
    try {
      if (filter == "") {
        var v = await FirebaseFirestore.instance
            .collection("attorneys")
            .where("category", isEqualTo: category)
            .get()
            .then((value) =>
                value.docs.map((e) => Attorney.fromMap(e.data())).toList());
        return v;
      }
      if (filter == "Low to High") {
        var v = await FirebaseFirestore.instance
            .collection("attorneys")
            .where("category", isEqualTo: category)
            .orderBy("ratePh", descending: false)
            .get()
            .then((value) =>
                value.docs.map((e) => Attorney.fromMap(e.data())).toList());
        return v;
      }
      if (filter == "High to Low") {
        var v = await FirebaseFirestore.instance
            .collection("attorneys")
            .where("category", isEqualTo: category)
            .orderBy("ratePh", descending: true)
            .get()
            .then((value) =>
                value.docs.map((e) => Attorney.fromMap(e.data())).toList());
        return v;
      }
      if (filter == "LLB") {
        var v = await FirebaseFirestore.instance
            .collection("attorneys")
            .where("category", isEqualTo: category)
            .where("llb", isEqualTo: true)
            .get()
            .then((value) =>
                value.docs.map((e) => Attorney.fromMap(e.data())).toList());
        return v;
      }
      if (filter == "LLM") {
        var v = await FirebaseFirestore.instance
            .collection("attorneys")
            .where("category", isEqualTo: category)
            .where("llm", isEqualTo: true)
            .get()
            .then((value) =>
                value.docs.map((e) => Attorney.fromMap(e.data())).toList());
        return v;
      }
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  Future getcases() async {
    try {
      var v = await FirebaseFirestore.instance
          .collection("cases")
          .orderBy("caseBudget", descending: true)
          .get()
          .then((value) =>
              value.docs.map((e) => CaseModel.fromMap(e.data())).toList());
      return v;
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  Future getcasessuggested(String caseCategory) async {
    try {
      var v = await FirebaseFirestore.instance
          .collection("cases")
          .where("caseCategory", isEqualTo: caseCategory)
          .orderBy("caseBudget", descending: true)
          .get()
          .then((value) =>
              value.docs.map((e) => CaseModel.fromMap(e.data())).toList());
      print(caseCategory);
      return v;
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  Future getcasesfilter(String filter) async {
    try {
      if (filter == "Newly Added to Old") {
        var v = await FirebaseFirestore.instance
            .collection("cases")
            .orderBy("dateTime", descending: false)
            .get()
            .then((value) =>
                value.docs.map((e) => CaseModel.fromMap(e.data())).toList());
        return v;
      }
      if (filter == "High to Low") {
        var v = await FirebaseFirestore.instance
            .collection("cases")
            .orderBy("dateTime", descending: true)
            .get()
            .then((value) =>
                value.docs.map((e) => CaseModel.fromMap(e.data())).toList());
        return v;
      }
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  Future getcontacts() async {
    try {
      var v = await FirebaseFirestore.instance
          .collection("contact")
          .where("attorneyid", isEqualTo: g.user.uid)
          .get()
          .then((value) =>
              value.docs.map((e) => Contact.fromMap(e.data())).toList());
      return v;
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  Future getinterestedatts(String caseid) async {
    try {
      var v = await FirebaseFirestore.instance
          .collection("interest")
          .where("caseid", isEqualTo: caseid)
          .get()
          .then((value) =>
              value.docs.map((e) => e.data()["attorneyid"]).toList());
      var u = await FirebaseFirestore.instance
          .collection("attorneys")
          .where("uid", whereIn: v)
          .get()
          .then((value) =>
              value.docs.map((e) => Attorney.fromMap(e.data())).toList());

      return u;
    } on PlatformException catch (e) {
      print(e.message);
      return e.message;
    } catch (e) {
      print(e.message);
      return e.message;
    }
  }

  //photo exists
  Future<List> isfileexist(id) async {
    return await FirebaseFirestore.instance
        .collection("docs")
        .where("docid", isEqualTo: id)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
  }

  Future getattorneyslike(String str) async {
    try {
      var v = await FirebaseFirestore.instance
          .collection("attorneys")
          .where(
            "username",
            isGreaterThanOrEqualTo: str,
            isLessThan: str.substring(0, str.length - 1) +
                String.fromCharCode(str.codeUnitAt(str.length - 1) + 1),
          )
          .get()
          .then((value) =>
              value.docs.map((e) => Attorney.fromMap(e.data())).toList());
      return v;
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  Future getcaseslike(String str) async {
    try {
      var v = await FirebaseFirestore.instance
          .collection("cases")
          .where("caseTitle",
              isGreaterThanOrEqualTo: str,
              isLessThan: str.substring(0, str.length - 1) +
                  String.fromCharCode(str.codeUnitAt(str.length - 1) + 1))
          .get()
          .then((value) =>
              value.docs.map((e) => CaseModel.fromMap(e.data())).toList());
      return v;
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  //updating data

  Future updateattorney(Attorney attorney) async {
    try {
      var v = await FirebaseFirestore.instance
          .collection("attorneys")
          .doc(attorney.uid)
          .set(attorney.tomap());
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }
}
