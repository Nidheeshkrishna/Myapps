import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matsapp/Network/SetnewForgotPasswordRest.dart';

import 'package:matsapp/Pages/Login/LoginPage.dart';
import 'package:matsapp/Pages/Providers/ConnectivityServices.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/widgets/LoginPageWidgets/LoginpageTopWidget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class setNewpasswordpage extends StatefulWidget {
  final String passed_mobilenumber;
  setNewpasswordpage(this.passed_mobilenumber);
  @override
  _ForgotPassWordPageState createState() => _ForgotPassWordPageState();
}

class _ForgotPassWordPageState extends State<setNewpasswordpage> {
  TextEditingController confirmpasswordController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  var checkBoxValue = false;

  var userNameController;
  bool _isHidden = true;
  // Toggles the password show status
  int registertionStatus;

  bool isload;

  var connectionStatus;

  bool networkStatus = false;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
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
      body: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          strokeWidth: 10,
          backgroundColor: Colors.cyanAccent[100],
          valueColor:
              new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
        ),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: screenWidth,
                    height: screenHeight * .30,
                    child: LoginHeaderWidget("Forgot Password"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 40.0),
                    child: Center(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Set Password",
                              style: AppTextStyle.titleFont1(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: screenWidth * .80,
                          // padding: EdgeInsets.only(
                          //     bottom: .75, left: .75, right: .75),
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
                              textAlign: TextAlign.left,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              validator: Validators.compose([
                                Validators.required('Password is required'),
                                Validators.minLength(3, 'Minimum 3 characters'),
                              ]),
                              controller: passwordController1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,

                                suffixIcon: InkWell(
                                  onTap: _togglePasswordView,
                                  child: Icon(
                                    _isHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),

                                //Change this value to custom as you like
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                // focusedBorder: UnderlineInputBorder(
                                //   borderSide: BorderSide(
                                //       color: Colors.orange, width: 8),
                                //   //  when the TextFormField in focused
                                // ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: screenWidth * .80,
                          // padding: EdgeInsets.only(
                          //     bottom: .75, left: .75, right: .75),
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
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign
                                  .left, //Change this value to custom as you like

                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Re Enter Password";
                                }
                                // } else if (value.length < 8) {
                                //   return "Password must be atleast 8 characters long";
                                // }
                                else if (value !=
                                    passwordController1.text.toString()) {
                                  return "Password must be same as above";
                                } else {
                                  return null;
                                }
                              },
                              controller: confirmpasswordController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,

                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(color: Colors.grey),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                // focusedBorder: UnderlineInputBorder(
                                //   borderSide: BorderSide(
                                //       color: Colors.orange, width: 8),
                                //  when the TextFormField in focused
                                //),
                              ),
                            ),
                          ),
                        ),
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
                              forgotPasswordset(widget.passed_mobilenumber,
                                      passwordController1.text.toString())
                                  .then((value) =>
                                      registertionStatus = value.result)
                                  .whenComplete(() async => {
                                        if (registertionStatus != 0)
                                          {
                                            //mobileNumberController.clear(),
                                            setState(() {
                                              isload = false;
                                            }),
                                            GeneralTools()
                                                .createSnackBarSuccess(
                                                    "Password Changed",
                                                    context),
                                            await Future.delayed(
                                                Duration(seconds: 1)),
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage()))
                                          }
                                        else
                                          {
                                            setState(() {
                                              isload = false;
                                            }),
                                            GeneralTools().createSnackBarFailed(
                                                "Incorrect Mobile Number",
                                                context)
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

  checkNetwork() {
    connectionStatus == ConnectivityStatus.Cellular ||
            connectionStatus == ConnectivityStatus.WiFi
        ? networkStatus = true
        : networkStatus = false;
  }
}
