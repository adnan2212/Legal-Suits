import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:legalsuits/components/authbutt.dart';
import 'package:legalsuits/components/commons.dart';
import 'package:legalsuits/components/images.dart';
import 'package:legalsuits/globals.dart' as g;
import 'package:legalsuits/models/attorney.dart';
import 'package:legalsuits/screens/client/contactatt.dart';
import 'package:legalsuits/services/dbser.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class AttorneyInfo extends StatefulWidget {
  const AttorneyInfo({Key key, this.attorney}) : super(key: key);
  final Attorney attorney;

  @override
  _AttorneyInfoState createState() => _AttorneyInfoState();
}

class _AttorneyInfoState extends State<AttorneyInfo> {
  String img = "";
  Future getdata() async {
    List j = await DBServices().isfileexist("profile/${widget.attorney.uid}");

    print(j);
    if (j.isNotEmpty) {
      img = await FirebaseStorage.instance
          .ref("profile/${widget.attorney.uid}")
          .getDownloadURL();
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
    return Scaffold(
      body: ListView(
        children: [
          //appbar logo and skip option
          Padding(
            padding: EdgeInsets.only(
              top: g.height * 0.0492,
              right: g.width * 0.058,
              left: g.width * 0.058,
              bottom: g.height * 0.0392,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              textBaseline: TextBaseline.alphabetic,
              children: [
                TitleText(),
                Container(
                  width: g.width * 0.1,
                  height: g.height * 0.05,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/assets/paperplus.png"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //back button and icon
          Padding(
            padding: EdgeInsets.symmetric(horizontal: g.width * 0.045),
            child: RawMaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  SizedBox(
                    width: g.width * 0.045,
                  ),
                  Text(
                    "Back",
                    style: back,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: g.height * 0.0392,
          ),

          //attorney briefs
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: g.height * 0.125,
                  width: g.height * 0.125,
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
                child: Container(),
              ),
              Column(
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
              SizedBox(
                width: g.width * 0.15,
              ),
            ],
          ),
          SizedBox(
            height: g.height * 0.07,
          ),

          // Attorney info in details
          Padding(
            padding: EdgeInsets.symmetric(horizontal: g.width * 0.045),
            child: Text(
              '''
${widget.attorney.bio}
                    ''',
              style: caseSubtitle,
              softWrap: true,
            ),
          ),
          SizedBox(
            height: g.height * 0.048,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AttorneyButton1(
                buttonname: "Case Price Sheet",
                onpressed: () async {
                  List j = await DBServices()
                      .isfileexist("pricesheet/${widget.attorney.uid}");
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
              ),
              AttorneyButton1(
                buttonname: "Case Portfolio",
                onpressed: () async {
                  List j = await DBServices()
                      .isfileexist("portfolio/${widget.attorney.uid}");
                  print(j);
                  if (j.isNotEmpty) {
                    String url = await FirebaseStorage.instance
                        .ref("portfolio/${widget.attorney.uid}")
                        .getDownloadURL();
                    await launch(url);
                    setState(() {
                      print(g.img);
                    });
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AttorneyButton1(
                buttonname: "Contact",
                onpressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: ContactAttorney(
                        attorney: widget.attorney,
                      ),
                      duration: Duration(milliseconds: 500),
                      type: PageTransitionType.rightToLeft,
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
