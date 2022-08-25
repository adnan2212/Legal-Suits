import 'package:flutter/material.dart';

class Iconcard extends StatelessWidget {
  const Iconcard({Key key, this.imagename}) : super(key: key);
  final String imagename;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      width: 18,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/$imagename.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
