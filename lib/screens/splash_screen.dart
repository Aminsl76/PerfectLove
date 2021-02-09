import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 4000), () {
      setState(() {
        Navigator.pushReplacementNamed(context, "/Signup");
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/splash_bg.png',
              fit: BoxFit.cover,
            ),
            Positioned(
              top: (screenSize.height / 2) - 90 ,
              left: (screenSize.width / 2) - 100,
              child: Image.asset(
                'assets/images/app_logo.png',
                width: 200.0,
                height: 200.0,
              ),
            )
          ],
        ));
  }
}
