import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/constants/app_colors.dart';

class LoginHeaderWidget extends StatelessWidget {
  final String title;

  LoginHeaderWidget(this.title);
  double screenHeight;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.centerLeft,
      /*decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/loginpagetop.png"),
              fit: BoxFit.cover)),
      */
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*Expanded(
            flex: 5,
            child: Text(
              //title,
              "",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                shadows: [
                  Shadow(
                    color: AppColors.lightGreyWhite.withOpacity(0.25),
                    offset: Offset(2, 2),
                    blurRadius: 6,
                  )
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          */
          Container(
            //flex: 10,
            padding: EdgeInsets.only(left: 20.0),
            alignment: Alignment.centerLeft,
            child: Row(children: [
              SizedBox(height: screenHeight * 0.2),
              FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.contain,
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 95,
                  height: 95,
                  //fit: BoxFit.fitWidth,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
