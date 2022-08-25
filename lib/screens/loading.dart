import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:legalsuits/globals.dart' as g;

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    g.width = MediaQuery.of(context).size.width;
    g.height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            SpinKitCircle(
              color: g.primary,
              size: 100.0,
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
