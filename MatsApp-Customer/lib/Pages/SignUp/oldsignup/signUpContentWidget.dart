import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matsapp/Modeles/SignUp/datapassingModel.dart';

import 'package:matsapp/Network/RegistrationRest.dart';
import 'package:matsapp/Pages/Login/LoginPage.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class SignUpContentWidget extends StatefulWidget {
  @override
  _SignUpContentWidgetState createState() => _SignUpContentWidgetState();
}

class _SignUpContentWidgetState extends State<SignUpContentWidget> {
  final formSignup = GlobalKey<FormState>();

  var checkBoxValue = false;
  TextEditingController userNameController = TextEditingController();
  bool _hasBeenPressed = false;

  bool isload = false;

  int regstatus;

  String otpPassed;

  String mobilenumber;

  SharedPreferences prefs;

  bool isRed = false;
  @override
  void dispose() {
    userNameController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          strokeWidth: 10,
          backgroundColor: Colors.cyanAccent[50],
          valueColor:
              new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
        inAsyncCall: isload,
        opacity: 0,
        //color: Colors.white,
        dismissible: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 40.0, top: 60),
          child: SingleChildScrollView(
            child: Form(
              key: formSignup,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Sign up", style: AppTextStyle.titleFont()),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Text("Welcome To MatsApp",
                            style: AppTextStyle.titleFont2()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth * .80,
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
                            padding: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              textAlignVertical: TextAlignVertical.center,
                              autofocus: true,
                              maxLength: 10,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: Validators.compose([
                                Validators.minLength(
                                    10, 'Minimum Length is 10'),
                                Validators.maxLength(10, 'Max Length is 10'),
                                Validators.required('Mobile no is required'),
                              ]),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal),
                              controller: userNameController,
                              decoration: const InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                border: InputBorder.none,
                                hintText: 'Mobile Number',
                                counterText: "",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                ),
                                suffixIcon: Icon(
                                  Icons.phone_android,
                                ),

                                //Change this value to custom as you like
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    width: screenWidth * .80,
                    height: screenHeight / 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
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
                              _hasBeenPressed = !_hasBeenPressed;
                            });
                            Navigator.pushNamed(context, '/signUp2');
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: checkBoxValue,
                            activeColor: Colors.orange[400],
                            onChanged: (bool newValue) {
                              setState(() {
                                checkBoxValue = newValue;
                              });
                            }),
                        Text(
                          'Accept Terms & Conditions',
                          style: TextStyle(
                            color: const Color(0xf5707070),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            if (formSignup.currentState.validate()) {
                              if (checkBoxValue) {
                                setState(() {
                                  isload = true;
                                });
                                customerRegistrationnew(
                                        userNameController.text.toString())
                                    .then((value) => setState(() {
                                          regstatus = value.accStatus;
                                          otpPassed = value.accOtp;
                                          mobilenumber = value.accMobile;
                                        }))
                                    .whenComplete(() {
                                  if (regstatus == 0) {
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
                                        "Already Registered number !", context);
                                  }
                                });
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
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30.0,
                      right: 50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already Have An Account? ",
                          style: TextStyle(
                            color: const Color(0xe5707070),
                          ),
                        ),
                        InkWell(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w900,
                                /*color: isEnabled
                                          ? Colors.blue
                                          : Colors.purple,*/
                                color: AppColors.kAccentColor,
                                fontSize: 18),
                          ),
                          onTap: () {
                            setState(() {
                              isRed = !isRed;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> prefset(String mobilenumber) async {
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    await prefs.setString("MOBILE_NUMBER", mobilenumber.toString());

    //print("session$mobilenumber");
  }
}
