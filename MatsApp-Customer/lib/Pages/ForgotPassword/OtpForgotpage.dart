import 'dart:async';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matsapp/Network/OtpVerifiyRest.dart';
import 'package:matsapp/Network/ResendOtpRest.dart';

import 'package:matsapp/Pages/ForgotPassword/setNewpasswordpage.dart';
import 'package:matsapp/Pages/Providers/ConnectivityServices.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/widgets/LoginPageWidgets/LoginpageTopWidget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';


class OtpForgotPasswordPage extends StatefulWidget {
  final String passedmobilenumber;
  final String passedOtp;
  OtpForgotPasswordPage(this.passedmobilenumber, this.passedOtp);

  @override
  _OtpAndPasswordPageState createState() => _OtpAndPasswordPageState();
}

class _OtpAndPasswordPageState extends State<OtpForgotPasswordPage> {
  //List<SmsMessage> messages = [];
  var regstatus;
  // String user_otp;
  bool _hasBeenPressed = false;
  bool _hasBeenPressedChangeNumber = false;

  bool isload = false;

  Timer _timer;

  int _start = 60;

  int count = 0;

  bool endTimer = false;

  var otpFromDb;

  int resendStatus;

  String user_otp;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  TextEditingController newTextEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  CountdownTimerController controller;
//   SmsReceiver _smsReceiver;
//  final SmsQuery query = SmsQuery();

  ConnectivityStatus connectionStatus;

  bool networkStatus = false;
  bool disposeStatus = true;

  String receivedMsg;
  @override
  void dispose() {
    _timer.cancel();
    newTextEditingController.clear();
    super.dispose();
    setState(() {
      disposeStatus = false;
    });
  }

  void initState() {
    super.initState();
    if (count == 0) {
      startTimer();
    }
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);

    setState(() {
      otpFromDb = widget.passedOtp;
      // newTextEditingController.text = "";
      // receivedMsg = "";
    });
    // _smsReceiver = SmsReceiver(onSmsReceived, onTimeout: onTimeout);
    // _startListening();
  }

  void onEnd() {
    print('onEnd');
  }

  // void onSmsReceived(String message) {
  //   setState(() {
  //     newTextEditingController.text = message;
  //   });
  // }

  // void onTimeout() {}

  // void _startListening() {
  //   _smsReceiver.startListening();
  // }

  @override
  Widget build(BuildContext context) {
    //newTextEditingController.text = "";
    //getallsmsd();
    // if (disposeStatus) {
    //   getreadsms();
    // }

    connectionStatus = Provider.of<ConnectivityStatus>(context);
    checkNetwork();

    print(widget.passedmobilenumber);
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
        child: Container(
          width: screenWidth,
          height: screenHeight,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: screenWidth,
                  height: screenHeight * .20,
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
                        // child: Card(
                        //   elevation: 5,
                        //   clipBehavior: Clip.antiAliasWithSaveLayer,
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(30)),
                        // child: Container(
                        // decoration: BoxDecoration(
                        //     border: Border(
                        //         bottom: BorderSide(
                        //             color: Colors.orange[300], width: 8))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            PinCodeTextField(
                              appContext: context,
                              autoFocus: true,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              pinTheme: PinTheme(
                                  fieldOuterPadding:
                                      EdgeInsets.only(bottom: 20),
                                  activeColor: Colors.amberAccent,
                                  inactiveColor: Colors.grey,
                                  selectedColor: Colors.amberAccent,
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(10),
                                  fieldHeight: 50,
                                  fieldWidth: 40,
                                  activeFillColor: Colors.white,
                                  inactiveFillColor: Colors.white,
                                  selectedFillColor: Colors.white,
                                  borderWidth: 0.5),
                              cursorColor: Colors.black,
                              animationDuration: Duration(milliseconds: 300),

                              enableActiveFill: true,
                              //errorAnimationController: errorController,
                              controller: newTextEditingController,
                              keyboardType: TextInputType.number,

                              onCompleted: (v) {
                                setState(() {
                                  user_otp = v;
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
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                        //newTextEditingController.text = "";
                                        setState(() {
                                          isload = true;
                                        });
                                        if (count < 2) {
                                          count++;
                                          setState(() {
                                            _hasBeenPressed = !_hasBeenPressed;
                                          });
                                          resendOtpfetch(
                                                  widget.passedmobilenumber)
                                              .then((value) => {
                                                    //getreadsms(),
                                                    setState(() {
                                                      otpFromDb =
                                                          value.result.userOtp;
                                                      resendStatus =
                                                          value.status;
                                                    }),

                                                    // String otp=value.result.userOtp,
                                                    if (resendStatus == 1)
                                                      {
                                                        startTimer(),
                                                        GeneralTools()
                                                            .createSnackBarCommon(
                                                                "Otp Sent to your Mobile",
                                                                context),
                                                        endTimer = false,
                                                        _start = 60,
                                                        _hasBeenPressed = false
                                                      }
                                                    else
                                                      {
                                                        setState(() {
                                                          isload = false;
                                                        }),
                                                        GeneralTools()
                                                            .createSnackBarFailed(
                                                                "Try again!",
                                                                context)
                                                      }
                                                  });
                                        } else {
                                          setState(() {
                                            isload = false;
                                          });
                                          GeneralTools().createSnackBarFailed(
                                              "Please try again after sometime.",
                                              context);
                                        }
                                      }),

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
                      //),
                      //),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () async {
                          if (networkStatus) {
                            setState(() {
                              isload = true;
                            });

                            otpVerification(
                              user_otp,
                              widget.passedmobilenumber,
                            ).then((value) async => {
                                  regstatus = value.status,
                                  if (regstatus == "true")
                                    {
                                      setState(() {
                                        isload = false;
                                      }),
                                      newTextEditingController.clear(),
                                      await Future.delayed(
                                          Duration(seconds: 1)),
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                setNewpasswordpage(
                                                    widget.passedmobilenumber),
                                          ))
                                    }
                                  else if (regstatus == "false")
                                    {
                                      setState(() {
                                        isload = false;
                                      }),
                                      GeneralTools().createSnackBarFailed(
                                          "Otp Mismatch Try Again", context),
                                    }
                                });
                          } else {
                            GeneralTools().offlinemessage(
                              "Check Your Internet connection",
                              context,
                            );
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
    );
  }

  startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            endTimer = true;
          });
        } else {
          setState(() {
            endTimer = false;
            _start--;
          });
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
  //         newTextEditingController.text = receivedMsg;
  //       });
  //     } else {
  //       isload = false;
  //       //newTextEditingController.text = "";
  //     }
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
  //       }
  //     }
  //   }
  // }

  checkNetwork() {
    connectionStatus == ConnectivityStatus.Cellular ||
            connectionStatus == ConnectivityStatus.WiFi
        ? networkStatus = true
        : networkStatus = false;
  }
}
