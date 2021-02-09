import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfect_love_app/screens/home_screen.dart';
import 'package:perfect_love_app/screens/person_info_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15.0, right: 15.0),
              child: PrimaryProfileWidget()),
          Padding(
            padding: EdgeInsets.only(top: 15.0,right: 20.0),
              child: SecondaryProfileWidget())
        ],
      ),
    );
  }
}

class SecondaryProfileWidget extends StatefulWidget {
  String gender;
  String age;

  @override
  State<StatefulWidget> createState() => _SecondaryProfileWidgetState();
}

class _SecondaryProfileWidgetState extends State<SecondaryProfileWidget> {

  @override
  void initState() {
    super.initState();
    _showPersonalInfo('gender', 'age');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "جنسیت : ${widget.gender}",
          textAlign: TextAlign.right,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "سن : ${widget.age}",
          textAlign: TextAlign.right,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.black
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "شماره همراه : 09057599511",
          textAlign: TextAlign.right,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          "نتیجه آخرین تست رابطه : ",
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "میزان شناخت : %70",
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.black
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "میزان تفاهم : %60",
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "سلامت بودن رابطه : بله",
          textAlign: TextAlign.right,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.black
          ),
        )
      ],
    );
  }

  Future<void> _showPersonalInfo(String genderKey, String ageKey) async{
    var showPref = await SharedPreferences.getInstance();
    setState(() {
      widget.gender = showPref.getString(genderKey);
      widget.age = showPref.getString(ageKey);
    });
  }
}

class PrimaryProfileWidget extends StatefulWidget {
  String nameFamily;
  String coupleCode;

  @override
  State<StatefulWidget> createState() => _PrimaryProfileWidgetState();
}

class _PrimaryProfileWidgetState extends State<PrimaryProfileWidget> {

  @override
  void initState() {
    super.initState();
    _showPersonalInfo('NameFamily','CoupleCode');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomImageWidget(
          imagePath: 'assets/images/profile_avatar_pic.png',
          imageHeight: 90.0,
          imageWidth: 90.0,
        ),
        SizedBox(
          width: 25.0,
        ),
        Column(
          textDirection: TextDirection.rtl,
          children: [
            Text(
              widget.nameFamily,
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black),
            ),
            Text(
              "کد زوج : ${widget.coupleCode}",
              style: TextStyle(fontSize: 16.0),
            )
          ],
        )
      ],
    );
  }

  Future<void> _showPersonalInfo(String nameFamilyKey, String coupleCodeKey) async{
    var showPref = await SharedPreferences.getInstance();
    setState(() {
      widget.nameFamily = showPref.getString(nameFamilyKey);
      widget.coupleCode = showPref.getString(coupleCodeKey);
    });
  }
}

class CustomImageWidget extends StatelessWidget {
  String imagePath = "";
  double imageWidth;
  double imageHeight;

  CustomImageWidget({this.imagePath, this.imageWidth, this.imageHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageWidth,
      height: imageHeight,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image:
              DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill)),
    );
  }
}
