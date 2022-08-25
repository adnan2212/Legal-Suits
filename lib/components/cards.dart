import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:legalsuits/components/commons.dart';
import 'package:legalsuits/components/images.dart';
import 'package:legalsuits/globals.dart' as g;
import 'package:legalsuits/models/attorney.dart';
import 'package:legalsuits/models/case.dart';
import 'package:legalsuits/models/contact.dart';
import 'package:legalsuits/screens/attorney/fullcontact.dart';
import 'package:legalsuits/screens/client/attorneyinfo.dart';
import 'package:legalsuits/screens/client/fullcase.dart';
import 'package:legalsuits/services/dbser.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class CaseCard extends StatefulWidget {
  const CaseCard({Key key, this.casemode}) : super(key: key);
  final CaseModel casemode;

  @override
  _CaseCardState createState() => _CaseCardState();
}

class _CaseCardState extends State<CaseCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: g.width * 0.077,
            right: g.width * 0.077,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  offset: Offset(0, 0),
                  color: g.blackfont2.withOpacity(0.1),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: RawMaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: FullCase(
                      caseModel: widget.casemode,
                    ),
                    duration: Duration(milliseconds: 500),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 21, bottom: 4.5),
                    child: Text(
                      widget.casemode.caseTitle,
                      style: casetitle,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.5),
                    child: Text(
                      widget.casemode.caseDescription,
                      style: caseSubtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 21,
                        width: 80,
                        decoration: BoxDecoration(
                          color: g.primary,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: RawMaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: FullCase(
                                  caseModel: widget.casemode,
                                ),
                                duration: Duration(milliseconds: 500),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                          child: Center(
                            child: Text("More", style: caseMoreButton),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: g.height * 0.0318,
        ),
      ],
    );
  }
}

class CaseCard2 extends StatefulWidget {
  const CaseCard2({Key key, this.caseModel}) : super(key: key);
  final CaseModel caseModel;

  @override
  _CaseCard2State createState() => _CaseCard2State();
}

class _CaseCard2State extends State<CaseCard2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: g.width * 0.077,
            right: g.width * 0.077,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  offset: Offset(0, 0),
                  color: g.blackfont2.withOpacity(0.1),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: RawMaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: FullCase(
                      caseModel: widget.caseModel,
                    ),
                    duration: Duration(milliseconds: 500),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 21, bottom: 4.5),
                    child: Text(
                      widget.caseModel.caseTitle,
                      style: casetitle,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.5),
                    child: Text(
                      widget.caseModel.caseDescription,
                      style: caseSubtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 21,
                        width: 80,
                        decoration: BoxDecoration(
                          color: g.primary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: RawMaterialButton(
                          onPressed: () async {
                            await DBServices().addinterest(
                                widget.caseModel.caseid, g.user.uid);
                          },
                          child: Center(
                            child: Text("Interested", style: caseMoreButton),
                          ),
                        ),
                      ),
                      Container(
                        height: 21,
                        width: 80,
                        decoration: BoxDecoration(
                          color: g.primary,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: RawMaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: FullCase(
                                  caseModel: widget.caseModel,
                                ),
                                duration: Duration(milliseconds: 500),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                          child: Center(
                            child: Text("More", style: caseMoreButton),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: g.height * 0.0318,
        ),
      ],
    );
  }
}

class ContactCard extends StatefulWidget {
  const ContactCard({Key key, this.contact}) : super(key: key);
  final Contact contact;

  @override
  _ContactCardState createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: g.width * 0.077,
            right: g.width * 0.077,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  offset: Offset(0, 0),
                  color: g.blackfont2.withOpacity(0.1),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: RawMaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: ContactedCase(
                      contact: widget.contact,
                    ),
                    duration: Duration(milliseconds: 500),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 21, bottom: 4.5),
                    child: Text(
                      widget.contact.title,
                      style: casetitle,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.5),
                    child: Text(
                      widget.contact.message,
                      style: caseSubtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 21,
                        width: 80,
                        decoration: BoxDecoration(
                          color: g.primary,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: RawMaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: FullCase(),
                                duration: Duration(milliseconds: 500),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                          child: Center(
                            child: Text("More", style: caseMoreButton),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: g.height * 0.0318,
        ),
      ],
    );
  }
}

class AttorneyCard extends StatefulWidget {
  const AttorneyCard({Key key, this.attorney}) : super(key: key);
  final Attorney attorney;

  @override
  _AttorneyCardState createState() => _AttorneyCardState();
}

class _AttorneyCardState extends State<AttorneyCard> {
  String img = "";
  Future getdata() async {
    List j = await DBServices().isfileexist("profile/${widget.attorney.uid}");

    print(j);
    if (j.isNotEmpty) {
      img = await FirebaseStorage.instance
          .ref("profile/${widget.attorney.uid}")
          .getDownloadURL();
      if (mounted)
        setState(() {
          print(img);
        });
    }
  }

  @override
  void initState() {
    setState(() {
      getdata();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String llb = widget.attorney.llb ? "LLB" : "-";
    String llm = widget.attorney.llm ? "LLM" : "-";
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: g.height * 0.028,
      ),
      child: Container(
        height: g.height * 0.16,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              offset: Offset(0, 0),
              color: g.blackfont2.withOpacity(0.1),
              spreadRadius: 2,
            ),
          ],
        ),
        child: RawMaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                child: AttorneyInfo(
                  attorney: widget.attorney,
                ),
                duration: Duration(milliseconds: 500),
                type: PageTransitionType.rightToLeft,
              ),
            );
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: g.height * 0.1,
                  width: g.height * 0.1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: NetworkImage(img == "" ? g.defaulturi : img),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Iconcard(
                          imagename: "Profile",
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          widget.attorney.username,
                          style: attname,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Iconcard(
                          imagename: "Work",
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          widget.attorney.category + " Attorney",
                          style: attdetails,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Iconcard(
                          imagename: "Ticket",
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          llb + ", " + llm,
                          style: attdetails,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Iconcard(
                                  imagename: "dollar",
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  widget.attorney.ratePh.toString() + "/hr",
                                  style: attdetails,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        Container(
                          height: 26,
                          width: 100,
                          decoration: BoxDecoration(
                            color: g.primary,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(18),
                            ),
                          ),
                          child: RawMaterialButton(
                            onPressed: () async {
                              List j = await DBServices().isfileexist(
                                  "pricesheet/${widget.attorney.uid}");
                              print(j);
                              if (j.isNotEmpty) {
                                String url = await FirebaseStorage.instance
                                    .ref("pricesheet/${widget.attorney.uid}")
                                    .getDownloadURL();
                                await launch(url);
                                setState(() {
                                  print(g.img);
                                });
                              }
                            },
                            child: Center(
                              child: Text(
                                "Price Sheet",
                                style: caseMoreButton,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
