import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserApiCall {

  Future<String> userRegister(String userName,String phoneNumber) async{
    String registerUrl = "http://45.149.76.236/account/register/";
    var registerResponse = await http.post(registerUrl,
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String,String>{
        'username': userName,
        'phone': phoneNumber
      })
    );
    if(registerResponse.statusCode == 201){
      var jsonResponse = jsonDecode(registerResponse.body);
      print("User has been created!");
      String responseMessage = jsonResponse['Message'] as String;
      return responseMessage;
    } else{
      print("Status code: " + registerResponse.statusCode.toString());
      return "Something went wrong!";
    }
  }

  Future<bool> userVerify(String phoneNumber, String userWrittenCode) async{
    var verifyUrl = "http://45.149.76.236/account/verify/";
    var verifyResponse = await http.post(verifyUrl,
      headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String,String>{
        'phone': phoneNumber,
        'digit': userWrittenCode
      })
    );
    if(verifyResponse.statusCode == 200){
      var jsonResponse = jsonDecode(verifyResponse.body);
      bool verifyStatus = jsonResponse['status'] as bool;
      return verifyStatus;
    } else{
      print("Verification code message: " + verifyResponse.statusCode.toString());
      return false;
    }
  }

  Future<String> userLogin({String userName,String phoneNumber}) async{
    var loginUrl = "http://45.149.76.236/account/register/";
    var loginResponse = await http.post(loginUrl,
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String,String>{
          'username': userName,
          'phone': phoneNumber
        })
    );
    if(loginResponse.statusCode == 200){
      var jsonResponse = jsonDecode(loginResponse.body);
      return jsonResponse['Token'] as String;
    } else{
      print('Status code: ' + loginResponse.statusCode.toString());
      return null;
    }
  }

}