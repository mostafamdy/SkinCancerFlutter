// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/detection.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/sign_up.dart';

import 'Home.dart';
void main() {
  runApp(
      MaterialApp(
        home:
//        MetaInputScreen(DataToServer()),
//        SignUp(),
        Home(),
        theme: themeData,
  ));
}

class Server{
  static String ip="192.168.1.7:5000";
}

final ThemeData themeData = ThemeData(
  canvasColor: Colors.white,
  accentColor:fromHex('#2187ab')
//  Color(0x2187ab)
  //Colors.redAccent,
);

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

