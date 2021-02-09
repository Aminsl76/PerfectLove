import 'package:flutter/material.dart';
import 'package:perfect_love_app/screens/profile_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [SearchBarWidget(), RecentSearchWidget()],
      ),
    );
  }
}

class RecentSearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 40.0, top: 10.0),
          child: Text(
            "جست و جو های اخیر",
            textAlign: TextAlign.right,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: EdgeInsets.only(right: 15.0 , left: 20.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              CustomImageWidget(
                imagePath: 'assets/images/profile_avatar_pic.png',
                imageWidth: 50.0,
                imageHeight: 50.0,
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "آیلین حسینی",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    "متخصص",
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Spacer(),
              GestureDetector(
                child: Image.asset(
                  'assets/images/delete_marker.png',
                  width: 15.0,
                  height: 15.0,
                ),
                onTap: () {},
              )
            ],
          ),
        )
      ],
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.circular(10.0),
        child: TextField(
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                size: 30.0,
              ),
              hintText: "جست و جوی خود را وارد کنید",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 0.0, style: BorderStyle.none)),
              filled: true,
              fillColor: Colors.white),
        ),
      ),
    );
  }
}
