import 'package:flutter/material.dart';
import 'package:legalsuits/components/authbutt.dart';
import 'package:legalsuits/components/commons.dart';
import 'package:legalsuits/components/textfield.dart';
import 'package:legalsuits/globals.dart' as g;
import 'package:legalsuits/models/attorney.dart';
import 'package:legalsuits/models/client.dart';
import 'package:legalsuits/screens/client/attorney.dart';
import 'package:legalsuits/screens/loading.dart';
import 'package:legalsuits/screens/signup.dart';
import 'package:legalsuits/services/auth.dart';
import 'package:legalsuits/services/connect.dart';
import 'package:legalsuits/services/dbser.dart';
import 'package:page_transition/page_transition.dart';
import 'package:string_validator/string_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController(text: "");
  TextEditingController pass = TextEditingController(text: "");
  final _key = GlobalKey<FormState>();
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
              resizeToAvoidBottomInset: false,
              body: Container(
                child: ListView(
                  children: [
                    //appbar logo and skip option
                    Padding(
                      padding: EdgeInsets.only(
                        top: g.height * 0.0292,
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
                          Container(
                            width: 40,
                            child: RawMaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: AllAttorneys(),
                                    duration: Duration(milliseconds: 500),
                                    type: PageTransitionType.rightToLeft,
                                  ),
                                );
                              },
                              child: Text(
                                "Skip",
                                style: skip,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //welcome to login screen
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: g.width * 0.093),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Welcome Back!",
                                style: wlcomeback,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Login to continue using ",
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
                    SizedBox(
                      height: 20,
                    ),
                    //text fields to input email,phone password and login button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: g.width * 0.05),
                      child: Form(
                        key: _key,
                        child: Column(
                          children: [
                            TxtField(
                              controller: email,
                              prefix: "Profile",
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
                              controller: pass,
                              prefix: "Lock",
                              hint: "Password",
                              ispass: true,
                              validate: (String pass) {},
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            AuthButton(
                              onPressed: () {
                                setState(() {
                                  isload = true;
                                });
                                if (_key.currentState.validate()) {
                                  var c = DBServices()
                                      .getpassword(email.text.trim())
                                      .then((gda) {
                                    if (gda is String) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(gda),
                                        ),
                                      );
                                      setState(() {
                                        isload = false;
                                      });
                                    } else if (gda is List &&
                                        gda[0] != pass.text.trim()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("Invalid Password"),
                                        ),
                                      );
                                      setState(() {
                                        isload = false;
                                      });
                                    } else {
                                      AuthServices()
                                          .signIn(email.text.trim(),
                                              pass.text.trim())
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
                                          if (mounted)
                                            setState(() {
                                              g.type = value.type;
                                            });
                                          if (g.type == "client") {
                                            DBServices()
                                                .getuser(g.user.uid, "clients")
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
                                                  g.client =
                                                      Client.fromMap(value);
                                                });
                                              }
                                            });
                                          } else {
                                            DBServices()
                                                .getuser(
                                                    g.user.uid, "attorneys")
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
                                                  g.attorney =
                                                      Attorney.fromMap(value);
                                                });
                                              }
                                            });
                                          }
                                          setState(() {
                                            isload = false;
                                          });
                                        }
                                      });
                                    }
                                  });
                                }
                              },
                              buttonName: "Login",
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //alternate for login is oresented here (signup)
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: g.width * 0.093),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "New User? ",
                            style: altblue,
                          ),
                          Text(
                            "Sign up for a new account",
                            style: altblack,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //signup button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: g.width * 0.05),
                      child: AuthButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: MainPage(child: SignupPage()),
                              duration: Duration(milliseconds: 500),
                              type: PageTransitionType.rightToLeftJoined,
                              childCurrent: LoginPage(),
                            ),
                          );
                        },
                        buttonName: "Sign up",
                      ),
                    ),

                    //terms and condition
                    Center(
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
                  ],
                ),
              ),
            ),
          );
  }
}
