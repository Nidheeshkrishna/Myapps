import 'dart:async';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matsapp/Modeles/SignUp/datapassingModel.dart';

import 'package:matsapp/Network/OtpVerifiyRest.dart';
import 'package:matsapp/Network/ResendOtpRest.dart';
import 'package:matsapp/Pages/Providers/ConnectivityServices.dart';
import 'package:matsapp/Pages/SignUp/ChooseYourLocation.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:matsapp/widgets/LoginPageWidgets/LoginpageTopWidget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
//import 'package:sms_advanced/sms_advanced.dart';

class OtpAndPasswordPage extends StatefulWidget {
  final datapassingModel arguments;
  OtpAndPasswordPage(this.arguments);

  @override
  _OtpAndPasswordPageState createState() => _OtpAndPasswordPageState();
}

class _OtpAndPasswordPageState extends State<OtpAndPasswordPage> {
  String regstatus;
  bool endTimer = false;
  bool _hasBeenPressed = false;
  bool _hasBeenPressedChangeNumber = false;
  Timer _timer;
  int _start = 60;
///////////////////////////////////bool isload = true;
  bool isload = false;
  String Otp_recived;
  String otpFromDb;
  int resendStatus;

  int count = 0;

  TextEditingController textEditingController = TextEditingController();
  TextEditingController newTextEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  // final SmsQuery query = SmsQuery();
  // List<SmsMessage> messages = [];

  ConnectivityStatus connectionStatus;

  bool networkStatus = false;

  String receivedMsg;
  @override
  void initState() {
    textEditingController.clear();
    super.initState();

    if (count == 0) {
      startTimer();
    }
    if (mounted)
      setState(() {
        otpFromDb = widget.arguments.otp;
        textEditingController.text = "";
      });
    // _smsReceiver = SmsReceiver(onSmsReceived, onTimeout: onTimeout);
    // _startListening();
  }

  // void onSmsReceived(String message) {
  //   setState(() {
  //     textEditingController.text = message;
  //   });
  // }

  // void onTimeout() {}

  // void _startListening() {
  //   _smsReceiver.startListening();
  // }

