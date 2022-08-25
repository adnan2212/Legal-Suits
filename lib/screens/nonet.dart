import 'package:flutter/material.dart';
import 'package:legalsuits/components/commons.dart';

class NoNetwork extends StatefulWidget {
  const NoNetwork({Key key}) : super(key: key);

  @override
  _NoNetworkState createState() => _NoNetworkState();
}

class _NoNetworkState extends State<NoNetwork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No Internet", style: filtertext),
            SizedBox(
              height: 20,
            ),
            Icon(Icons.wifi_off),
          ],
        ),
      ),
    );
  }
}
