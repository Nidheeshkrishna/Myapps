import 'package:flutter/material.dart';
import 'package:matsapp/Pages/SignUp/oldsignup/signUpContentWidget.dart';
import 'package:matsapp/widgets/LoginPageWidgets/LoginpageTopWidget.dart';

class SignUpPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromARGB(100, 250, 250, 250),
        title: new Text(""),
        leading: new IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: new Icon(Icons.arrow_back_rounded)),
        //backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
          width: screenwidth,
          height: screenheight,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: screenwidth,
                  height: screenheight * .15,
                  child: LoginHeaderWidget("Sign Up"),
                ),
                Container(
                  width: screenwidth,
                  height: screenheight * .80,
                  child: SignUpContentWidget(),
                )
              ],
            ),
          )),
    );
  }
}
