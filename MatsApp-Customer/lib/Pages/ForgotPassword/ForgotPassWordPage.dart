import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matsapp/Network/forgotPasswordRest.dart';
import 'package:matsapp/Pages/ForgotPassword/OtpForgotpage.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';

import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/widgets/LoginPageWidgets/LoginpageTopWidget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ForgotPassWordPage extends StatefulWidget {
  @override
  _ForgotPassWordPageState createState() => _ForgotPassWordPageState();
}

class _ForgotPassWordPageState extends State<ForgotPassWordPage> {
  TextEditingController confirmpasswordController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  var checkBoxValue = false;

  var userNameController;
  // Toggles the password show status
  int registertionStatus;
  String otpfromDb;

  bool isload;

  String _username;

  @override
  void dispose() {
    mobileNumberController.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isload = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
      body: ModalProgressHUD(
        progressIndicator:
            Center(child: SpinKitHourGlass(color: Color(0xffFFB517))),
        inAsyncCall: isload,
        dismissible: false,
        opacity: 0,
        child: Form(
          key: _form,
          child: Container(
            width: screenWidth,
            height: screenHeight,
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: screenWidth,
                    height: screenHeight * .20,
                    child: LoginHeaderWidget("Forgot Password"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 90.0, left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Forgot Password ?",
                          style: AppTextStyle.titleFont1(),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25.0, top: 0, right: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            //height: screenHeight / 11,
                            width: screenWidth * .82,
                            // padding:
                            //     EdgeInsets.only(bottom: 5, left: .75, right: .75),
                            padding:
                                EdgeInsets.only(bottom: 0, left: 0, right: 0),
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
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: screenWidth * 0.03,
                                      top: 2,
                                      bottom: 2),
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                      textAlign: TextAlign.left,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      keyboardType: TextInputType.phone,
                                      controller: mobileNumberController,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onSaved: (val) => _username = val,
                                      validator: (value) => GeneralTools()
                                          .validateMobile(
                                              mobileNumberController.text),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Mobile Number',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        suffixIcon: Icon(
                                          Icons.phone_android,
                                        ),
                                        //isDense: true,
                                      )),
                                ))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            if (_form.currentState.validate()) {
                              setState(() {
                                isload = true;
                              });
                              forgotPasswordfetch(
                                mobileNumberController.text.toString(),
                              )
                                  .then((value) => {
                                        setState(() {
                                          registertionStatus = value.result;
                                          otpfromDb = value.otp;
                                        }),
                                      })
                                  .whenComplete(() async => {
                                        if (registertionStatus == 1)
                                          {
                                            await Future.delayed(
                                                Duration(seconds: 1)),
                                            setState(() {
                                              isload = false;
                                            }),
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      OtpForgotPasswordPage(
                                                          mobileNumberController
                                                              .text
                                                              .toString(),
                                                          otpfromDb),
                                                )),
                                            //mobileNumberController.clear(),
                                          }
                                        else if (registertionStatus == 0)
                                          {
                                            setState(() {
                                              isload = false;
                                            }),
                                            GeneralTools().createSnackBarFailed(
                                                "Incorrect Mobile Number",
                                                context)
                                          }
                                        else
                                          {
                                            setState(() {
                                              isload = false;
                                            }),
                                            GeneralTools().createSnackBarFailed(
                                                "Please Try Again..! ", context)
                                          }
                                      });
                            }
                          },
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
          ),
        ),
      ),
    );
  }

  String validateMobileNumber(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
