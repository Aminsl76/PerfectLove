import 'dart:convert';
import 'package:http/http.dart' as http;

class TestApiCall{

  Future<String> testResult(List<dynamic> answers,List<String> questionMarks, String token) async{

    var testUrl = "http://45.149.76.236/question/answers/";
    Map<String,dynamic> answersMap = Map.fromIterables(questionMarks, answers);
    var resultResponse = await http.post(testUrl,
      headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token
      },
      body: jsonEncode(answersMap)
    );
    if(resultResponse.statusCode == 200){
      var result = jsonDecode(resultResponse.body);
      var answersList = result['Answers'];
      var answer = answersList[0];
      String jsonResult = answer['result'] as String;
      return jsonResult;
    } else{
      print("Status code: " + resultResponse.statusCode.toString());
      return null;
    }
  }

}