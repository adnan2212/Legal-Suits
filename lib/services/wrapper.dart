import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:legalsuits/models/attorney.dart';
import 'package:legalsuits/models/user.dart';
import 'package:legalsuits/screens/attorney/home.dart';
import 'package:legalsuits/screens/client/attorney.dart';
import 'package:legalsuits/screens/loading.dart';
import 'package:legalsuits/screens/login.dart';
import 'package:legalsuits/services/dbser.dart';
import 'package:provider/provider.dart';
import 'package:legalsuits/globals.dart' as g;

class Wrapper extends StatefulWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  void init(uid) async {
    g.type = await DBServices().getType(uid);
    if (g.user != null) g.user.type = await DBServices().getType(uid);
    if (g.user != null && g.user.type == "attorney") {
      g.attorney = await DBServices().getattorney(g.user.uid);
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserinApp>(context);
    if (mounted) {
      setState(() {
        g.user = user;
      });
    }

    if (user != null) {
      init(user.uid);
      if (g.type == null) {
        return LoadingPage();
      }
      if (g.user.type == "client") {
        return AllAttorneys();
      }
      if (g.user.type == "attorney") {
        return AttorneyHome();
      }
      return LoadingPage();
    }
    return LoginPage();
  }
}
