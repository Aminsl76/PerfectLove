import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfect_love_app/network/doctorApi.dart';
import 'package:perfect_love_app/screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocDetailScreen extends StatefulWidget {
  int docIndex;

  @override
  _DocDetailScreenState createState() => _DocDetailScreenState();
  DocDetailScreen({this.docIndex});
}

class _DocDetailScreenState extends State<DocDetailScreen> {

  List<String> freeTimes = List<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(206, 147, 216, 1.0),
        title: Text(
          "ارتباط با مشاور",
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20.0, bottom: 40.0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImageWidget(
              imagePath: 'assets/images/profile_avatar_pic.png',
              imageHeight: 100.0,
              imageWidth: 100.0,
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(right: 15.0, left: 15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        "نام : ",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "رز محمدی",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        "تخصص : ",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "روانشناس",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        "محل مطب :",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black
                        ),
                      ),
                      Text(
                        "ساری - ساختمان شهریار 3",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 16.0
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            RaisedButton(
              onPressed: () async{
                var docPref = await SharedPreferences.getInstance();
                String token = docPref.getString("token");
                List<String> doctorFreeTimes = await DoctorApiCall().doctorsFreeTimes(token, widget.docIndex.toString());
                setState(() {
                  freeTimes = doctorFreeTimes;
                });
                _visitTimeReserve(context);
              },
              elevation: 3.0,
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
              color: Colors.white,
              child: Text(
                "رزرو وقت مشاوره",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
              ),
            )
          ],
        ),
      ),
    );
  }

  void _visitTimeReserve(context) {
    showModalBottomSheet(context: context, builder: (BuildContext bCont) {
      return Container(
        height: MediaQuery
            .of(context)
            .size
            .height * .60,
        child: Padding(
          padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Color.fromRGBO(255, 196, 255, 1.0),
                padding: EdgeInsets.only(left: 15.0,right: 15.0),
                child: Row(
                  children: [
                    Text(
                      "99/9/9",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          color: Colors.black
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      freeTimes[0],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 17.0
                      ),
                    ),
                    Spacer(),
                    FlatButton(
                        onPressed: () async{
                          var reservePref = await SharedPreferences.getInstance();
                          String token = reservePref.getString('token');
                          bool appointStatus = await DoctorApiCall().addAppointment(widget.docIndex.toString(), '2021-01-01', '0', token);
                          if(appointStatus){
                            print('Done');
                          } else
                            print("Nope");
                        },
                        color: Color.fromRGBO(206, 147, 216, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        child:Text(
                          "رزرو",
                          style: TextStyle(
                            fontSize: 18.0,
                            color:Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        )
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                color: Color.fromRGBO(255, 196, 255, 1.0),
                padding: EdgeInsets.only(left: 15.0,right: 15.0),
                child: Row(
                  children: [
                    Text(
                      "99/9/9",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          color: Colors.black
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      freeTimes[1],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 17.0
                      ),
                    ),
                    Spacer(),
                    FlatButton(
                        onPressed: () {},
                        color: Color.fromRGBO(206, 147, 216, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        child:Text(
                          "رزرو",
                          style: TextStyle(
                              fontSize: 18.0,
                              color:Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        )
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                color: Color.fromRGBO(255, 196, 255, 1.0),
                padding: EdgeInsets.only(left: 15.0,right: 15.0),
                child: Row(
                  children: [
                    Text(
                      "99/9/9",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          color: Colors.black
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      freeTimes[2],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 17.0
                      ),
                    ),
                    Spacer(),
                    FlatButton(
                        onPressed: () {},
                        color: Color.fromRGBO(206, 147, 216, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        child:Text(
                          "رزرو",
                          style: TextStyle(
                              fontSize: 18.0,
                              color:Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        )
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                color: Color.fromRGBO(255, 196, 255, 1.0),
                padding: EdgeInsets.only(left: 15.0,right: 15.0),
                child: Row(
                  children: [
                    Text(
                      "99/9/9",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          color: Colors.black
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      freeTimes[3],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 17.0
                      ),
                    ),
                    Spacer(),
                    FlatButton(
                        onPressed: () {},
                        color: Color.fromRGBO(206, 147, 216, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        child:Text(
                          "رزرو",
                          style: TextStyle(
                              fontSize: 18.0,
                              color:Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        )
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
