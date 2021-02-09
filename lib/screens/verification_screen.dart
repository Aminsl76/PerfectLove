import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfect_love_app/network/userApi.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String userName;

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
  VerificationScreen({Key key,@required this.phoneNumber,@required this.userName}) : super(key: key);
}

class _VerificationScreenState extends State<VerificationScreen> {

  String verifyCode;
  String timerValue = "02:00";

  @override
  void initState() {
    super.initState();
    timerCountDown();
  }

  @override
  Widget build(BuildContext context) {
    final ProgressDialog progressDialog = ProgressDialog(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color.fromRGBO(206, 147, 216, 1.0),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/app_logo.png',
                width: 200.0,
                height: 200.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "کد تایید",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black
                    ),
                  ),
                  IntrinsicWidth(
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Colors.white,
                      ),
                      child: TextField(
                        onChanged: (String verfifyCode){
                          setState(() {
                            this.verifyCode = verfifyCode;
                          });
                        },
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 30.0),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "کد تایید را وارد کنید",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "کد تایید برای شماره ${widget.phoneNumber}\n ارسال شد",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Expiration time: " + timerValue,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color.fromRGBO(124, 78, 132, 1.0)
                ),
              ),
              Spacer(),
              MaterialButton(onPressed: () async{
                progressDialog.show();
                UserApiCall userVerifyCall = UserApiCall();
                bool responseStatus = await userVerifyCall.userVerify(widget.phoneNumber, verifyCode); //Awaiting for response status if that's true , User has been created successfully
                var userPref = await SharedPreferences.getInstance();
                userPref.setString('PhoneNumber', widget.phoneNumber);
                userPref.setString('UserName', widget.userName);
                if(responseStatus) {
                  progressDialog.hide();
                  Navigator.pushNamed(context, '/Home');
                }
                else{
                  progressDialog.hide();
                  print("Something went wrong!");
                }

              },
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "ورود",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                color: Color.fromRGBO(156, 100, 166, 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void timerCountDown() {
    int minutes = 01;
    int seconds = 60;
    Timer timer;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(minutes >= 0){
          seconds--;
          timerValue = (minutes.toString()) + ":" + (seconds.toString());
          if(seconds == 0){
            if(minutes == 0) {
              timer.cancel();
              return;
            }
            minutes --;
            seconds = 60;
            timerValue = (minutes.toString()) + ":" + (seconds.toString());
          }
        }
      });
    });
  }
}
