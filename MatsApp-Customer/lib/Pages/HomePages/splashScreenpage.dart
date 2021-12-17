import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matsapp/Pages/Login/LoginPage.dart';
import 'package:matsapp/Pages/HomePages/MainHomePage.dart';

import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/size_config.dart';

class SplashScreenpage extends StatefulWidget {
  @override
  _splash_screen_pageState createState() => _splash_screen_pageState();
}

// ignore: camel_case_types
class _splash_screen_pageState extends State<SplashScreenpage> {
  String townSelectedStore;
  bool status = false;

  bool loginStatus = false;

  @override
  void initState() {
    super.initState();
    getLogin();
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    Timer(
        Duration(seconds: 2),
        () => //Navigator.pushNamed(context, '/passwordsettingpage')
            loginStatus
                ? Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainHomePage()))
                : Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  ));

    //'/login',
    ///productinarea
    // /storepageproduction
    ///mycouponspage
    ///googlelocationpage
    ////allcategoriesPage
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  child: Image.asset(
                "assets/images/logo.png",
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              )),
            ),
          ],
        ),
      ),
    );
  }

  Future getLogin() async {
    DatabaseHelper dbHelper = new DatabaseHelper();
    status = await dbHelper.isLoggedIn();
    setState(() {
      loginStatus = status;
    });
  }
}
