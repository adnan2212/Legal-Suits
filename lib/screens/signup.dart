import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:legalsuits/components/authbutt.dart';
import 'package:legalsuits/components/commons.dart';
import 'package:legalsuits/components/textfield.dart';
import 'package:legalsuits/globals.dart' as g;
import 'package:legalsuits/models/attorney.dart';
import 'package:legalsuits/models/client.dart';
import 'package:legalsuits/models/user.dart';
import 'package:legalsuits/services/auth.dart';
import 'package:string_validator/string_validator.dart';
import 'package:legalsuits/screens/loading.dart';
import 'package:legalsuits/services/dbser.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController cliusername = TextEditingController(text: "");
  TextEditingController cliphone = TextEditingController(text: "");
  TextEditingController cliemail = TextEditingController(text: "");
  TextEditingController clipass = TextEditingController(text: "");
  TextEditingController clipass2 = TextEditingController(text: "");
  TextEditingController attusername = TextEditingController(text: "");
  TextEditingController attnum = TextEditingController(text: "");
  TextEditingController attphone = TextEditingController(text: "");
  TextEditingController attemail = TextEditingController(text: "");
  TextEditingController attpass = TextEditingController(text: "");
  TextEditingController attpass2 = TextEditingController(text: "");
  final _clientkey = GlobalKey<FormState>();
  final _attorneykey = GlobalKey<FormState>();
  bool client = true;
  String cat = "";
  bool isload = false;

  @override
  Widget build(BuildContext context) {
    g.width = MediaQuery.of(context).size.width;
    g.height = MediaQuery.of(context).size.height;
    return isload
        ? LoadingPage()
        : GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Container(
                child: ListView(
                  children: client
                      ? [
                          //appbar logo and skip option
                          Padding(
                            padding: EdgeInsets.only(
                              top: g.height * 0.0392,
                              right: g.width * 0.058,
                              left: g.width * 0.058,
                              bottom: g.height * 0.0692,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                TitleText(),
                                RawMaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Back",
                                    style: skip,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //welcome to sign up screen
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: g.width * 0.093),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Welcome",
                                      style: wlcomeback,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Sign up with ",
                                      style: subwelcome,
                                    ),
                                    Text(
                                      "Legal Suits",
                                      style: lsblue,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          //client or Attorny
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: g.width * 0.173,
                                vertical: g.height * 0.06),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RawMaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        FocusScope.of(context).unfocus();
                                        client = true;
                                      });
                                    },
                                    child: Text(
                                      "Client",
                                      style: client
                                          ? signupselected
                                          : signupsonselected,
                                    ),
                                  ),
                                  Container(
                                    height: g.height * 0.05,
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                  RawMaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        FocusScope.of(context).unfocus();
                                        client = false;
                                      });
                                    },
                                    child: Text(
                                      "Attorney",
                                      style: client
                                          ? signupsonselected
                                          : signupselected,
                                    ),
                                  ),
                                ]),
                          ),

                          //client side
                          //text fields to input email,phone, username password and login button
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: g.width * 0.05),
                            child: Form(
                              key: _clientkey,
                              child: Column(
                                children: [
                                  TxtField(
                                    controller: cliusername,
                                    prefix: "Profile",
                                    hint: "Username",
                                    ispass: false,
                                    validate: (String uname) {
                                      if (uname.trim().isEmpty) {
                                        return "Username cannot be empty";
                                      } else if (uname.trim().length >= 16) {
                                        return "Username cannot be more than 16 characters";
                                      } else if (!isAlpha(uname.trim())) {
                                        return "Username can only contain letters";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TxtField(
                                    controller: cliphone,
                                    prefix: "Call",
                                    hint: "Contact Number",
                                    ispass: false,
                                    validate: (String numb) {
                                      if (numb.trim().isEmpty) {
                                        return "Phone cannot be empty";
                                      } else if (!isNumeric(numb.trim()) &&
                                          numb.trim().length != 10) {
                                        return "Invalid Phone Number";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TxtField(
                                    controller: cliemail,
                                    prefix: "Message",
                                    hint: "Email",
                                    ispass: false,
                                    validate: (String email) {
                                      if (email.trim().isEmpty) {
                                        return "Email cannot be empty";
                                      } else if (!isEmail(email.trim())) {
                                        return "Invalid Email Id";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TxtField(
                                    controller: clipass,
                                    prefix: "Lock",
                                    hint: "Password",
                                    ispass: true,
                                    validate: (String pass) {
                                      if (pass.trim().isEmpty) {
                                        return "Password cannot be empty";
                                      } else if (pass.trim().length < 8) {
                                        return "Password not Strong";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TxtField(
                                    controller: clipass2,
                                    prefix: "Lock",
                                    hint: "Confirm Password",
                                    ispass: true,
                                    validate: (String pass2) {
                                      if (pass2.trim().isEmpty) {
                                        return "Password cannot be empty";
                                      } else if (pass2.trim() !=
                                          clipass.text.trim()) {
                                        return "Password does not match";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  AuthButton(
                                    buttonName: "Sign up",
                                    onPressed: () {
                                      if (_clientkey.currentState.validate()) {
                                        setState(() {
                                          isload = true;
                                        });
                                        AuthServices()
                                            .register(cliemail.text.trim(),
                                                clipass.text.trim())
                                            .then((result) {
                                          if (result is String) {
                                            setState(() {
                                              isload = false;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(result),
                                              ),
                                            );
                                          } else {
                                            DBServices()
                                                .registerUser(
                                                    UserinApp.fromMap({
                                              "uid": result.uid,
                                              "email": result.email,
                                              "password": clipass.text.trim(),
                                              "type": "client",
                                            }))
                                                .then((result) {
                                              if (result is String) {
                                                setState(() {
                                                  isload = false;
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(result),
                                                  ),
                                                );
                                              } else {
                                                setState(() {
                                                  isload = false;
                                                });
                                                Navigator.pop(context);
                                                DBServices().registerClient(
                                                    Client.fromMap({
                                                  "uid": result.uid,
                                                  "username":
                                                      cliusername.text.trim(),
                                                  "phoneno":
                                                      cliphone.text.trim(),
                                                }));
                                              }
                                            });
                                          }
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //terms and condition
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 50),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    "By continuing you agree to our",
                                    style: tncnonclickable,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Terms of service",
                                        style: tncclickable,
                                      ),
                                      Text(
                                        " & ",
                                        style: tncnonclickable,
                                      ),
                                      Text(
                                        "Privacy Policy",
                                        style: tncclickable,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]
                      : [
                          //appbar logo and skip option
                          Padding(
                            padding: EdgeInsets.only(
                              top: g.height * 0.0392,
                              right: g.width * 0.058,
                              left: g.width * 0.058,
                              bottom: g.height * 0.0692,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                TitleText(),
                                RawMaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Back",
                                    style: skip,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //welcome to sign up screen
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: g.width * 0.093),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Welcome",
                                      style: wlcomeback,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Sign up with ",
                                      style: subwelcome,
                                    ),
                                    Text(
                                      "Legal Suits",
                                      style: lsblue,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          //client or Attorny
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: g.width * 0.173,
                                vertical: g.height * 0.06),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RawMaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        FocusScope.of(context).unfocus();
                                        client = true;
                                      });
                                    },
                                    child: Text(
                                      "Client",
                                      style: client
                                          ? signupselected
                                          : signupsonselected,
                                    ),
                                  ),
                                  Container(
                                    height: g.height * 0.05,
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                  RawMaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        FocusScope.of(context).unfocus();
                                        client = false;
                                      });
                                    },
                                    child: Text(
                                      "Attorney",
                                      style: client
                                          ? signupsonselected
                                          : signupselected,
                                    ),
                                  ),
                                ]),
                          ),

                          //attorney side
                          //text fields to input email,attorney number, phone, username password and login button
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: g.width * 0.05),
                            child: Form(
                              key: _attorneykey,
                              child: Column(
                                children: [
                                  TxtField(
                                    controller: attusername,
                                    prefix: "Profile",
                                    hint: "Username",
                                    ispass: false,
                                    validate: (String uname) {
                                      if (uname.trim().isEmpty) {
                                        return "Username cannot be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TxtField(
                                    controller: attnum,
                                    prefix: "Work",
                                    hint: "Attorney Number",
                                    ispass: false,
                                    validate: (String atnum) {
                                      if (atnum.trim().isEmpty) {
                                        return "Attorney Number cannot be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  //select type of attorney
                                  Container(
                                    height: g.height * 0.05,
                                    width: g.width * 0.9,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: List.generate(
                                          4,
                                          (i) => Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                    color: cat ==
                                                            g.categories[i]
                                                        ? g.bluebg
                                                        : Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all(
                                                        color: cat ==
                                                                g.categories[i]
                                                            ? Colors.transparent
                                                            : Colors.black)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 4.0,
                                                  ),
                                                  child: RawMaterialButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        cat = g.categories[i];
                                                      });
                                                    },
                                                    child: Text(
                                                      g.categories[i],
                                                      style:
                                                          cat == g.categories[i]
                                                              ? catselected
                                                              : catnotselected,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  TxtField(
                                    controller: attphone,
                                    prefix: "Call",
                                    hint: "Contact Number",
                                    ispass: false,
                                    validate: (String numb) {
                                      if (numb.trim().isEmpty) {
                                        return "Phone cannot be empty";
                                      } else if (!isNumeric(numb.trim()) &&
                                          numb.trim().length != 10) {
                                        return "Invalid Phone Number";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TxtField(
                                    controller: attemail,
                                    prefix: "Message",
                                    hint: "Email",
                                    ispass: false,
                                    validate: (String email) {
                                      if (email.trim().isEmpty) {
                                        return "Email cannot be empty";
                                      } else if (!isEmail(email.trim())) {
                                        return "Invalid Email Id";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TxtField(
                                    controller: attpass,
                                    prefix: "Lock",
                                    hint: "Password",
                                    ispass: true,
                                    validate: (String pass) {
                                      if (pass.trim().isEmpty) {
                                        return "Password cannot be empty";
                                      } else if (pass.trim().length < 8) {
                                        return "Password not Strong";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TxtField(
                                    controller: attpass2,
                                    prefix: "Lock",
                                    hint: "Confirm Password",
                                    ispass: true,
                                    validate: (String pass2) {
                                      if (pass2.trim().isEmpty) {
                                        return "Password cannot be empty";
                                      } else if (pass2.trim() !=
                                          attpass.text.trim()) {
                                        return "Password does not match";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  AuthButton(
                                    onPressed: () {
                                      if (_attorneykey.currentState
                                              .validate() &&
                                          cat != "") {
                                        setState(() {
                                          isload = true;
                                        });
                                        AuthServices()
                                            .register(attemail.text.trim(),
                                                attpass.text.trim())
                                            .then((result) {
                                          if (result is String) {
                                            setState(() {
                                              isload = false;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(result),
                                              ),
                                            );
                                          } else {
                                            DBServices()
                                                .registerUser(
                                                    UserinApp.fromMap({
                                              "uid": result.uid,
                                              "email": result.email,
                                              "password": attpass.text.trim(),
                                              "type": "attorney",
                                            }))
                                                .then((result) {
                                              if (result is String) {
                                                setState(() {
                                                  isload = false;
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(result),
                                                  ),
                                                );
                                              } else {
                                                setState(() {
                                                  isload = false;
                                                });
                                                Navigator.pop(context);
                                                DBServices().registerAttorney(
                                                    Attorney.fromMap({
                                                  "uid": result.uid,
                                                  "username":
                                                      attusername.text.trim(),
                                                  "phoneNo":
                                                      attphone.text.trim(),
                                                  "attorneyNo":
                                                      attnum.text.trim(),
                                                  "category": cat,
                                                  "ratePh": 0,
                                                  "llb": false,
                                                  "llm": false,
                                                }));
                                              }
                                            });
                                          }
                                        });
                                      }
                                    },
                                    buttonName: "Sign up",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //terms and condition
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 50),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    "By continuing you agree to our",
                                    style: tncnonclickable,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Terms of service",
                                        style: tncclickable,
                                      ),
                                      Text(
                                        " & ",
                                        style: tncnonclickable,
                                      ),
                                      Text(
                                        "Privacy Policy",
                                        style: tncclickable,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                ),
              ),
            ),
          );
  }
}
