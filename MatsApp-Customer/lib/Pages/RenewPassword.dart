import 'package:flutter/material.dart';
import 'package:matsapp/widgets/LoginPageWidgets/LoginpageTopWidget.dart';

class RenewPassword extends StatefulWidget {
  @override
  _RenewPasswordState createState() => _RenewPasswordState();
}

class _RenewPasswordState extends State<RenewPassword> {
  var checkBoxValue = false;

  var userNameController;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenHeight,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: screenWidth,
              height: screenHeight * .30,
              child: LoginHeaderWidget("Renew Password"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Renew Password ?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * .80,
                    // height: screenHeight * .1,
                    child: Card(
                      shadowColor: Colors.orange,
                      elevation: 5,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: TextFormField(
                        validator: (value) =>
                            value.isEmpty ? 'Enter old Password' : null,
                        controller: userNameController,
                        decoration: const InputDecoration(
                          hintText: 'Old Password',
                          hintStyle: TextStyle(color: Colors.grey),

                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical:
                                  15), //Change this value to custom as you like
                          isDense: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.orange, width: 8),
                            //  when the TextFormField in focused
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * .80,
                    // height: screenHeight * .1,
                    child: Card(
                      shadowColor: Colors.orange,
                      elevation: 5,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: TextFormField(
                        validator: (value) =>
                            value.isEmpty ? 'Enter New Password' : null,
                        controller: userNameController,
                        decoration: const InputDecoration(
                          hintText: 'New Password',
                          hintStyle: TextStyle(color: Colors.grey),

                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical:
                                  15), //Change this value to custom as you like
                          isDense: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.orange, width: 8),
                            //  when the TextFormField in focused
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * .80,
                    // height: screenHeight * .1,
                    child: Card(
                      shadowColor: Colors.orange,
                      elevation: 5,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: TextFormField(
                        validator: (value) =>
                            value.isEmpty ? 'Enter Confirm  Password' : null,
                        controller: userNameController,
                        decoration: const InputDecoration(
                          hintText: 'Confirm  Password',
                          hintStyle: TextStyle(color: Colors.grey),

                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical:
                                  15), //Change this value to custom as you like
                          isDense: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.orange, width: 8),
                            //  when the TextFormField in focused
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Theme.of(context).accentColor,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
