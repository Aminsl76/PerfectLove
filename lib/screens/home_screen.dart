import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:perfect_love_app/screens/article_screen.dart';
import 'package:perfect_love_app/screens/docs_screen.dart';
import 'package:perfect_love_app/screens/person_info_screen.dart';
import 'package:perfect_love_app/screens/profile_screen.dart';
import 'package:perfect_love_app/screens/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {

  static String appBarTitle ;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 2;
  int pageIndex = 2;

  //List of pages in order to iterate among this list and navigate to one of them at a time
  List<Widget> pages = [
    ArticleScreen(),
    SearchScreen(),
    HomeContentWidget(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    //Adjusting the appbar title based on which page is on
    switch(pageIndex){
      case 0:
        HomeScreen.appBarTitle = "پست ها";
        break;
      case 1:
        HomeScreen.appBarTitle = "جست و جو";
        break;
      case 2:
        HomeScreen.appBarTitle = "Perfect Love";
        break;
      case 3:
        HomeScreen.appBarTitle = "پروفایل";
        break;
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(206, 147, 216, 1.0),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            HomeScreen.appBarTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.white,
            ),
          )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            pageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/bottom_nav_info.png',
                width: 30.0,
                height: 30.0,
              ),
              label: "Info",
              activeIcon: Image.asset(
                'assets/images/bottom_nav_info.png',
                width: 30.0,
                height: 30.0,
              )),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/bottom_nav_search.png',
                width: 30.0,
                height: 30.0,
              ),
              label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.black26,
                size: 40.0,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/bottom_nav_profile.png",
                width: 30.0,
                height: 30.0,
              ),
              label: "Profile")
        ],
      ),
      body: pages[pageIndex],
    );
  }
}

class HomeContentWidget extends StatelessWidget {
  const HomeContentWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PersonInfoScreen()));
              },
              child: Card(
                elevation: 3.0,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/relation_test.png',
                        width: 150.0,
                        height: 150.0,
                      ),
                      Text(
                        "تست رابطه",
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Color.fromRGBO(206, 147, 216, 1.0),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DocsScreen()));
              },
              child: Card(
                elevation: 3.0,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/therapist_contact.png',
                        width: 150.0,
                        height: 150.0,
                      ),
                      Text(
                        "ارتباط با مشاور",
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Color.fromRGBO(206, 147, 216, 1.0),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
