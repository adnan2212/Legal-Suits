import 'package:flutter/material.dart';
import 'package:legalsuits/components/authbutt.dart';
import 'package:legalsuits/components/textfield.dart';
import 'package:legalsuits/globals.dart' as g;
import 'package:legalsuits/components/commons.dart';
import 'package:legalsuits/models/attorney.dart';
import 'package:legalsuits/models/contact.dart';
import 'package:legalsuits/screens/loading.dart';
import 'package:legalsuits/services/connect.dart';
import 'package:legalsuits/services/dbser.dart';
import 'package:string_validator/string_validator.dart';

class ContactAttorney extends StatefulWidget {
  const ContactAttorney({Key key, this.attorney}) : super(key: key);
  final Attorney attorney;

  @override
  _ContactAttorneyState createState() => _ContactAttorneyState();
}

class _ContactAttorneyState extends State<ContactAttorney> {
  TextEditingController title = TextEditingController(text: "");
  TextEditingController email = TextEditingController(text: "");
  TextEditingController number = TextEditingController(text: "");
  TextEditingController message = TextEditingController(text: "");
  final _key = GlobalKey<FormState>();
  bool isload = false;

  @override
  Widget build(BuildContext context) {
    return isload
        ? LoadingPage()
        : MainPage(
            child: GestureDetector(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: g.width * 0.045),
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
                      height: g.height * 0.0262,
                    ),
                    //title
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: g.width * 0.045),
                      child: Row(
                        children: [
                          Text(
                            "Contact",
                            style: casetitle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: g.height * 0.038,
                    ),
                    //Form of adding a new case
                    Expanded(
                      child: ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: g.width * 0.045),
                            child: Form(
                              key: _key,
                              child: Column(
                                children: [
                                  AddNewFormField(
                                    hintText: "Title",
                                    lines: 1,
                                    ctrl: title,
                                    validate: (String text) {
                                      if (text.trim().isEmpty) {
                                        return "Title cannot be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: g.height * 0.0219,
                                  ),
                                  AddNewFormField(
                                    hintText: "Email",
                                    lines: 1,
                                    ctrl: email,
                                    validate: (String text) {
                                      if (text.trim().isEmpty) {
                                        return "Email cannot be left empty";
                                      } else if (!isEmail(text.trim())) {
                                        return "Invalid Email Provided";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: g.height * 0.0219,
                                  ),
                                  AddNewFormField(
                                    hintText: "Number",
                                    lines: 1,
                                    ctrl: number,
                                    validate: (String text) {
                                      if (text.trim().isEmpty) {
                                        return "Number cannot be left empty";
                                      } else if (!isNumeric(text.trim())) {
                                        return "Invalid Number Provided";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: g.height * 0.0219,
                                  ),
                                  AddNewFormField(
                                    hintText: "Message",
                                    lines: 5,
                                    ctrl: message,
                                    validate: (String text) {
                                      if (text.trim().isEmpty) {
                                        return "Message cannot be left empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: g.height * 0.0997,
                                  ),
                                  SubmitButton(
                                    onPressed: () async {
                                      if (_key.currentState.validate()) {
                                        setState(() {
                                          isload = true;
                                        });
                                        String contactid =
                                            g.getRandomString(20);
                                        DBServices()
                                            .addcontact(Contact.fromMap({
                                          "contactid": contactid,
                                          "attorneyid": widget.attorney.uid,
                                          "email": email.text.trim(),
                                          "title": title.text.trim(),
                                          "number": number.text.trim(),
                                          "message": message.text.trim(),
                                          "dateTime": DateTime.now(),
                                        }))
                                            .then((value) {
                                          if (value is String) {
                                            setState(() {
                                              isload = false;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(value),
                                              ),
                                            );
                                          } else {
                                            setState(() {
                                              isload = false;
                                              Navigator.pop(context);
                                            });
                                          }
                                        });
                                        setState(() {
                                          isload = false;
                                        });
                                      }
                                    },
                                    buttonName: "Submit",
                                  ),
                                ],
                              ),
                            ),
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
