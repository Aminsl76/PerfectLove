import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfect_love_app/consts/constTexts.dart';
import 'package:perfect_love_app/network/testApi.dart';
import 'package:perfect_love_app/screens/test_result_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<dynamic> answers = new List<dynamic>();
String fullName;
String birthDate;

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(206, 147, 216, 1.0),
          actions: [
            IconButton(icon: Icon(Icons.check,color: Colors.white,), onPressed: () async{
              var tokenPref = await SharedPreferences.getInstance();
              String testResult = await TestApiCall().testResult(answers, questions, tokenPref.getString('token'));
              print(testResult);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestResultScreen(testResultBack: testResult,)));
            })
          ],
          title: Text(
            "تست رابطه",
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: ListView.separated(
            padding: EdgeInsets.only(top: 20.0, right: 30.0, left: 30.0 , bottom: 15.0),
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return FirstTwoCard(
                    qText: questionTexts[0],
                  );
                  break;
                case 1:
                  return FirstTwoCard(
                    qText: questionTexts[1],
                  );
                  break;
                case 2:
                  return DogCatCard();
                default:
                  return QuestionCard(
                    index: index,
                  );
              }
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 15.0,
                ),
            itemCount: questionTexts.length)
    );
  }
}

class QuestionCard extends StatefulWidget{
  int index;
  @override
  State<StatefulWidget> createState() => _QuestionCardState();
  QuestionCard({this.index});
}
class _QuestionCardState extends State<QuestionCard> {
  int questionNumber;
  bool yesFlag = false;
  bool noFlag = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Text(
                "${questionNumber = widget.index + 1}",
                style: TextStyle(
                    backgroundColor: Color.fromRGBO(156, 100, 166, 1.0),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.white),
              ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                questionTexts[widget.index],
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Flexible(
                child: CheckboxListTile(
                  value: yesFlag,
                  onChanged: (yesnoValue) {
                    setState(() {
                      answers.add(true);
                      yesFlag = yesnoValue;
                      noFlag = false;
                    });
                  },
                  title: Text("بله", textDirection: TextDirection.rtl,),
                ),
              ),
              Flexible(
                child: CheckboxListTile(
                  value: noFlag,
                  onChanged: (yesnoValue) {
                    setState(() {
                      answers.add(false);
                      noFlag = yesnoValue;
                      yesFlag = false;
                    });
                  },
                  title: Text("خیر", textDirection: TextDirection.rtl,),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class DogCatCard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DogCatCardState();
}
class _DogCatCardState extends State<DogCatCard> {
  bool dogFlag = false;
  bool catFlag = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Text(
                "3",
                style: TextStyle(
                    backgroundColor: Color.fromRGBO(156, 100, 166, 1.0),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.white),
              ),
              SizedBox(width: 20.0),
              Text(
                questionTexts[2],
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.rtl,
            children: [
              Flexible(
                child: CheckboxListTile(
                  value: dogFlag,
                  onChanged: (charValue) {
                    setState(() {
                      answers.add(fullName);
                      answers.add(birthDate);
                      answers.add('dog');
                      dogFlag = charValue;
                      catFlag = false;
                    });
                  },
                  title: Text(
                    "سگ",
                    textDirection: TextDirection.rtl,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                ),
              ),
              Flexible(
                child: CheckboxListTile(
                  value: catFlag,
                  onChanged: (charValue) {
                    setState(() {
                      answers.add(fullName);
                      answers.add(birthDate);
                      answers.add('cat');
                      catFlag = charValue;
                      dogFlag = false;
                    });
                  },
                  title: Text(
                    "گربه",
                    textDirection: TextDirection.rtl,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class FirstTwoCard extends StatelessWidget {
  String qText;

  FirstTwoCard({this.qText});

  @override
  Widget build(BuildContext context) {
    if (qText == "اسم کامل من چیه ؟")
      return Container(
        child: Column(
          children: [
            Row(
              textDirection: TextDirection.rtl,
              children: [
                Text(
                  "1",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      backgroundColor: Color.fromRGBO(156, 100, 166, 1.0)),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  questionTexts[0],
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            TextField(
              onChanged: (String myFullName){
                fullName = myFullName;
              },
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
            )
          ],
        ),
      );
    else
      return Container(
        child: Column(
          children: [
            Row(
              textDirection: TextDirection.rtl,
              children: [
                Text(
                  "2",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      backgroundColor: Color.fromRGBO(156, 100, 166, 1.0)),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  questionTexts[1],
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            TextField(
              onChanged: (myBirthdate){
                birthDate = myBirthdate;
              },
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
            )
          ],
        ),
      );
  }
}
