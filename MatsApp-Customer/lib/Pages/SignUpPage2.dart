import 'package:flutter/material.dart';

import 'SignUp/signUpContentWidget1.dart';
import 'SignUp/signupPageTopWidget.dart';

class SignUpPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          width: screenwidth,
          height: screenheight,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: screenwidth,
                  height: screenheight * .30,
                  child: SignupPageTopWidget(),
                ),
                Container(
                  width: screenwidth,
                  height: screenheight * .80,
                  child: SignUpContentWidget1(),
                )
              ],
            ),
          )),
    );
  }
}
