// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/results.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;


import 'package:flutter/services.dart' show FilteringTextInputFormatter, TextInputFormatter, rootBundle;

import 'main.dart';


class User{
  static String email="";
}
class DetectionScreen extends StatelessWidget {
  String email;

  DetectionScreen(this.email);

//  const DetectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User.email=email;
    return ImageInputScreen();
  }
}


class MetaInputScreen extends StatefulWidget {
  DataToServer dataToServer;

  MetaInputScreen(this.dataToServer);

  @override
  _MetaInputScreenState createState() => _MetaInputScreenState(dataToServer);
}

class _MetaInputScreenState extends State<MetaInputScreen> {
  DataToServer dataToServer;

  _MetaInputScreenState(this.dataToServer);

  Widget customSwitch(String text, bool? val, Function onChangeMethod) {
    return Padding(
      padding: const EdgeInsets.only(top: 22.0, left: 16.0,right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width-95,
            child: Row(
              children: [
                Text(text,
                    style:TextStyle(
                        fontSize: text.length>13?18: 20.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        color: val!=null?Colors.black:Colors.grey)),
                val==null?Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: SizedBox(width: 60,child: Text(" (not know)",style: TextStyle(fontSize: 10,color: Colors.grey))),
                )
                    :SizedBox(),
              ],
            ),
          ),
          CupertinoSwitch(
            thumbColor: val==null?Colors.white:Colors.white,
              trackColor: Colors.grey,
              activeColor: val==null?Colors.grey:Colors.blue,
              value: val??false,
              onChanged: (newvalue) {
                onChangeMethod(newvalue);
              })
        ],
      ),
    );
  }

  String regionValue = "ARM";
  // List of items in our dropdown menu
  var regionItems = ['ABDOMEN', 'ARM', 'BACK', 'CHEST', 'EAR', 'FACE', 'FOOT', 'FOREARM', 'HAND', 'LIP', 'NECK', 'NOSE', 'SCALP', 'THIGH'];

  String backmotherValue = "other";
  var back_mother_items = ['BRAZIL', 'FRANCE', 'GERMANY', 'ITALY', 'NETHERLANDS', 'NORWAY', 'None', 'POLAND', 'POMERANIA', 'PORTUGAL', 'SPAIN', 'UNK','other'];

  String genderValue = "prefer not say";
  var genderItems = ['MALE', 'FEMALE', 'prefer not say'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text(
          'Form',
          style: TextStyle(
              fontSize: 30,
//              fontStyle: FontStyle.italic,
              color: Colors.black),
        ),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 4.0,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          customSwitch('grew', dataToServer.grew, (bool val){
            setState(() {
              if (dataToServer.grew==null){
                dataToServer.grew=false;
              }
              else if(dataToServer.grew==false){
                dataToServer.grew=true;
              }
              else{
                dataToServer.grew=null;
              }
            });
          }),
          SizedBox(
            height: 30,
          ),
          customSwitch('bleed',dataToServer.bleed ,(bool val){
          setState(() {
          if (dataToServer.bleed==null){
          dataToServer.bleed=false;
          }
          else if(dataToServer.bleed==false){
          dataToServer.bleed=true;
          }
          else{
          dataToServer.bleed=null;
          }
          });
          }),
          SizedBox(
            height: 30,
          ),
          customSwitch('elevation', dataToServer.elevation,  (bool val){
            setState(() {
              if (dataToServer.elevation==null){
                dataToServer.elevation=false;
              }
              else if(dataToServer.elevation==false){
                dataToServer.elevation=true;
              }
              else{
                dataToServer.elevation=null;
              }
            });
          }),
          SizedBox(
            height: 30,
          ),
          customSwitch('biopsed', dataToServer.biopsed, (bool val){
            setState(() {
              if (dataToServer.biopsed==null){
                dataToServer.biopsed=false;
              }
              else if(dataToServer.biopsed==false){
                dataToServer.biopsed=true;
              }
              else{
                dataToServer.biopsed=null;
              }
            });
          }) ,
          SizedBox(
            height: 30,
          ),
          customSwitch('itch', dataToServer.itch,  (bool val){
            setState(() {
              if (dataToServer.itch==null){
                dataToServer.itch=false;
              }
              else if(dataToServer.itch==false){
                dataToServer.itch=true;
              }
              else{
                dataToServer.itch=null;
              }
            });
          }),
          SizedBox(
            height: 30,
          ),
//          SizedBox(
//            height: 30,
//          ),
          customSwitch('has_sewage_system', dataToServer.has_sewage_system,  (bool val){
            setState(() {
              if (dataToServer.has_sewage_system==null){
                dataToServer.has_sewage_system=false;
              }
              else if(dataToServer.has_sewage_system==false){
                dataToServer.has_sewage_system=true;
              }
              else{
                dataToServer.has_sewage_system=null;
              }
            });
          }),
          SizedBox(
            height: 30,
          ),
          customSwitch('has_piped_water', dataToServer.has_piped_water, (bool val){
            setState(() {
              if (dataToServer.has_piped_water==null){
                dataToServer.has_piped_water=false;
              }
              else if(dataToServer.has_piped_water==false){
                dataToServer.has_piped_water=true;
              }
              else{
                dataToServer.has_piped_water=null;
              }
            });
          }),
          SizedBox(
            height: 30,
          ),
          customSwitch('cancer_history', dataToServer.cancer_history,  (bool val){
            setState(() {
              if (dataToServer.cancer_history==null){
                dataToServer.cancer_history=false;
              }
              else if(dataToServer.cancer_history==false){
                dataToServer.cancer_history=true;
              }
              else{
                dataToServer.cancer_history=null;
              }
            });
          }),
          SizedBox(
            height: 30,
          ),
          customSwitch('skin_cancer_history', dataToServer.skin_cancer_history, (bool val){
            setState(() {
              if (dataToServer.skin_cancer_history==null){
                dataToServer.skin_cancer_history=false;
              }
              else if(dataToServer.skin_cancer_history==false){
                dataToServer.skin_cancer_history=true;
              }
              else{
                dataToServer.skin_cancer_history=null;
              }
            });
          }),
          SizedBox(
            height: 30,
          ),
          customSwitch('pesticide', dataToServer.pesticide,  (bool val){
            setState(() {
              if (dataToServer.pesticide==null){
                dataToServer.pesticide=false;
              }
              else if(dataToServer.pesticide==false){
                dataToServer.pesticide=true;
              }
              else{
                dataToServer.pesticide=null;
              }
            });
          }),
          SizedBox(
            height: 30,
          ),
          customSwitch('drink', dataToServer.drink,  (bool val){
            setState(() {
              if (dataToServer.drink==null){
                dataToServer.drink=false;
              }
              else if(dataToServer.drink==false){
                dataToServer.drink=true;
              }
              else{
                dataToServer.drink=null;
              }
            });
          }),
          SizedBox(
            height: 30,
          ),
          customSwitch('changed', dataToServer.changed,  (bool val){
            setState(() {
              if (dataToServer.changed==null){
                dataToServer.changed=false;
              }
              else if(dataToServer.changed==false){
                dataToServer.changed=true;
              }
              else{
                dataToServer.changed=null;
              }
            });
          }),
          SizedBox(
            height: 30,
          ),
          customSwitch('hurt', dataToServer.hurt,  (bool val){
            setState(() {
              if (dataToServer.hurt==null){
                dataToServer.hurt=false;
              }
              else if(dataToServer.hurt==false){
                dataToServer.hurt=true;
              }
              else{
                dataToServer.hurt=null;
              }
            });
          }),
          SizedBox(
            height: 30,
          ),
          customSwitch('smoke', dataToServer.smoke, (bool val){
            setState(() {
              if (dataToServer.smoke==null){
                dataToServer.smoke=false;
              }
              else if(dataToServer.smoke==false){
                dataToServer.smoke=true;
              }
              else{
                dataToServer.smoke=null;
              }
            });
          }),
//          region
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 22.0, left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("region",
                  style:TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DropdownButton(
                  // Initial Value
                  value: regionValue,
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: regionItems.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged:  (String? newValue){
                    setState(() {
                      regionValue = newValue!;
                      if (newValue=="other"){
                        dataToServer.region="";
                      }else{
                        dataToServer.region=newValue;
                      }
                    });

                  },
                ),
              ],
            ),
          ),
