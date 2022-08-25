import 'package:flutter/material.dart';
import 'package:legalsuits/components/authbutt.dart';
import 'package:legalsuits/components/cards.dart';
import 'package:legalsuits/components/commons.dart';
import 'package:legalsuits/components/textfield.dart';
import 'package:legalsuits/globals.dart' as g;
import 'package:legalsuits/screens/client/newcase.dart';
import 'package:legalsuits/screens/loading.dart';
import 'package:legalsuits/services/dbser.dart';
import 'package:page_transition/page_transition.dart';

class ClientHome extends StatefulWidget {
  const ClientHome({Key key}) : super(key: key);

  @override
  _ClientHomeState createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  List allcases;
  TextEditingController search = TextEditingController(text: "");

  getdata() async {
    allcases = await DBServices().getcases();
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
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
              height: g.height * 0.0392,
            ),
            //search field
            SearchField(
              ctrl: search,
              onPressed: () async {
                if (search.text.trim().isNotEmpty) {
                  print(search.text.trim());
                  allcases =
                      await DBServices().getcaseslike(search.text.trim());
                  setState(() {});
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
            //List of all cases
            Expanded(
                child: allcases == null
                    ? Center(
                        child: LoadingPage(),
                      )
                    : allcases.isEmpty
                        ? Center(
                            child: Text("No data"),
                          )
                        : ListView(
                            children: List.generate(
                                allcases.length,
                                (i) => CaseCard(
                                      casemode: allcases[i],
                                    )),
                          )),
            //Add new case button
            SubmitButton(
              buttonName: "Add New Case",
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: NewCase(),
                    duration: Duration(milliseconds: 500),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
