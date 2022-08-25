//measurements
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:legalsuits/models/attorney.dart';
import 'package:legalsuits/models/user.dart';
import 'package:legalsuits/models/client.dart';

double width, height;
UserinApp user;
String type;
Client client;
Attorney attorney;
String img = "";

Map<int, Color> color = {
  50: Color.fromRGBO(211, 155, 45, .1),
  100: Color.fromRGBO(211, 155, 45, .2),
  200: Color.fromRGBO(211, 155, 45, .3),
  300: Color.fromRGBO(211, 155, 45, .4),
  400: Color.fromRGBO(211, 155, 45, .5),
  500: Color.fromRGBO(211, 155, 45, .6),
  600: Color.fromRGBO(211, 155, 45, .7),
  700: Color.fromRGBO(211, 155, 45, .8),
  800: Color.fromRGBO(211, 155, 45, .9),
  900: Color.fromRGBO(211, 155, 45, 1),
};

//colors
Color primary = MaterialColor(0xffD39B2D, color);
Color bluebg = Color(0xff295C7A);
Color orangebg = Color(0xffE1BA6F);
Color greyBG = Color(0xffF5F5F5);
Color greyfont = Color(0xff939393);
Color greyfont2 = Color(0xff858585);
Color blackfont = Color(0xff1E1E1E);
Color blackfont2 = Color(0xff000000);
Color bluefont = Color(0xff295C7A);
Color bluefont2 = Color(0xff80ddeb);
Color greyBorder = Color(0xffC4C4C4);
Color white = Colors.white;

//attorney types
List categories = [
  'Criminal',
  'Corporate',
  'Civil',
  'Cyber',
];

//filters for attorneys
List filters = [
  'Low to High',
  'High to Low',
  'LLB',
  'LLM',
];

//filters for listed cases
List filters2 = [
  'Newly Added to Old',
  'High to Low',
];

//random string
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

//default url 
String defaulturi = 'https://st.depositphotos.com/1779253/5140/v/950/depositphotos_51405259-stock-illustration-male-avatar-profile-picture-use.jpg';
