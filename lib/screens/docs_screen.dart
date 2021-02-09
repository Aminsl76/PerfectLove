import 'package:flutter/material.dart';
import 'package:perfect_love_app/network/doctorApi.dart';
import 'package:perfect_love_app/screens/doc_detail_screen.dart';
import 'package:perfect_love_app/screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocsScreen extends StatefulWidget {
  @override
  _DocsScreenState createState() => _DocsScreenState();
}

class _DocsScreenState extends State<DocsScreen> {
  List<String> docNames = List<String>();

  @override
  void initState() {
    super.initState();
    _docListShow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(206, 147, 216, 1.0),
        centerTitle: true,
        title: Text(
          "ارتباط با مشاور",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.white),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: docNames.length,
          itemBuilder: (context, index) {
            return DocCardWidget(docsnameFamily: docNames, index: index,);
          },
        ),
      ),
    );
  }

  Future<List<String>> _docListShow() async{
    var doctorsResponseList = await DoctorApiCall().doctorList();
   setState(() {
     docNames = doctorsResponseList;
   });
  }
}

class DocCardWidget extends StatelessWidget {
  List<String> docsnameFamily = List<String>();
  int index;

  DocCardWidget({this.docsnameFamily, this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DocDetailScreen(docIndex: (index = index + 4))));
      },
      child: Card(
        color: Color.fromRGBO(255, 196, 255, 1.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              CustomImageWidget(
                imagePath: 'assets/images/profile_avatar_pic.png',
                imageWidth: 60.0,
                imageHeight: 60.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                children: [
                  Text(
                    docsnameFamily[index],
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    "متخصص",
                    style: TextStyle(fontSize: 16.0),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
