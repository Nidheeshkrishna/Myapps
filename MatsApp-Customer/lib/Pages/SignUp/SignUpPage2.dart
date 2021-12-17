import 'package:flutter/material.dart';
import 'package:matsapp/Pages/Login/LoginPage.dart';
import 'package:matsapp/Pages/SignUp/signUpContentWidget1.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/widgets/LoginpageTopWidget.dart';

class SignUpPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(
        backgroundColor: Color.fromARGB(100, 250, 250, 250),
        title: new Text(""),
        leading: new IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: new Icon(Icons.arrow_back_rounded)),
        //backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.only(
            bottom: screenheight * 0.05,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already Have An Account?",
                style: TextStyle(
                  color: const Color(0xe5707070),
                ),
              ),
              InkWell(
                child: Text(
                  " Login",
                  style: TextStyle(
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w900,
                      color: AppColors.kAccentColor,
                      fontSize: 18),
                ),
                onTap: () {
                  //setState(() {
                  // isEnabled = !isEnabled;
                  //});
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              )
            ],
          ),
        ),
        elevation: 0,
      ),
      body: Container(
          width: screenwidth,
          height: screenheight,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: screenwidth,
                  height: screenheight * .20,
                  child: LoginHeaderWidget("Sign Up"),
                ),
                Container(
                  height: screenheight * .70,
                  width: screenwidth,
                  child: SignUpContentWidget1(),
                )
              ],
            ),
          )),
    );
  }
}
