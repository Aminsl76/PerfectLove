import 'dart:convert';
import 'package:http/http.dart' as http;

class DoctorApiCall{

  Future<List<String>> doctorList() async{
    List<String> docsNameFamily = List<String>();
    var doctorsUrl = "http://45.149.76.236/advisor/doctor/";
    var doctorsResponse = await http.post(doctorsUrl,
      headers: <String,String>{
        'Content-Length': '0'
      }
    );
    if(doctorsResponse.statusCode == 200){
      var jsonDocResponse = jsonDecode(doctorsResponse.body);
      List<dynamic> DocList = jsonDocResponse['Doctors'];
      for (int i = 0; i < DocList.length; i++){
        var docItem = DocList[i];
        String firstName = docItem['firstname'];
        String lastName = docItem['lastname'];
        docsNameFamily.add(firstName + " " + lastName);
      }
      return docsNameFamily;
    } else{
      print("Status code: " + doctorsResponse.statusCode.toString());
      return null;
    }
  }

  Future<List<String>> doctorsFreeTimes(String token, String docIndex) async{
      var freeTimesUrl = "http://45.149.76.236/advisor/freetime/";
      var freeTimesResponse = await http.post(freeTimesUrl,
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token
        },
        body: jsonEncode(<String,String>{
          'doctor': docIndex
        })
      );

      if(freeTimesResponse.statusCode == 200){
        var jsonFreeTimesResponse = jsonDecode(freeTimesResponse.body);
        List<dynamic> appointmentsList = jsonFreeTimesResponse['Appointments'];

        List<String> appointmentTimes = List<String>();

        for (int i = 0; i < 10; i++){
          String appointmentStatus = appointmentsList[i].toString().substring(49,53);
          if(appointmentStatus == "True"){
            appointmentTimes.add(appointmentsList[i].toString().substring(25,39));
          }
        }
        return appointmentTimes;
      } else{
        print("Status code: " + freeTimesResponse.statusCode.toString() + freeTimesResponse.body);
        return null;
      }
  }

  Future<bool> addAppointment(String docIndex, String date, String timeSlot , String token) async{
    var addAppointUrl = "http://45.149.76.236/advisor/addappointment/";
    var addAppointResponse = await http.post(addAppointUrl,
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token
      },
      body: jsonEncode(<String,String>{
        'doctor': docIndex,
        'date': date,
        'timeslot': timeSlot
      })
    );

    if(addAppointResponse.statusCode == 200){
      var jsonResponse = jsonDecode(addAppointResponse.body);
      bool addStatus = jsonResponse['status'];
      if(addStatus)
        return true;
      else
        return false;
    } else{
      print("Status code: " + addAppointResponse.statusCode.toString() + "Message is: " + addAppointResponse.body);
      return false;
    }
  }

}