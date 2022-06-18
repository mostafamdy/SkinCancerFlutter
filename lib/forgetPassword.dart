// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/main.dart';

import 'detection.dart';
import 'package:http/http.dart' as http;
class ForgetPassword extends StatefulWidget {
  String email;

  ForgetPassword(this.email);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String pass="";
  String confirmPass="";
  bool showText=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Forget Password',
          style: TextStyle(fontSize: 20,
              //fontStyle: FontStyle.italic,
          color: Colors.black),),

        backgroundColor: Theme
            .of(context)
            .accentColor,
        elevation: 2.0,
//        actions: [
//          IconButton(icon: Icon(Icons.close),
//            onPressed: () {
//              Navigator.pop(context);
//            },
//          ),
//        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 90,),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  onChanged: (va){
                    pass=va;
                    if(pass!=confirmPass){
                      setState(() {
                        showText=true;
                      });
                    }else{
                      setState(() {
                        showText=false;
                      });
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'New password',
                    hintText: 'Enter New password',
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  obscureText: true,
                  onChanged: (va){
                    confirmPass=va;
                    if(pass!=confirmPass){
                      setState(() {
                        showText=true;
                      });
                    }else{
                      setState(() {
                        showText=false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: ' confirm Password',
                    hintText: 'confirm Password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0,bottom: 5,left: 20),
                child: Text(showText?"*not match":"",style: TextStyle(color: Colors.redAccent),),
              ),
              Align(
                child: RaisedButton(

                  child: Text("Confirm", style: TextStyle(fontSize: 20),),
                  onPressed: () {
                    if(!showText){
                        var url = Uri.http(Server.ip, "/updatePass");
                        http.post(
                        url,
                        headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode({"email": widget.email, "password": pass})
                        ).then((value) {
                        print(value.body);
                        if (value.body == "it's ok ") {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgetPassword(widget.email)),);
                        }});
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => DetectionScreen(widget.email)),
                          (route) => false,
                    );
                    }
                  },
                  color: Theme.of(context).accentColor,
                  textColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(200))
                  ),
                  padding: const
                  EdgeInsets.symmetric(horizontal: 90.0, vertical: 5.0),
                  splashColor: Colors.grey,
                ),
              ),
              SizedBox(height: 50,),

            ],
          ),
        ),
      ),
    );
  }
}


//class ForgetScreen1
class ForgetScreen1 extends StatefulWidget {
  @override
  _ForgetScreen1State createState() => _ForgetScreen1State();
}

class _ForgetScreen1State extends State<ForgetScreen1> {
  String email="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Forget Password',
          style: TextStyle(fontSize: 20,
//              fontStyle: FontStyle.italic,
              color: Colors.black),)),

        backgroundColor: Theme
            .of(context)
            .accentColor,
        elevation: 2.0,
//        actions: [
//          IconButton(icon: Icon(Icons.close),
//            onPressed: () {
//              Navigator.pop(context);
//            },
//          ),
//        ],
      ),
      body:
      Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              SizedBox(height: 90,),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  onChanged: (em){email=em;},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E_mail',
                    hintText: 'Enter E_mail',
                  ),
                ),
              ),

              RaisedButton(
                child: Text("Send", style: TextStyle(fontSize: 20),),
                onPressed: () {
                  var url=Uri.http(Server.ip,"/forgetPass");
                  http.post(
                  url,
                  headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body:jsonEncode({"email":email})
                  ).then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmailCode(email)),

                    );
                  });
                },
                color: Theme.of(context).accentColor,
                textColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(200))
                ),
                padding: const
                EdgeInsets.symmetric(horizontal: 90.0, vertical: 5.0),
                splashColor: Colors.grey,
              ),
              SizedBox(
                height: 50,
              ),

            ],
          ),
        ),
      ),
    );
  }
}




//class EmailCode
class EmailCode extends StatefulWidget {
  String email;

  EmailCode(this.email);

  @override
  _EmailCodeState createState() => _EmailCodeState();
}

class _EmailCodeState extends State<EmailCode> {
  int d1=-1;
  int d2=-1;
  int d3=-1;
  int d4=-1;

  bool activeButton=false;

