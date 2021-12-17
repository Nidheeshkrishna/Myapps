import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matsapp/Network/ChangePasswordRest.dart';
import 'package:matsapp/Pages/Login/LoginPage.dart';

import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _isHidden = true;
  FocusNode _focus = new FocusNode();
  FocusNode _focusCurrentPassword = new FocusNode();
  String mobileNumber;

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focus.dispose();
    _focusCurrentPassword.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusCurrentPassword = FocusNode();
    _focus.addListener(_onFocusChange);
    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          setState(() {
            mobileNumber = value[0].mobilenumber;
          }),
        });
  }

  void _togglePasswordView() {
    _focus.addListener(_onFocusChange);
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _onFocusChange() {
    if (!_focus.hasFocus) {
      if (!GeneralTools()
          .validatePassword(newpasswordController.text.toString())) {
        validatorPasswordDialoge(context);
      }
    }
  }

  int user_status;
  bool isload = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController currentController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppBar appbar = AppBar(
      backgroundColor: Colors.white,
      title: Text("Change your Password",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.25,
              fontSize: 18,
              color: Colors.blueGrey)),
      centerTitle: true,
      leading: InkWell(
        child: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return ModalProgressHUD(
      progressIndicator:
          Center(child: SpinKitHourGlass(color: Color(0xffFFB517))),
      inAsyncCall: isload,
      dismissible: false,
      opacity: 0,
      child: Scaffold(
          appBar: appbar,
          body: Container(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Image.asset(
                        'assets/images/logo.png',
                        scale: 8,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Change Password',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: screenWidth * .80,
                            padding: EdgeInsets.only(
                                bottom: 5, left: .75, right: .75),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.kPrimaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x12000000),
                                  offset: Offset(0, 3),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                focusNode: _focusCurrentPassword,
                                textAlign: TextAlign.center,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Password required";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: currentController,
                                autofocus: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,

                                  hintText: 'CurrentPassword',
                                  hintStyle: TextStyle(color: Colors.grey),

                                  //Change this value to custom as you like
                                  isDense: true,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: screenWidth * .80,
                            padding: EdgeInsets.only(
                                bottom: 5, left: .75, right: .75),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.kPrimaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x12000000),
                                  offset: Offset(0, 3),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                obscureText: _isHidden,
                                obscuringCharacter: "*",
                                textAlign: TextAlign.center,
                                // focusNode: _focus,
                                //autofocus: true,
                                controller: newpasswordController,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                               keyboardType: TextInputType.number,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Password Required";
                                  } else if (value.length < 3) {
                                    return "Minimum length is 3";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  // suffixIcon: InkWell(
                                  //   onTap: _togglePasswordView,
                                  //   child: Icon(
                                  //     _isHidden
                                  //         ? Icons.visibility
                                  //         : Icons.visibility_off,
                                  //   ),
                                  // ),
                                  hintText: 'New Password',
                                  hintStyle: TextStyle(color: Colors.grey),

                                  //Change this value to custom as you like
                                  isDense: true,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: screenWidth * .80,
                            padding: EdgeInsets.only(
                                bottom: 5, left: .75, right: .75),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.kPrimaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x12000000),
                                  offset: Offset(0, 3),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                obscureText: _isHidden,
                                obscuringCharacter: "*",
                                textAlign: TextAlign.center,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                               keyboardType: TextInputType.number,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Re Enter Password";
                                  }
                                  // } else if (value.length < 8) {
                                  //   return "Password must be atleast 8 characters long";
                                  // }
                                  else if (value !=
                                      newpasswordController.text.toString()) {
                                    return "Password Is Not Same";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: InkWell(
                                    onTap: _togglePasswordView,
                                    child: Icon(
                                      _isHidden
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(color: Colors.grey),

                                  //Change this value to custom as you like
                                  isDense: true,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          new Container(
                            //padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).accentColor,
                                  elevation: 5,
                                  onPrimary: Colors.blue,
                                  shadowColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      side: BorderSide(
                                        color: Theme.of(context).accentColor,
                                      ))),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    isload = true;
                                  });

                                  ChangePasswordCustomer(
                                          mobileNumber,
                                          currentController.text.toString(),
                                          newpasswordController.text.toString())
                                      .then((value) => {
                                            user_status = value.result,
                                          })
                                      .whenComplete(() async => {
                                            if (user_status == 1)
                                              {
                                                setState(() {
                                                  isload = false;
                                                }),
                                                GeneralTools()
                                                    .createSnackBarSuccess(
                                                        "Password changed successfully",
                                                        context),
                                                await Future.delayed(
                                                    Duration(seconds: 1)),
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginPage())),
                                              }
                                            else if (user_status == 0)
                                              {
                                                setState(() {
                                                  isload = false;
                                                }),
                                                GeneralTools()
                                                    .createSnackBarFailed(
                                                  "Check your Current Password",
                                                  context,
                                                ),
                                                _focusCurrentPassword
                                                    .requestFocus()
                                              }
                                          });
                                }
                              },
                              child: Text(
                                "Continue",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future validatorPasswordDialoge(
    BuildContext context,
  ) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.white,
              //insetPadding: EdgeInsets.symmetric(vertical: 100),
              content: SingleChildScrollView(
                child: Container(
                    // width: double.maxFinite,
                    // height: 200,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: AppColors.kPrimaryColor, width: 2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Container(
                      child: Column(children: [
                        Container(
                            color: AppColors.kPrimaryColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Password Guidelines",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(
                                            color: AppColors.kBackColor,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: AppColors.kBackColor,
                                      ),
                                      onPressed: () => {
                                            Navigator.pop(context),
                                            _focus.requestFocus(),
                                          })
                                ])),
                        SingleChildScrollView(
                          child: Container(
                            // height: 200.0, // Change as per your requirement
                            // width: 300.0,
                            child: ListView(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(
                                    Icons.stars_outlined,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    "Minimum 1 Upper case",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.stars_outlined,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    "Minimum 1 lowercase",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.stars_outlined,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    "Minimum 1 Numeric Number",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.stars_outlined,
                                    color: Colors.red,
                                  ),
                                  title: Text("Minimum 1 Special Character",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.stars_outlined,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    "Common Allow Characters ( ! @ # \$ \& * ~ )",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.stars_outlined,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    "Minimum 8 Characters",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    )),
              ));
        });
  }
}
