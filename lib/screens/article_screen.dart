import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleScreen extends StatefulWidget {
  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: 8,
      itemBuilder: (context, index) {
        return ArticlePostWidget();
      },
    );
  }
}

class ArticlePostWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15.0,right: 15.0,bottom: 15.0),
                child: Image.asset(
                  'assets/images/post_thumbnail.png',
                  width: 60.0,
                  height: 60.0,
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                "عنوان مقاله",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.0,left: 10.0,right: 10.0),
            child: Text(
              "لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است ",
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textDirection: TextDirection.rtl,
              maxLines: 3,
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}
