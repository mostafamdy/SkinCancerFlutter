//Results
// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/detection.dart';

class Result extends StatefulWidget {
  String dia;
  Result(this.dia);
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  File img=SkinImage.img;
  List<String> diagList=['ACK','BCC','MEL','NEV','SCC','SEK'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        title: Text(
          'Results',
          style: TextStyle(
          fontSize: 30,
          //fontStyle: FontStyle.italic,
          color: Colors.black),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
//            Navigator.push(
//                context, MaterialPageRoute(builder: (context) =>FormScreen()));
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 3.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.file(img,width: 300,height: 300,),
            SizedBox(
              height: 90,
            ),
            Text(
                diagList.contains(widget.dia)
                    ?  widget.dia
                    : "can't detect it "
            ),
            RaisedButton(
              child: Text(
                "Menu",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) => DetectionScreen(User.email),
                  ),
                      (route) => false,
                );
              },
              color: Theme.of(context).accentColor,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(200))),
              padding:
                  const EdgeInsets.symmetric(horizontal: 90.0, vertical: 5.0),
              splashColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