//          back mother
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 22.0, left: 16.0, right: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("background mother",
                  style:TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DropdownButton(
                  // Initial Value
                  value: backmotherValue,
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: back_mother_items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged:  (String? newValue){
                    setState(() {
                      backmotherValue = newValue!;
                      if (newValue=="other"){
                        dataToServer.background_father="";
                      }else{
                        dataToServer.background_father=newValue;
                      }
                    });

                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 22.0, left: 16.0, right: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("gender",
                  style:TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DropdownButton(
                  // Initial Value
                  value: genderValue,//.toLowerCase(),
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: genderItems.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged:  (String? newValue){
                    setState(() {
                      genderValue = newValue!;
                      if (newValue=="prefer not say"){
                        dataToServer.gender="";
                      }else{
                        dataToServer.gender=newValue;
                      }
                    });

                  },
                ),
              ],
            ),
          ),

          SizedBox(
            height: 30,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0,left: 8.0,),
                  child: Container(
//                width: 100,
                    child: TextFormField(
                      onChanged: (val){
                              print(val);
                          dataToServer.age=int.parse(val==""?"-1":val);
                        
                      },
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                            text: newValue.text.replaceAll('.', ','),
                          ),
                        ),
                      ],
                      decoration: InputDecoration(
                        label: Text("age"),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0,left: 12.0,),
                  child: Container(
//                  width: 100,
                      child: TextFormField(
                        onChanged: (val){
                          dataToServer.diameter_1=int.parse(val);
                        },
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          TextInputFormatter.withFunction(
                                (oldValue, newValue) => newValue.copyWith(
                              text: newValue.text.replaceAll('.', ','),
                            ),
                          ),
                        ],
                        decoration: InputDecoration(
                          label: Text("diameter_1"),
                        ),
                      ),
                    ),
                ),
              ),
              Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0,left: 12.0,),
                      child: Container(
//                    width: 100,
                        child: TextFormField(
                          onChanged: (val){
                            dataToServer.diameter_2=int.parse(val);
                          },
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            TextInputFormatter.withFunction(
                                  (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],
                          decoration: InputDecoration(
                            label: Text("diameter_2"),
                          ),
                        ),
              ),
                    ),
                  ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0,left: 12.0,),
                  child: Container(
                    child: TextFormField(
                      onChanged: (newData){
                        dataToServer.fitspatrick=int.tryParse(newData);
                        print(dataToServer.fitspatrick);
                        },
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                            text: newValue.text.replaceAll('.', ','),
                          ),
                        ),
                      ],
                      decoration: InputDecoration(
                        label: Text("fitspatrick"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 70,),
          //send
          Center(
            child: RaisedButton(
              child: Text(
                "Send",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                var url=Uri.http(Server.ip,"/");
//                print(url.path);
//                print(jsonEncode(dataToServer.toJson()));
                http.post(
                    url,
                    headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                    body:jsonEncode(dataToServer.toJson())
                ).then((value) {
                  print("post data");
                  print(jsonEncode(dataToServer.toJson()));
                  print("response");
                  print(value.body);
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Result(value.body)));
                });
              },
              color: Theme.of(context).accentColor,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(200))),
              padding:
              const EdgeInsets.symmetric(horizontal: 90.0, vertical: 5.0),
              splashColor: Colors.grey,
            ),
          ),
        ],
      ),
    );

  }
}

