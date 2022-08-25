import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:legalsuits/components/commons.dart';
import 'package:legalsuits/globals.dart' as g;
import 'package:legalsuits/screens/attorney/contact.dart';
import 'package:legalsuits/screens/attorney/listcases.dart';
import 'package:legalsuits/screens/attorney/profile.dart';
import 'package:legalsuits/services/dbser.dart';
import 'package:page_transition/page_transition.dart';

class AttorneyHome extends StatefulWidget {
  const AttorneyHome({Key key}) : super(key: key);

  @override
  _AttorneyHomeState createState() => _AttorneyHomeState();
}

class _AttorneyHomeState extends State<AttorneyHome> {
  String page = "List";
  Map pages = {
    "List": ListCasesPage(),
    "Contact": ContactPage(),
  };

  Future getdata() async {
    List j = await DBServices().isfileexist("profile/${g.attorney.uid}");
    print(j);
    if (j.isNotEmpty) {
      g.img = await FirebaseStorage.instance
          .ref("profile/${g.attorney.uid}")
          .getDownloadURL();
      setState(() {
        print(g.img);
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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              children: [
                //appbar logo and skip option
                Padding(
                  padding: EdgeInsets.only(
                    top: g.height * 0.0492,
                    right: g.width * 0.058,
                    left: g.width * 0.058,
                    bottom: g.height * 0.0592,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      TitleText(),
                      Container(
                        height: g.height * 0.1,
                        width: g.height * 0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(
                                g.img == "" ? g.defaulturi : g.img),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                pages[page],
              ],
            ),
          ),
          Positioned(
            height: g.width * 3,
            width: g.width * 3,
            top: g.height * 0.9,
            left: -g.width,
            child: Container(
              decoration: BoxDecoration(
                  color: g.primary,
                  borderRadius: BorderRadius.circular(g.width * 3)),
            ),
          ),
          Positioned(
            height: 42,
            width: 42,
            bottom: 6,
            right: 47,
            child: RawMaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: MyProfileAttorney(),
                    duration: Duration(milliseconds: 500),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/assets/ProfileW.png"),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            height: 42,
            width: 42,
            bottom: 6,
            left: 47,
            child: RawMaterialButton(
              onPressed: () {
                setState(() {
                  page = "Contact";
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/assets/MessageW.png"),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            height: 42,
            width: 42,
            bottom: 20,
            left: (g.width * 0.5) - 21,
            child: RawMaterialButton(
              onPressed: () {
                setState(() {
                  page = "List";
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/assets/Paper.png"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
