import 'package:flutter/material.dart';
import 'package:matsapp/widgets/LoginPageWidgets/LoginPageContentWidget.dart';

import 'package:matsapp/widgets/LoginPageWidgets/LoginpageTopWidget.dart';

class LoginPageNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          width: screenWidth,
          height: screenHeight,
          child: Wrap(
            children: <Widget>[
              Container(
                  width: screenWidth,
                  height: screenHeight * .30,
                  child: LoginHeaderWidget("Login")),
              Container(
                  width: screenWidth,
                  height: screenHeight * .70,
                  child: LoginPageContentWidget())
            ],
          )),
    );
  }
}
