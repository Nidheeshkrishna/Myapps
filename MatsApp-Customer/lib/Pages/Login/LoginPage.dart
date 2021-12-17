import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matsapp/constants/app_colors.dart';

import 'package:matsapp/widgets/LoginPageWidgets/LoginPageContentWidget.dart';

import 'package:matsapp/widgets/LoginPageWidgets/LoginpageTopWidget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with HttpOverrides {
  Color colorhover = AppColors.kAccentColor;

  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;

    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.only(
              bottom: screenHeight * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New User?",
                  style: TextStyle(
                    color: const Color(0xe5707070),
                  ),
                ),
                InkWell(
                  //hoverColor: Colors.purple,
                  onHover: (_) {
                    colorhover = Colors.purple;
                  },
                  child: Text(
                    " Join Now",
                    style: TextStyle(
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w900,
                        color: colorhover,
                        fontSize: 18),
                  ),
                  onTap: () {
                    //setState(() {
                    // isEnabled = !isEnabled;
                    //});
                    Navigator.pushNamed(
                      context,
                      '/signUp2',
                    );
                  },
                )
              ],
            ),
          ),
          elevation: 0,
        ),
        // resizeToAvoidBottomInset: true,
        // resizeToAvoidBottomInset: true,
        body: WillPopScope(
          onWillPop: () {
            return SystemNavigator.pop();
          },
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Container(
              width: screenWidth,
              height: screenHeight,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: screenWidth,
                      height: screenHeight * .25,
                      child: LoginHeaderWidget("Login")),
                  Container(child: LoginPageContentWidget())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
//  var alphabet = ['a', 'b', 'c', 'd', 'e', 'f'];
//     var alphabetPairs = splitArrayIntoChunksOfLen(alphabet, 2);
//     print(alphabetPairs);
//   splitArrayIntoChunksOfLen(arr, len) {
//     var chunks = [], i = 0, n = arr.length;
//     while (i < n) {
//       chunks.add(arr.slice(i, i += len));
//     }
//     return chunks;
//   }
}