  String response="";


  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width/6;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: SizedBox(),
        actions: [
          IconButton(icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("check your email"),
            Padding(
              padding: const EdgeInsets.only(top: 20.0,right: 10,left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  height: 80,
                  width: width,
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      TextInputFormatter.withFunction(
                      (oldValue, newValue) {
                    if (newValue.text.length>1){
                      return oldValue.copyWith(text: oldValue.text);
                    }
                    return newValue.copyWith(text: newValue.text.replaceAll('.', ','),);
                  }
              ),
                    ],
                    onChanged: (d11){
                      if (d11.length>1){
                        print("len d11 "+d11.length.toString());
                        print("d11 "+d11);
                      }
                      else if(d11.length==0){
                        d1=-1;
                      }
                      else{
                        d1=int.parse(d11);
                        if(d1!=-1&&d2!=-1 &&d3!=-1&&d4!=-1){
                          setState(() {
                            activeButton=true;
                          });

                        }
                      }


                      },
                    decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54))),
                  ),
                ),
                Container(
                  height: 80,
                  width: width,
                  child: TextField(

                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      TextInputFormatter.withFunction(
                            (oldValue, newValue) {
                              if (newValue.text.length>1){
                                return oldValue.copyWith(text: oldValue.text);
                              }
                              return newValue.copyWith(text: newValue.text.replaceAll('.', ','),);
                            }
                      ),

                    ],
                    onChanged: (d22){
                      if (d22.length>1){
                      print("len d11 "+d22.length.toString());
                      print("d11 "+d22);
                    }
                    else if(d22.length==0){
                      d2=-1;
                    }
                    else{
                      d2=int.parse(d22);
                      if(d1!=-1&&d2!=-1 &&d3!=-1&&d4!=-1){
                        setState(() {
                          activeButton=true;
                        });

                      }
                    }
                    },
                    decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54))),
                  ),
                ),
                Container(
                  height: 80,
                  width: width,
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      TextInputFormatter.withFunction(
                              (oldValue, newValue) {
                            if (newValue.text.length>1){
                              return oldValue.copyWith(text: oldValue.text);
                            }
                            return newValue.copyWith(text: newValue.text.replaceAll('.', ','),);
                          }
                      ),
                    ],
                    onChanged: (d33){
                      if (d33.length>1){
                      print("len d11 "+d33.length.toString());
                      print("d11 "+d33);
                    }
                    else if(d33.length==0){
                      d3=-1;
                    }
                    else{
                      d3=int.parse(d33);
                      if(d1!=-1&&d2!=-1 &&d3!=-1&&d4!=-1){
                        setState(() {
                          activeButton=true;
                        });

                      }
                    }
                    },
                    decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54))),
                  ),
                ),
                Container(
                  height: 80,
                  width: width,
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      TextInputFormatter.withFunction(
                              (oldValue, newValue) {
                            if (newValue.text.length>1){
                              return oldValue.copyWith(text: oldValue.text);
                            }
                            return newValue.copyWith(text: newValue.text.replaceAll('.', ','),);
                          }
                      ),
                    ],
                    onChanged: (d44){
                      if (d44.length>1){
                        print("len d11 "+d44.length.toString());
                        print("d11 "+d44);
                      }
                      else if(d44.length==0){
                        d4=-1;
                      }
                      else{
                        d4=int.parse(d44);
                        if(d1!=-1&&d2!=-1 &&d3!=-1&&d4!=-1){
                          setState(() {
                            activeButton=true;
                          });

                        }
                      }


                    },
                    decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54))),
                  ),
                ),
              ],),
            ),
         Text(response,style: TextStyle(color: Colors.redAccent),),
         RaisedButton(
           color: activeButton?Theme.of(context).accentColor:Colors.grey,
          onPressed: () {
            if (activeButton) {
              String code = d1.toString() + d2.toString() + d3.toString() + d4.toString();
              var url = Uri.http(Server.ip, "/passCode");
              http.post(
                  url,
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode({"email": widget.email, "code": code})
              ).then((value) {
                print(value.body);
                if (value.body == "it's ok ") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgetPassword(widget.email)),);
                }
                else{
                  if(value.body=="wrong code"){
                    response=value.body;
                  }else{
                    response="something went wrong try again";
                  }

                }
              }
              );
            }
          },
          child: Text("send", style: TextStyle(fontSize: 15,color: Colors.white),),
        )
          ],
        ),
      ),
    );
  }
}
