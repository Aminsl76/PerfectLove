import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfect_love_app/network/userApi.dart';
import 'package:perfect_love_app/screens/verification_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  String userName;
  String phoneNumber;

  @override
  void initState(){
    super.initState();
    _loginRequest();
  }

  @override
  Widget build(BuildContext context) {
    final ProgressDialog progressDialog = ProgressDialog(context);
    return Scaffold(
        backgroundColor: Color.fromRGBO(206, 147, 216, 1.0),
        resizeToAvoidBottomPadding: false,
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 30.0,bottom: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/app_logo.png",
                  width: 200.0,
                  height: 200.0,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "نام کاربری",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    IntrinsicWidth(
                      child: Theme(
                        data: ThemeData(
                          primaryColor: Colors.white,
                        ),
                        child: TextField(
                          onChanged: (String userName){
                            setState(() {
                              this.userName = userName;
                            });
                          },
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 35.0),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "نام کاربری را وارد کنید",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "شماره همراه",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    IntrinsicWidth(
                      child: Theme(
                        data: ThemeData(
                          primaryColor: Colors.white,
                        ),
                        child: TextField(
                          onChanged: (String phoneNumber){
                            setState(() {
                              this.phoneNumber = phoneNumber;
                            });
                          },
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 30.0),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "شماره همراه را وارد کنید",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                        ),
                      ),
                    )
                  ],
                ),
                Spacer(),
                MaterialButton(
                  onPressed: () async{
                    progressDialog.show();
                    UserApiCall userCall = UserApiCall();
                    var response = await userCall.userRegister(userName, phoneNumber); // Calling the appropriate api method for in order to register a new user
                    if(response == "Digit has been sent") {
                      progressDialog.hide();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              VerificationScreen(phoneNumber: phoneNumber, userName: userName,))
                      ); // Navigating to the verification screen if the verification code is sent
                    }
                    else{
                      progressDialog.hide();
                      print("Something went wrong!");
                    }
                  },
                  color: Color.fromRGBO(156, 100, 166, 1.0),
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: Text(
                    "دریافت کد تایید",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  //Login method using the shared preferences for automatic user login
  _loginRequest() async{
    var loginPref = await SharedPreferences.getInstance(); //Creating an instance of shared preference r/w to do the writing and reading operations on shared preference
    this.userName = loginPref.getString('UserName');
    this.phoneNumber = loginPref.getString('PhoneNumber');
    if(this.userName != null && this.phoneNumber != null){
      String token = await UserApiCall().userLogin(userName: this.userName,phoneNumber: this.phoneNumber); // Awaiting for the appropriate token for a user in order to recognize his further requests
      loginPref.setString('token', token);
      if(token != null)
        Navigator.pushNamed(context, '/Home');
      else
        print("Something went wrong!");
    } else{
      return;
    }
  }
}
