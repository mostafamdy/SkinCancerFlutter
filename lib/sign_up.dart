// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detection.dart';
import 'main.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String userName;
  late String email;
  late String pass;
  String response="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create Account',
          style: TextStyle(fontSize: 20,
//              fontStyle: FontStyle.italic,
              color: Colors.black),),

        backgroundColor: Theme.of(context).accentColor,
        elevation: 2.0,
        leading: Container(),
        actions: [
          IconButton(icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 90,),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  onChanged: (String val){
                    userName=val;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                    //hintText: 'Enter your name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  onChanged: (String val){
                    email=val;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                   // hintText: 'Enter your email',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  onChanged: (String val){
                    pass=val;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    //hintText: 'Enter password',
                  ),
                ),
              ),
              Text(response,style: TextStyle(fontSize: 12,color: Colors.redAccent),),
              SizedBox(height: 50,),
              Align(
                child: SizedBox(
                  width: 170,
                  height: 35,
                  child: RaisedButton(
                    child: Text("Confirm", style: TextStyle(fontSize: 20),),
                    onPressed: () {
                      // send to server
                      print("user name ${userName}");
                      print("email ${email}");
                      print("pass ${pass}");
                      var url=Uri.http(Server.ip,"/createAccount");
                      http.post(
                          url,
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body:jsonEncode({"email":email,"password":pass,"name":userName})
                      ).then((value) {
                        print("response");
                        print(value.body);
                        if (value.body=="this email used before"){
                          setState(() {
                            response=value.body;
                          });
                        }else{
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => DetectionScreen(email)),
                                (route) => false,
                          );
                        };
                      });
                    },
                    color: Theme.of(context).accentColor,
                    textColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
//                  padding: const EdgeInsets.symmetric(horizontal: 90.0, vertical: 5.0),
                    splashColor: Colors.grey,
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

