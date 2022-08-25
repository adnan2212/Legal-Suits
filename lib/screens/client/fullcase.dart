import 'package:flutter/material.dart';
import 'package:legalsuits/components/cards.dart';
import 'package:legalsuits/components/commons.dart';
import 'package:legalsuits/globals.dart' as g;
import 'package:legalsuits/models/attorney.dart';
import 'package:legalsuits/models/case.dart';
import 'package:legalsuits/screens/loading.dart';
import 'package:legalsuits/services/dbser.dart';

class FullCase extends StatefulWidget {
  const FullCase({Key key, this.caseModel}) : super(key: key);
  final CaseModel caseModel;
  @override
  _FullCaseState createState() => _FullCaseState();
}

class _FullCaseState extends State<FullCase> {
  var attintrested;

  getdata() async {
    attintrested =
        await DBServices().getinterestedatts(widget.caseModel.caseid);
    if (mounted) setState(() {});
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
      body: Column(
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
            height: g.height * 0.0597,
          ),
          Column(
            children: [
              //Case Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: g.width * 0.045),
                child: Row(
                  children: [
                    Text(
                      widget.caseModel.caseTitle,
                      style: casetitle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: g.height * 0.038,
              ),
              //Subject of the case
              Padding(
                padding: EdgeInsets.symmetric(horizontal: g.width * 0.045),
                child: Row(
                  children: [
                    Text(
                      widget.caseModel.caseSubject,
                      style: casesubject,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: g.width * 0.045),
                child: Row(
                  children: [
                    Text(
                      "Budget: ₹ ${widget.caseModel.caseBudget}",
                      style: casesubject,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: g.width * 0.045),
                child: Row(
                  children: [
                    Text(
                      "Category: ${widget.caseModel.caseCategory}",
                      style: casesubject,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: g.height * 0.048,
              ),
              //case in details
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: g.width * 0.045),
                    child: Text(
                      '''
${widget.caseModel.caseDescription}
                      ''',
                      style: caseSubtitle,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: g.height * 0.008,
              ),
              g.user.type == "client"
                  ? Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: g.width * 0.045),
                      child: Row(
                        children: [
                          Text(
                            "Attorney Interested",
                            style: casetitle,
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
              //interested attorneys
            ],
          ),
          g.user.type == "client"
              ? Expanded(
                  child: attintrested == null
                      ? LoadingPage()
                      : attintrested is String
                          ? Center(
                              child: Text("No Attorney Interested Yet"),
                            )
                          : attintrested.isEmpty
                              ? Center(
                                  child: Text("No Data"),
                                )
                              : ListView(
                                  children: List.generate(
                                      attintrested.length,
                                      (i) => AttorneyCard(
                                            attorney: attintrested[i],
                                          )),
                                ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