class ImageInputScreen extends StatefulWidget {
  @override
  _ImageInputScreenState createState() => _ImageInputScreenState();
}

class _ImageInputScreenState extends State<ImageInputScreen> {

  late File file;
  final ImagePicker _picker = ImagePicker();

  Future<void> imageCamera() async{
    await _picker.pickImage(source: ImageSource.camera).then((value) {
      setState(() {
        print("image camera");
        file=File(value!.path);
      });
    });
  }

  Future<void> imageGallery() async {
    await _picker.pickImage(source: ImageSource.gallery).then((value) {
      setState(() {
        var h= value!.path;
        print(h);
        print("image gallery");
        file=File(value!.path);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text(
          'menu',
          style: TextStyle(
              fontSize: 30,
              //fontStyle: FontStyle.italic,
              color: Colors.black),
        ),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 1.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
//            from camera
            MaterialButton(

              onPressed: () {
                imageCamera().then((value)  {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageShowScreen(file)));
                });
              },
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                        radius: 100,
                        child:
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child:  Image(
                            image: AssetImage('images/camera.png'),
                          ),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(

                      "Camera Roll",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 80,
            ),
//            from phone
            RaisedButton(
              child: Text(
                "from phone",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: ()  {
                 imageGallery().then((value) {

                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageShowScreen(file)));
                });

              },
              color: Theme.of(context).accentColor,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(200))),
              padding: const EdgeInsets.symmetric(
                  horizontal: 90.0, vertical: 5.0),
              splashColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class ImageShowScreen extends StatefulWidget {
  File image;
  ImageShowScreen(this.image);

  @override
  _ImageShowScreenState createState() => _ImageShowScreenState();
}

class _ImageShowScreenState extends State<ImageShowScreen> {
  DataToServer dataToServer=DataToServer();
  @override
  Widget build(BuildContext context) {
//    print("error ");
//    print(widget.image);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'image',
          style: TextStyle(
              fontSize: 30,
              //fontStyle: FontStyle.italic,
              color: Colors.black),
        ),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 5.0,
        leading:
          BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.file(widget.image,width: 200,height: 200,),
            SizedBox(
              height: 50,
            ),
//            clear
            SizedBox(
              width: 200,
              height: 50,
              child: RaisedButton(
                child: Text(
                  "Clear",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Theme.of(context).accentColor,
                textColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(200))),
//                padding: const EdgeInsets.symmetric(horizontal: 90.0, vertical: 5.0),
                splashColor: Colors.grey,
              ),
            ),

            SizedBox(
              height: 20,
            ),

            SizedBox(
              width: 200,
              height: 50,
              child: RaisedButton(
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 20),
                ),

                onPressed: () {
                    SkinImage.img=widget.image;

                    widget.image.readAsBytes().then((value) {

                    dataToServer.img64=base64Encode(value);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => MetaInputScreen(dataToServer)));
                  });
                },
                color:Theme.of(context).accentColor,
                textColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(200))),
