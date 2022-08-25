import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:legalsuits/components/authbutt.dart';
import 'package:legalsuits/components/commons.dart';
import 'package:legalsuits/components/textfield.dart';
import 'package:legalsuits/globals.dart' as g;
import 'package:legalsuits/screens/loading.dart';
import 'package:legalsuits/services/auth.dart';
import 'package:legalsuits/services/dbser.dart';
import 'package:legalsuits/services/storage.dart';
import 'package:string_validator/string_validator.dart';

class MyProfileAttorney extends StatefulWidget {
  const MyProfileAttorney({Key key}) : super(key: key);

  @override
  _MyProfileAttorneyState createState() => _MyProfileAttorneyState();
}

class _MyProfileAttorneyState extends State<MyProfileAttorney> {
  bool llb = g.attorney.llb;
  bool llm = g.attorney.llm;
  String cat = g.attorney.category;
  TextEditingController cliusername =
      TextEditingController(text: g.attorney.username);
  TextEditingController cliphone =
      TextEditingController(text: g.attorney.phoneNo);
  TextEditingController clirate =
      TextEditingController(text: g.attorney.ratePh.toString());
  TextEditingController cliemail = TextEditingController(text: g.user.email);
  TextEditingController clibio = TextEditingController(text: g.attorney.bio);
  final _key = GlobalKey<FormState>();
  bool isload = false;

