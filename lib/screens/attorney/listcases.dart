import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:legalsuits/components/cards.dart';
import 'package:legalsuits/components/commons.dart';
import 'package:legalsuits/components/textfield.dart';
import 'package:legalsuits/globals.dart' as g;
import 'package:legalsuits/models/case.dart';
import 'package:legalsuits/screens/loading.dart';
import 'package:legalsuits/services/dbser.dart';

class ListCasesPage extends StatefulWidget {
  const ListCasesPage({Key key}) : super(key: key);

  @override
  _ListCasesPageState createState() => _ListCasesPageState();
}

class _ListCasesPageState extends State<ListCasesPage> {
  String filter = "";
  List<CaseModel> cases;
  TextEditingController search = TextEditingController(text: "");
  bool allcasess = true;

  getdata() async {
    cases = await DBServices().getcases();
    setState(() {});
  }

  getdata2(String cat) async {
    cases = await DBServices().getcasessuggested(cat);
    setState(() {});
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
    return Expanded(
      child: Column(
        children: <Widget>[
          //SearchBar
          SearchField(
            ctrl: search,
            onPressed: () async {
              if (search.text.trim().isNotEmpty) {
                cases = await DBServices().getcaseslike(search.text.trim());
              }
            },
          ),
          //client or Attorny
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: g.width * 0.173, vertical: g.height * 0.03),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RawMaterialButton(
                    onPressed: () {
                      getdata();
                      setState(() {
                        getdata();
                        FocusScope.of(context).unfocus();
                        allcasess = true;
                      });
                    },
                    child: Text(
                      "All Cases",
                      style: allcasess ? signupselected : signupsonselected,
                    ),
                  ),
                  Container(
                    height: g.height * 0.05,
                    width: 1,
                    color: Colors.black,
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      getdata2(g.attorney.category);
                      setState(() {
                        print(g.attorney.category);
                        getdata2(g.attorney.category);
                        FocusScope.of(context).unfocus();
                        allcasess = false;
                      });
                    },
                    child: Text(
                      "Suggested",
                      style: allcasess ? signupsonselected : signupselected,
                    ),
                  ),
                ]),
          ),
          //page title and filter
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: g.width * 0.045),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "",
          //         style: pagetitle,
          //       ),
          //       Container(
          //         height: 24,
          //         width: 24,
          //         decoration: BoxDecoration(
          //           image: DecorationImage(
          //             image: AssetImage('lib/assets/Filter.png'),
          //             fit: BoxFit.contain,
          //           ),
          //         ),
          //         child: RawMaterialButton(onPressed: () {
          //           //choose the filter
          //           showDialog(
          //               context: context,
          //               builder: (BuildContext context) {
          //                 String filter2 = filter;
          //                 return StatefulBuilder(builder: (context, setState) {
          //                   return BackdropFilter(
          //                     filter: ImageFilter.blur(
          //                       sigmaX: 6.0,
          //                       sigmaY: 6.0,
          //                     ),
          //                     child: Center(
          //                       child: Material(
          //                         color: Colors.transparent,
          //                         child: Container(
          //                           height: g.height * 0.255,
          //                           width: g.width * 0.8,
          //                           decoration: BoxDecoration(
          //                             color: g.white,
          //                             borderRadius: BorderRadius.circular(20),
          //                           ),
          //                           child: Column(
          //                             children: <Widget>[
          //                                   Padding(
          //                                     padding: const EdgeInsets.only(
          //                                       left: 23,
          //                                       right: 23,
          //                                       top: 23,
          //                                     ),
          //                                     child: Row(
          //                                       mainAxisAlignment:
          //                                           MainAxisAlignment
          //                                               .spaceBetween,
          //                                       crossAxisAlignment:
          //                                           CrossAxisAlignment.start,
          //                                       children: [
          //                                         Text(
          //                                           "Filter",
          //                                           style: pagetitle,
          //                                         ),
          //                                       ],
          //                                     ),
          //                                   ),
          //                                   SizedBox(
          //                                     height: 3,
          //                                   ),
          //                                 ] +
          //                                 List.generate(
          //                                   g.filters2.length,
          //                                   (i) => Padding(
          //                                     padding: const EdgeInsets.only(
          //                                       left: 13.0,
          //                                       right: 13.0,
          //                                     ),
          //                                     child: RawMaterialButton(
          //                                       onPressed: () {
          //                                         setState(() {
          //                                           filter2 = g.filters2[i];
          //                                         });
          //                                       },
          //                                       child: Row(
          //                                         children: [
          //                                           Container(
          //                                             height: 20,
          //                                             width: 20,
          //                                             decoration: BoxDecoration(
          //                                               border: Border.all(
          //                                                   color: filter2 ==
          //                                                           g.filters2[
          //                                                               i]
          //                                                       ? Colors
          //                                                           .transparent
          //                                                       : g.blackfont2),
          //                                               color: filter2 ==
          //                                                       g.filters2[i]
          //                                                   ? g.bluebg
          //                                                   : Colors
          //                                                       .transparent,
          //                                               borderRadius:
          //                                                   BorderRadius
          //                                                       .circular(
          //                                                 20,
          //                                               ),
          //                                             ),
          //                                           ),
          //                                           SizedBox(
          //                                             width: 13,
          //                                           ),
          //                                           Text(
          //                                             g.filters2[i],
          //                                             style: filtertext,
          //                                           ),
          //                                         ],
          //                                       ),
          //                                     ),
          //                                   ),
          //                                 ) +
          //                                 [
          //                                   Expanded(child: Container()),
          //                                   Row(
          //                                     children: [
          //                                       Expanded(child: Container()),
          //                                       Container(
          //                                         height: 32,
          //                                         width: 100,
          //                                         decoration: BoxDecoration(
          //                                           color: g.primary,
          //                                           borderRadius:
          //                                               BorderRadius.only(
          //                                             bottomRight:
          //                                                 Radius.circular(18),
          //                                           ),
          //                                         ),
          //                                         child: RawMaterialButton(
          //                                           onPressed: () {
          //                                             getdata2(filter2);
          //                                             filter = filter2;
          //                                             Navigator.pop(context);
          //                                           },
          //                                           child: Center(
          //                                             child: Text(
          //                                               "Apply",
          //                                               style: caseMoreButton2,
          //                                             ),
          //                                           ),
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ],
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   );
          //                 });
          //               });
          //         }),
          //       ),
          //     ],
          //   ),
          // ),
          //cards of cases
          Expanded(
            child: cases == null
                ? LoadingPage()
                : cases.isEmpty
                    ? Center(
                        child: Text("No Cases found"),
                      )
                    : ListView(
                        children: List.generate(
                            cases.length,
                            (i) => CaseCard2(
                                  caseModel: cases[i],
                                )),
                      ),
          ),
          Container(
            height: g.height * 0.1,
          ),
        ],
      ),
    );
  }
}
