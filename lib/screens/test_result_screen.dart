import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfect_love_app/screens/docs_screen.dart';
import 'package:perfect_love_app/screens/home_screen.dart';

class TestResultScreen extends StatefulWidget {
  String testResultBack;
  @override
  _TestResultScreenState createState() => _TestResultScreenState();
  TestResultScreen({this.testResultBack});
}

class _TestResultScreenState extends State<TestResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(206, 147, 216, 1.0),
        automaticallyImplyLeading: false,
        title: Text(
          "نتیجه تست رابطه",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.0,right: 20.0),
                child: CustomCircleAvatarWidget(
                  imagePath: 'assets/images/profile_avatar_pic.png',
                  imageWidth: 120.0,
                  imageHeight: 120.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.0,top: 20.0),
                child: Column(
                    children: [
                      Text(
                        "آیلین حسینی",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "کد زوج : 6520",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                      )
                    ],
                ),
              ),
            ],
          ),
          Spacer(),
          Card(
            color: Color.fromRGBO(255, 196, 255, 1.0),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "میزان شناخت : ${widget.testResultBack}",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "میزان تفاهم : ${widget.testResultBack}",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "سلامت بودن رابطه : بله",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0,right: 20.0,left: 20.0),
            child: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  color: Color.fromRGBO(156, 100, 166, 1.0),
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)
                  ),
                  child: Text(
                    "برگشت به خانه",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DocsScreen()));
                  },
                  color: Color.fromRGBO(156, 100, 166, 1.0),
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)
                  ),
                  child: Text(
                    "ارتباط با مشاور",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomCircleAvatarWidget extends StatelessWidget {
  String imagePath = "";
  double imageWidth;
  double imageHeight;

  CustomCircleAvatarWidget({this.imagePath, this.imageWidth, this.imageHeight});

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
