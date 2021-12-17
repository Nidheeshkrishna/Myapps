import 'package:flutter/material.dart';

class SignupPageTopWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      //alignment: Alignment.topLeft,
      children: <Widget>[
        Container(
          child: Image.asset(
            "assets/images/loginpagetop.png",
            //width: screenWidth * .65,
            //height: screenHeight * .70,
          ),
        ),
        Positioned(
            top: 80,
            left: 30,
            child: Text(
              "SignUp",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            )),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 60, right: 20),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Image.asset(
                "assets/images/logo.png",
                width: 100,
                height: 100,
                //fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
