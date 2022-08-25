import 'package:flutter/material.dart';
import 'package:legalsuits/components/commons.dart';
import 'package:legalsuits/globals.dart' as g;
import 'package:legalsuits/models/contact.dart';

class ContactedCase extends StatefulWidget {
  const ContactedCase({Key key, this.contact}) : super(key: key);
  final Contact contact;

  @override
  _ContactedCaseState createState() => _ContactedCaseState();
}

class _ContactedCaseState extends State<ContactedCase> {
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
              bottom: g.height * 0.1092,
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
                      fit: BoxFit.fitHeight,
                      image: NetworkImage(g.img == "" ? g.defaulturi : g.img),
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
          Expanded(
            child: ListView(
              children: [
                //Case Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: g.width * 0.045),
                  child: Row(
                    children: [
                      Text(
                        widget.contact.title,
                        style: casetitle,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: g.height * 0.038,
                ),
                //case in details
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: g.width * 0.045),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '''
${widget.contact.message}
                            ''',
                            style: caseSubtitle,
                            softWrap: true,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: g.height * 0.048,
                      ),
                      //email id
                      Row(
                        children: [
                          Text(
                            widget.contact.email,
                            style: caseSubtitle,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: g.height * 0.018,
                      ),
                      //contact number
                      Row(
                        children: [
                          Text(
                            "+91 " + widget.contact.number,
                            style: caseSubtitle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: g.height * 0.048,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