  @override
  Widget build(BuildContext context) {
    connectionStatus = Provider.of<ConnectivityStatus>(context);
    checkNetwork();
    ////getreadsms();
    //getallsmsd();
    // print(widget.arguments.mobileNumber);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ModalProgressHUD(
      progressIndicator:
          Center(child: SpinKitHourGlass(color: Color(0xffFFB517))),
      inAsyncCall: isload,
      dismissible: false,
      child: Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: screenWidth,
                  height: screenHeight * .30,
                  child: LoginHeaderWidget("OTP Verification"),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Enter OTP ",
                          style: AppTextStyle.titleFont(),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        width: screenWidth * .90,
                        height: screenHeight * .35,
                        child: Container(
                          // decoration: BoxDecoration(
                          //     border: Border(
                          //         bottom: BorderSide(
                          //             color: Colors.orange[300], width: 8))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PinCodeTextField(
                                autoFocus: true,
                                appContext: context,
                                textStyle: TextStyle(
                                  color: AppColors.lightGreyWhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                pastedTextStyle: TextStyle(
                                  color: Colors.purple,
                                  backgroundColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                boxShadows: [
                                  BoxShadow(
                                    offset: Offset(0, 2),
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  )
                                ],
                                hintStyle: TextStyle(
                                  color: Colors.purple,
                                  backgroundColor: AppColors.kAccentColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                length: 5,
                                // obscureText: false,
                                // obscuringCharacter: '*',

                                blinkWhenObscuring: true,
                                animationType: AnimationType.fade,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                pinTheme: PinTheme(
                                    fieldOuterPadding:
                                        EdgeInsets.only(bottom: 20),
                                    activeColor: Colors.amberAccent,
                                    inactiveColor: Colors.grey,
                                    selectedColor: Colors.amberAccent,
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(10),
                                    fieldHeight: screenWidth * .12,
                                    fieldWidth: screenWidth * .12,
                                    activeFillColor: Colors.white,
                                    inactiveFillColor: Colors.white,
                                    selectedFillColor: Colors.white,
                                    borderWidth: 0.5),
                                cursorColor: Colors.black,
                                animationDuration: Duration(milliseconds: 300),
                                enableActiveFill: true,
                                //errorAnimationController: errorController,
                                controller: textEditingController,
                                keyboardType: TextInputType.number,

                                onCompleted: (v) {
                                  setState(() {
                                    otpFromDb = v;
                                  });
                                },

                                onChanged: (value) {
                                  print(value);
                                },
                                beforeTextPaste: (text) {
                                  // print("Allowing to paste $text");
                                  // //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                  // //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                  return true;
                                },
                              ),
                              Container(
                                child: endTimer
                                    ? Text("")
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                            Text("OTP Resend in ",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                )),
                                            Text(
                                              "$_start s",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: AppColors.kAccentColor,
                                                fontSize: 18,
                                              ),
                                            )
                                          ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      endTimer ? "Didn't receive code? " : "",
                                      style: TextStyle(color: kAccentLight),
                                    ),
                                    InkWell(
                                      child: endTimer
                                          ? Text("Resend",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: _hasBeenPressed
                                                      ? Colors.purple
                                                      : Theme.of(context)
                                                          .accentColor,
                                                  fontWeight: FontWeight.bold))
                                          : Text("",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0x55FFB517))),
                                      onTap: () {
                                        if (networkStatus) {
                                          if (count < 2) {
                                            count++;
                                            setState(() {
                                              _hasBeenPressed =
                                                  !_hasBeenPressed;
                                            });
                                            resendOtpfetch(widget
                                                    .arguments.mobileNumber)
                                                .then((value) => {
                                                      textEditingController
                                                          .clear(),
                                                      //getreadsms(),
                                                      setState(() {
                                                        otpFromDb = value
                                                            .result.userOtp;
                                                        resendStatus =
                                                            value.status;
                                                      }),
                                                      if (resendStatus == 1)
                                                        {
                                                          startTimer(),
                                                          GeneralTools()
                                                              .createSnackBarCommon(
                                                                  "Otp Sent to your Mobile",
                                                                  context),
                                                          endTimer = false,
                                                          _start = 60,
                                                          _hasBeenPressed =
                                                              false
                                                        }
                                                      else
                                                        {
                                                          GeneralTools()
                                                              .createSnackBarFailed(
                                                                  "Try again!",
                                                                  context)
                                                        }
                                                    });
                                          } else {
                                            GeneralTools().createSnackBarFailed(
                                                "Please try again after sometime.",
                                                context);
                                          }
                                        } else {
                                          GeneralTools().offlinemessage(
                                            "Check Your Internet connection",
                                            context,
                                          );
                                        }
                                      },
                                    ),

                                    // InkWell(
                                    //   child: Text("Change Number",
                                    //       style: TextStyle(
                                    //           color:
                                    //               _hasBeenPressedChangeNumber
                                    //                   ? Colors.purple
                                    //                   : Theme.of(context)
                                    //                       .accentColor,
                                    //           fontWeight: FontWeight.bold)),
                                    //   onTap: () {
                                    //     setState(() {
                                    //       _hasBeenPressedChangeNumber =
                                    //           !_hasBeenPressedChangeNumber;
                                    //     });
                                    //   },
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            isload = true;
                          });
                          otpVerification(
                            otpFromDb,
                            widget.arguments.mobileNumber,
                          )
                              .then((value) => setState(() {
                                    regstatus = value.status;
                                  }))
                              .whenComplete(() async {
                            if (regstatus == "true") {
                              setState(() {
                                isload = false;
                              });
                              await Future.delayed(Duration(seconds: 1));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChooseYourLocation(
                                        widget.arguments.mobileNumber)),
                              );

                              // Navigator.pushNamed(
                              //     context, '/passwordsettingpage',
                              //     arguments: widget.arguments.mobileNumber);
                            } else if (regstatus == "false") {
                              setState(() {
                                isload = false;
                              });
                              createSnackBarFailed("Otp Mismatch try again..!");
                            } else {
                              setState(() {
                                isload = false;
                              });
                            }
                          });
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
    );
  }

  startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          if (mounted) {
            setState(() {
              timer.cancel();
              endTimer = true;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              endTimer = false;
              _start--;
            });
          }
        }
      },
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

  // getallsmsd() {
  //   print(messages.first.kind);
  //   if (messages.isNotEmpty) {
  //     receivedMsg = messages.first.body.replaceAll(new RegExp(r'[^0-9]'), '');

  //     // '23'

  //     if (otpFromDb == receivedMsg) {
  //       setState(() {
  //         isload = false;
  //         textEditingController.text = receivedMsg;
  //       });
  //     } else {
  //       isload = false;
  //       //newTextEditingController.text = "";
  //     }
  //   } else {
  //     isload = false;
  //     //newTextEditingController.text = "";
  //   }

  //   // print(receivedMsg);
  // }

  // getreadsms() async {
  //   // await query.querySms(kinds: [SmsQueryKind.Inbox, SmsQueryKind.Sent]);

  //   messages = await query.querySms();
  //   var now = new DateTime.now();

  //   if (messages.first.kind == SmsMessageKind.Received) {
  //     if (messages.first.body.contains("--MATSAPP")) {
  //       if (now.isAfter(messages.first.date) ||
  //           now.isAtSameMomentAs(messages.first.date)) {
  //         getallsmsd();
  //       } else {
  //         isload = false;
  //         //newTextEditingController.text = "";
  //       }
  //     } else {
  //       isload = false;
  //       //newTextEditingController.text = "";
  //     }
  //   } else {
  //     isload = false;
  //     //newTextEditingController.text = "";
  //   }
  // }

  checkNetwork() {
    connectionStatus == ConnectivityStatus.Cellular ||
            connectionStatus == ConnectivityStatus.WiFi
        ? networkStatus = true
        : networkStatus = false;
  }
}
