import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfect_love_app/screens/profile_screen.dart';
import 'package:perfect_love_app/screens/test_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonInfoScreen extends StatefulWidget {
  @override
  _PersonInfoScreenState createState() => _PersonInfoScreenState();
}

class _PersonInfoScreenState extends State<PersonInfoScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(206, 147, 216, 1.0),
        title: Text(
          "اطلاعات کاربر",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 35.0, right: 35.0, top: 20.0, bottom: 30.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "نام و نام خانوادگی",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black),
                  ),
                  TextField(
                    onChanged: (String nameFamily){
                      _savePersonalInfo("NameFamily",nameFamily);
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0))),
                  )
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "سن",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.black),
                        ),
                        TextField(
                          onChanged: (String age){
                            _savePersonalInfo("age",age);
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0))),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "جنسیت",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.black),
                        ),
                        TextField(
                          onChanged: (String gender){
                            _savePersonalInfo("gender",gender);
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0))),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "کد زوج",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black),
                  ),
                  TextField(
                    onChanged: (String coupleCode){
                      _savePersonalInfo("CoupleCode",coupleCode);
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0))),
                  )
                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Checkbox(value: false, onChanged: (hashCode) {},),
                  Text(
                    "شروع کننده هستم و کد زوج ندارم",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  )
                ],
              ),
              Spacer(),
              MaterialButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestScreen()));
                },
                color: Color.fromRGBO(156, 100, 166, 1.0),
                padding: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)
                ),
                child: Text(
                  "شروع تست",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _savePersonalInfo(String key,String value) async{
    var savePref = await SharedPreferences.getInstance();
    savePref.setString(key, value);
  }
}
