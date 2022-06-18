
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_app/detection.dart';
import 'package:flutter_app/sign_up.dart';

import 'login.dart';

Color fromHex(String hexString) {
final buffer = StringBuffer();
if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
buffer.write(hexString.replaceFirst('#', ''));
return Color(int.parse(buffer.toString(), radix: 16));
}

class Home extends StatelessWidget {
  
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color col=Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: col,
        title:const Text(
          'Cancer Detection ',
          style: TextStyle(
              fontSize: 30,
              //fontStyle: FontStyle.italic,
              color: Colors.black),
        ),
      ),

      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          const Image(
            image: AssetImage('images/doctor.webp'),
          ),

          const SizedBox(
            height: 50,
          ),
          //log in
          Align(
            child: SizedBox(
                width: 200, // <-- Your width
                height: 50, // <-- Your height
                child: RaisedButton(
                  child: const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => login()),
                    );
                  },
                  color: col,
                  textColor: Colors.black,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                  splashColor: Colors.grey,
                ),
              ),
          ),
          SizedBox(
            height: 20,
          ),


          //create
          Align(
            child: SizedBox(
              width: 200,
              height: 50,
              child: RaisedButton(
                child:const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 20),
                ),
                //
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                shape:const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                color: col,
                textColor: Colors.black,
                splashColor: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          //continue without login
          Align(
            child: TextButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.resolveWith((states) => 5),
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white70),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetectionScreen("")),
                );
              },
            child: Text("continue without login",
              style:  TextStyle(color: col,fontSize: 16),
            ),
            ),
//            child: RaisedButton(
//              child:const Text(
//                "continue without login",
//                style: TextStyle(fontSize: 20),
//              ),
//              //
//              onPressed: () {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => DetectionScreen()),
//                );
//              },
//              shape:const RoundedRectangleBorder(
//                  borderRadius: BorderRadius.all(Radius.circular(200))),
//              color: Colors.redAccent,
//              textColor: Colors.black,
//              padding: EdgeInsets.only(right: 25,left: 25),
////              padding: const EdgeInsets.symmetric(horizontal: 90.0, vertical: 5.0),
//              splashColor: Colors.grey,
//            ),
          ),
        ],
      ),
    );
  }
}