//                padding: const EdgeInsets.symmetric(horizontal: 90.0, vertical: 5.0),
                splashColor: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SkinImage{
  static late File img;
}

class DataToServer{
   String img64="";
   bool? smoke;
   bool? drink;
   String? background_father;
   String? background_mother;
   int? age;
   bool? pesticide;

   String? gender;
   bool? skin_cancer_history;
   bool? cancer_history;
   bool? has_piped_water;
   bool? has_sewage_system;
   int? fitspatrick;
   String? region="ARM";
   int? diameter_1;
   int? diameter_2;
   bool? itch;
   bool? grew;
   bool? hurt;
   bool? changed;
   bool? bleed;
   bool? elevation;
   bool? biopsed;
   String email="";
   Map<String, dynamic> toJson() => {
     'smoke':smoke==null?"":smoke.toString(),
     'drink':drink==null?"":drink.toString(),
     'background_father':background_father??"",
     'background_mother':background_mother??"",
     'age':age==null?"":age.toString(),
     'pesticide':pesticide==null?"":pesticide.toString(),
     'gender':gender??"",
     'skin_cancer_history':skin_cancer_history==null?"":skin_cancer_history.toString(),
     'cancer_history':cancer_history==null?"":cancer_history.toString(),
     'has_piped_water':has_piped_water==null?"":has_piped_water.toString(),
     'has_sewage_system':has_sewage_system==null?"":has_sewage_system.toString(),
     'fitspatrick':fitspatrick==null?"":fitspatrick.toString(),
     'region':region??"",
     'diameter_1':diameter_1==null?"":diameter_1.toString(),
     'diameter_2':diameter_2==null?"":diameter_2.toString(),
     'itch':itch==null?"":itch.toString(),
     'grew':grew==null?"":grew.toString(),
     'hurt':hurt==null?"":hurt.toString(),
     'changed':changed==null?"":changed.toString(),
     'bleed':bleed==null?"":bleed.toString(),
     'elevation':elevation==null?"":elevation.toString(),
     'imagebase64':img64,
     'biopsed':biopsed==null?"":biopsed.toString(),
     'email':email
   };
}




