import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matsapp/Pages/Login/LoginPage.dart';
import 'package:matsapp/Pages/HomePages/MainHomePage.dart';

import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/size_config.dart';

class SessionexpiredDialog extends StatefulWidget {
  @override
  _session_expired_DialogState createState() => _session_expired_DialogState();
}

// ignore: camel_case_types
class _session_expired_DialogState extends State<SessionexpiredDialog> {
  String townSelectedStore;
  bool status = false;

  bool loginStatus = false;

  @override
  void initState() {
    super.initState();

    // Timer(
    //     Duration(seconds: 20),
    //     () => //Navigator.pushNamed(context, '/passwordsettingpage')

    //         Navigator.push(
    //             context, MaterialPageRoute(builder: (context) => LoginPage())));

    //'/login',
    ///productinarea
    // /storepageproduction
    ///mycouponspage
    ///googlelocationpage
    ////allcategoriesPage
  }

  @override
  Widget build(BuildContext context) {
    //showDialog().then((value) => null);
    Future.delayed(Duration.zero, () => showAlert(context)).then((value) =>
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage())));
    return Container(
      child: Text("Hello world"),
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("hi"),
            ));
  }
}
