// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/forgetPassword.dart';
import 'package:flutter_app/main.dart';
import 'package:http/http.dart' as http;
import 'detection.dart';
import 'sign_up.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  String email="";
  String pass="";

  String response="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title:const Text(
          'login',
          style: TextStyle(
              fontSize: 30,
              //fontStyle: FontStyle.italic,
              color: Colors.black),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 2.0,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 90,
              ),

              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  onChanged: (String val){
                    email=val;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'email',
                    hintText: 'Enter Your email',
                  ),
                ),
              ),

               Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  onChanged: (String val){
                    pass=val;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter Password',
                  ),
                ),
              ),

              SizedBox(height: 5,),
              Text(response,style: TextStyle(fontSize: 12,color: Colors.redAccent),),
              SizedBox(height: 10,),
              //sign in
              Align(
                child: RaisedButton(
                  child: const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    var url=Uri.http(Server.ip,"/login");
                    http.post(
                        url,
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body:jsonEncode({"email":email,"password":pass})
                    ).then((value) {
                      print("response");
                      print(value.body);
                      if (value.body=="wrong email"){
                        setState(() {
                          response=value.body;
                        });
                      }
                      else if (value.body=="wrong pass"){
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
                  color:Theme.of(context).accentColor,
                  textColor: Colors.black,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(200))),
                  padding: const EdgeInsets.symmetric(horizontal: 90.0, vertical: 5.0),
                  splashColor: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 40,
              ),

              // forget password
              MaterialButton(
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>ForgetScreen1()));
                },
                child: const Text(
                  "Forgot your password",
                  style:  TextStyle(fontSize: 15,color: Colors.black54),
                ),
              ),

              const SizedBox(
                height: 5,
              ),

              // create account
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                child: const Text(
                  "New Account",
                  style: TextStyle(fontSize: 15,color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