  @override
  Widget build(BuildContext context) {
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
              body: Form(
                key: _key,
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: g.width * 0.05,
                          top: g.height * 0.04,
                          bottom: g.height * 0.05),
                      child: RawMaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        //page title
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                              color: g.greyBorder,
                            ),
                            Text("Account", style: pagetitle2),
                          ],
                        ),
                      ),
                    ),
                    //profile photo and change option
                    Container(
                      height: g.height * 0.175,
                      width: g.height * 0.175,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image:
                              NetworkImage(g.img == "" ? g.defaulturi : g.img),
                        ),
                      ),
                    ),
                    RawMaterialButton(
                      onPressed: () async {
                        setState(() {
                          isload = true;
                        });
                        final result = await FilePicker.platform.pickFiles(
                          allowCompression: false,
                          allowMultiple: false,
                          allowedExtensions: ["png", "jpg", "jpeg"],
                          type: FileType.custom,
                        );

                        if (result == null) {
                          setState(() {
                            isload = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("No file selected"),
                            ),
                          );
                          return;
                        }
                        final path = result.files.single.path;
                        final name = g.user.uid;

                        await Storage()
                            .uploadfile("profile", name, path)
                            .then((value) {
                          print("done");
                          FirebaseStorage.instance
                              .ref("profile/${g.attorney.uid}")
                              .getDownloadURL()
                              .then((value) {
                            setState(() {
                              g.img = value;
                            });
                          });
                          setState(() {
                            isload = false;
                          });
                        });
                      },
                      child: Text(
                        "Change Picture",
                        style: tncnonclickable,
                      ),
                    ),
                    SizedBox(
                      height: g.height * 0.05,
                    ),
                    //name field
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: g.width * 0.0966),
                      child: TxtField(
                        controller: cliusername,
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //is the attorney LLB?
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: g.width * 0.0966),
                      child: Row(
                        children: [
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                llb = !llb;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: llb
                                            ? Colors.transparent
                                            : g.blackfont2),
                                    color: llb ? g.bluebg : Colors.transparent,
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 13,
                                ),
                                Text(
                                  "LLB",
                                  style: filtertext,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                    //is attorney LLM
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: g.width * 0.0966),
                      child: Row(
                        children: [
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                llm = !llm;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: llm
                                            ? Colors.transparent
                                            : g.blackfont2),
                                    color: llm ? g.bluebg : Colors.transparent,
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 13,
                                ),
                                Text(
                                  "LLM",
                                  style: filtertext,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: g.height * 0.03,
                    ),
                    //Categories
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: g.width * 0.0966),
                      child: Container(
                        height: g.height * 0.065,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            4,
                            (i) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: cat == g.categories[i]
                                      ? g.bluebg
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                      color: cat == g.categories[i]
                                          ? Colors.transparent
                                          : Colors.black)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
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
                                    style: cat == g.categories[i]
                                        ? catAttPageuselected
                                        : catAttPageunselected,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: g.height * 0.05,
                    ),
                    //hourly rate
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: g.width * 0.0966),
                      child: TxtField(
                        controller: clirate,
                        prefix: "dollar",
                        hint: "Hourly Rate",
                        ispass: false,
                        validate: (String numb) {
                          if (numb.trim().isEmpty) {
                            return "Rate cannot be empty";
                          } else if (!isNumeric(numb.trim()) &&
                              numb.trim().length != 10) {
                            return "Invalid Rate";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //contact number
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: g.width * 0.0966),
                      child: TxtField(
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //email
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: g.width * 0.0966),
                      child: TxtField(
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
                    ),
                    SizedBox(
                      height: g.height * 0.03,
                    ),
                    //bio
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: g.width * 0.0966),
                      child: AddNewFormField(
                        lines: 5,
                        ctrl: clibio,
                        hintText: "Bio",
                        validate: (String bio) {
                          if (bio.trim().isEmpty) {
                            return "Bio cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: g.height * 0.08,
                    ),
                    // add case pricesheet and portfolio
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AttorneyButton1(
                          buttonname: "Case Price Sheet",
                          onpressed: () async {
                            setState(() {
                              isload = true;
                            });
                            final result = await FilePicker.platform.pickFiles(
                              allowCompression: false,
                              allowMultiple: false,
                              allowedExtensions: ["pdf"],
                              type: FileType.custom,
                            );

                            if (result == null) {
                              setState(() {
                                isload = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("No file selected"),
                                ),
                              );
                              return;
                            }
                            final path = result.files.single.path;
                            final name = g.user.uid;

                            Storage()
                                .uploadfile("pricesheet", name, path)
                                .then((value) {
                              print("done");
                              setState(() {
                                isload = false;
                              });
                            });
                            setState(() {
                              isload = false;
                            });
                          },
                        ),
                        AttorneyButton1(
                          buttonname: "Case Portfolio",
                          onpressed: () async {
                            setState(() {
                              isload = true;
                            });
                            final result = await FilePicker.platform.pickFiles(
                              allowCompression: false,
                              allowMultiple: false,
                              allowedExtensions: ["pdf"],
                              type: FileType.custom,
                            );

                            if (result == null) {
                              setState(() {
                                isload = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("No file selected"),
                                ),
                              );
                              return;
                            }
                            final path = result.files.single.path;
                            final name = g.user.uid;

                            Storage()
                                .uploadfile("portfolio", name, path)
                                .then((value) {
                              print("done");
                              setState(() {
                                isload = false;
                              });
                            });
                            setState(() {
                              isload = false;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: g.height * 0.04,
                    ),
                    //save button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RawMaterialButton(
                          onPressed: () async {
                            if (_key.currentState.validate()) {
                              setState(() {
                                isload = true;
                              });
                              g.attorney.category = cat;
                              g.attorney.llb = llb;
                              g.attorney.llm = llm;
                              g.attorney.phoneNo = cliphone.text.trim();
                              g.attorney.ratePh =
                                  int.parse(clirate.text.trim());
                              g.attorney.username = cliusername.text.trim();
                              g.attorney.bio = clibio.text.trim();
                              setState(() {
                                DBServices()
                                    .updateattorney(g.attorney)
                                    .then((value) {
                                  if (value is String) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(value),
                                      ),
                                    );
                                    setState(() {
                                      isload = false;
                                    });
                                    Navigator.pop(context);
                                  } else {
                                    setState(() {
                                      isload = false;
                                    });
                                    Navigator.pop(context);
                                  }
                                });
                              });
                            }
                          },
                          child: Container(
                            width: g.width * 0.7,
                            height: 60,
                            decoration: BoxDecoration(
                              color: g.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Save",
                                style: buttontext,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: g.height * 0.04,
                    ),
                    //save button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RawMaterialButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            await AuthServices().signout();
                          },
                          child: Container(
                            width: g.width * 0.7,
                            height: 60,
                            decoration: BoxDecoration(
                              color: g.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Sign Out",
                                style: buttontext,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: g.height * 0.04,
                    ),
                    //terms and condition
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
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
