import 'package:flutter/material.dart';
import 'package:legalsuits/components/cards.dart';
import 'package:legalsuits/components/commons.dart';
import 'package:legalsuits/globals.dart' as g;
import 'package:legalsuits/models/contact.dart';
import 'package:legalsuits/screens/attorney/fullcontact.dart';
import 'package:legalsuits/screens/loading.dart';
import 'package:legalsuits/services/dbser.dart';
import 'package:page_transition/page_transition.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts;

  getdata() async {
    contacts = await DBServices().getcontacts();
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
          //title of the page
          Padding(
            padding: EdgeInsets.symmetric(horizontal: g.width * 0.045),
            child: Row(
              children: [
                Text(
                  "Contact Submission",
                  style: pagetitle,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //List of all cases
          Expanded(
            child: contacts == null
                ? LoadingPage()
                : contacts.isEmpty
                    ? Center(child: Text("No data"))
                    : ListView(
                        children: List.generate(contacts.length,
                            (i) => ContactCard(contact: contacts[i])),
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
