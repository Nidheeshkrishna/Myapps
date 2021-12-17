import 'dart:ui';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matsapp/Modeles/SignUp/datapassingModel.dart';
import 'package:matsapp/Network/RegistrationRest.dart';
import 'package:matsapp/Pages/Login/LoginPage.dart';
import 'package:matsapp/Pages/Providers/ConnectivityServices.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:matsapp/utilities/urls.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class SignUpContentWidget1 extends StatefulWidget {
  static TextEditingController userNameController;

  @override
  _SignUpContentWidgetState createState() => _SignUpContentWidgetState();
}

class _SignUpContentWidgetState extends State<SignUpContentWidget1> {
  final formSignup1 = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();

  TextEditingController referralCodeController = TextEditingController();

  var checkBoxValue = false;
  var regstatus;
  String mobilenumber;
  String otpPassed;

  SharedPreferences prefs;

  bool isload = false;

  String refferalCode;

  bool isEnabled = false;
  bool _hasBeenPressed = false;
  bool networkStatus = false;

  bool show_textreferral = false;
  ConnectivityStatus connectionStatus;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    connectionStatus = Provider.of<ConnectivityStatus>(context);
    checkNetwork();
    //double screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        width: screenWidth * .80,
        height: screenheight,
        child: ModalProgressHUD(
          progressIndicator:
              Center(child: SpinKitHourGlass(color: Color(0xffFFB517))),
          inAsyncCall: isload,
          dismissible: false,
          opacity: 0,
          child: Form(
            key: formSignup1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Center(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Sign up",
                        style: AppTextStyle.titleFont(),
                      )
                    ],
                  ),
                  SizedBox(height: screenheight * .01),
                  Row(
                    children: [
                      Text("Welcome To MatsApp",
                          style: AppTextStyle.titleFont2()),
                    ],
                  ),
                  SizedBox(
                    height: screenheight * .005,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth * .80,
                          //height: sc,

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
                            padding: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.start,
                              textAlignVertical: TextAlignVertical.center,
                              autofocus: true,
                              controller: mobileNumberController,
                              maxLength: 10,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: Validators.compose([
                                Validators.minLength(10, 'Min Length is 10'),
                                Validators.required('Mobile no is required'),
                              ]),
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                              decoration: const InputDecoration(
                                  hintText: 'Mobile Number',
                                  counterText: "",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  suffixIcon: Icon(
                                    Icons.phone_android,
                                  ),

                                  //Change this value to custom as you like
                                  isDense: true,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        show_textreferral
                            ? Container(
                                width: screenWidth * .80,
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
                                  child: TextFormField(
                                    // obscureText: true,
                                    textAlignVertical: TextAlignVertical.center,
                                    textAlign: TextAlign.start,
                                    // validator: Validators.compose([
                                    //   Validators.required(
                                    //       'Enter valid Refferal code'),
                                    // ]),
                                    controller: referralCodeController,
                                    decoration: const InputDecoration(
                                      hintText: 'Referral Code (Optional)',
                                      border: InputBorder.none,
                                      focusColor: Colors.blue,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      //Change this value to custom as you like
                                      isDense: true,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                width: screenWidth * .80,
                                child: InkWell(
                                  splashColor: Colors.grey[100],
                                  child: Text(
                                    "Have a Referral code ?",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        letterSpacing: 0.5,
                                        color: _hasBeenPressed
                                            ? AppColors.kPrimaryColor
                                            : Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      show_textreferral = true;
                                      _hasBeenPressed = !_hasBeenPressed;
                                    });
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 40.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              value: checkBoxValue,
                              activeColor: Colors.orange[400],
                              onChanged: (bool newValue) async {
                                setState(() {
                                  checkBoxValue = newValue;
                                });
                              }),
                          InkWell(
                            splashColor: Colors.blue,
                            onTap: () async {
                              if (networkStatus) {
                                await canLaunch(Urls.privacyPolicyurl)
                                    ? await launch(Urls.privacyPolicyurl)
                                    : throw 'Could not Connect';
                              } else {
                                GeneralTools().offlinemessage(
                                  "Check Your Internet connection",
                                  context,
                                );
                              }
                            },
                            child: Text(
                              'Accept Terms & Conditions',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                wordSpacing: .1,
                                decoration: TextDecoration.underline,
                                color: AppColors.linkColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: 30, top: screenheight * .045),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            if (formSignup1.currentState.validate()) {
                              if (checkBoxValue) {
                                setState(() {
                                  isload = true;
                                });
                                if (referralCodeController.text.isEmpty) {
                                  if (networkStatus) {
                                    customerRegistrationnew(
                                            mobileNumberController.text
                                                .toString())
                                        .then((value) => setState(() {
                                              regstatus = value.accStatus;
                                              otpPassed = value.accOtp;
                                              mobilenumber = value.accMobile;
                                            }))
                                        .whenComplete(() {
                                      if (regstatus == 0) {
                                        // mobileNumberController.clear();
                                        setState(() {
                                          isload = false;
                                        });
                                        Navigator.pushReplacementNamed(
                                            context, '/otppage',
                                            arguments: datapassingModel(
                                              mobilenumber,
                                              otpPassed,
                                            ));
                                      } else if (regstatus == 1) {
                                        setState(() {
                                          isload = false;
                                        });
                                        GeneralTools().createSnackBarFailed(
                                            "Already Registered number !",
                                            context);
                                      }
                                    });
                                  } else {
                                    GeneralTools().offlinemessage(
                                      "Check Your Internet connection",
                                      context,
                                    );
                                  }
                                } else {
                                  if (networkStatus) {
                                    customerRegistration(
                                            mobileNumberController.text,
                                            referralCodeController.text)
                                        .then((value) => setState(() {
                                              regstatus = value.accStatus;
                                              otpPassed = value.accOtp;
                                              mobilenumber = value.accMobile;
                                              refferalCode =
                                                  value.accReferralCode;
                                            }))
                                        .whenComplete(() {
                                      if (regstatus == 0) {
                                        setState(() {
                                          isload = false;
                                        });
                                        if (referralCodeController
                                            .text.isNotEmpty) {
                                          if (refferalCode == "true") {
                                            mobileNumberController.clear();
                                            referralCodeController.clear();
                                            Navigator.pushReplacementNamed(
                                                context, '/otppage',
                                                arguments: datapassingModel(
                                                  mobilenumber,
                                                  otpPassed,
                                                ));
                                          } else {
                                            GeneralTools().createSnackBarCommon(
                                                "Please Enter Valid RefferalCode",
                                                context);
                                          }
                                        }
                                        // else {
                                        //   Navigator.pushReplacementNamed(
                                        //       context, '/otppage',
                                        //       arguments: datapassingModel(
                                        //         mobilenumber,
                                        //         otpPassed,
                                        //       ));
                                        // }
                                      } else if (regstatus == 1) {
                                        setState(() {
                                          isload = false;
                                        });
                                        createSnackBarFailed(
                                            "Already Registered number !");
                                      }
                                    });
                                  } else {
                                    GeneralTools().offlinemessage(
                                      "Check Your Internet connection",
                                      context,
                                    );
                                  }
                                }
                              } else {
                                setState(() {
                                  isload = false;
                                });
                                GeneralTools().createSnackBarFailed(
                                    "Accept Terms and Conditions", context);
                              }
                            } else {
                              setState(() {
                                isload = false;
                              });
                            }
                          },
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     top: 30.0,
                  //     right: 50,
                  //   ),
                  //   // child: Row(
                  //   //   mainAxisAlignment: MainAxisAlignment.center,
                  //   //   children: [
                  //   //     Text(
                  //   //       "Already Have An Account?",
                  //   //       style: TextStyle(
                  //   //         color: const Color(0xe5707070),
                  //   //       ),
                  //   //     ),
                  //   //     InkWell(
                  //   //       child: Text(
                  //   //         " Login",
                  //   //         style: TextStyle(
                  //   //             letterSpacing: 1.5,
                  //   //             fontWeight: FontWeight.w900,
                  //   //             color: AppColors.kAccentColor,
                  //   //             fontSize: 18),
                  //   //       ),
                  //   //       onTap: () {
                  //   //         setState(() {
                  //   //           isEnabled = !isEnabled;
                  //   //         });
                  //   //         Navigator.push(
                  //   //           context,
                  //   //           MaterialPageRoute(builder: (context) => LoginPage()),
                  //   //         );
                  //   //       },
                  //   //     )
                  //   //   ],
                  //   // ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createSnackBarFailed(String message) {
    Flushbar(
      message: message,
      messageText: Text(
        message,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
      ),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
    )..show(context);
  }

  Future createSnackBarSuccess(String message) async {
    Flushbar(
      messageText: Text(
        message,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
      ),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.green,
    )..show(context);
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.amberAccent,
            // valueColor: Colors.amber,
          ),
          Container(
              margin: EdgeInsets.only(left: 10), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  Future<void> prefset(String mobilenumber) async {
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await prefs.setString("MOBILE_NUMBER", mobilenumber.toString());

    //print("session$mobilenumber");
  }

  checkNetwork() {
    connectionStatus == ConnectivityStatus.Cellular ||
            connectionStatus == ConnectivityStatus.WiFi
        ? networkStatus = true
        : networkStatus = false;
  }
}
