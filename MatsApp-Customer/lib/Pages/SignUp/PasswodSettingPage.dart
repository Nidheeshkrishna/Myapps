import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matsapp/Modeles/SqlLiteTableDataModel.dart';
import 'package:matsapp/Network/CompleteRegisterationRest.dart';
import 'package:matsapp/Pages/MainHomePage.dart';
import 'package:matsapp/Pages/Providers/ConnectivityServices.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/widgets/LoginPageWidgets/LoginpageTopWidget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordSettingPage extends StatefulWidget {
  final mobilenumber;
  final String chosendistrict, chosentown, chosenSubtown, locationName;
  PasswordSettingPage(this.mobilenumber, this.chosendistrict, this.chosentown,
      this.locationName, this.chosenSubtown,
      [String string]);
  @override
  _PasswordSettingPageState createState() => _PasswordSettingPageState();
}

class _PasswordSettingPageState extends State<PasswordSettingPage> {
  final form = new GlobalKey<FormState>();
  TextEditingController confirmpasswordController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  SharedPreferences prefs;
  //String mobilenumber_passed;
  DatabaseHelper dbHelper = new DatabaseHelper();
  UserInfo userinfo;
  Future fetchdestrictFuture;
  Future townFuture;
  bool _isHidden = true;
  // Toggles the password show status
  // ignore: non_constant_identifier_names
  int registertion_status;

  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names

  bool isload = false;

  String _deviceId;
  FocusNode _focus = new FocusNode();
  String deviceToken;

  ConnectivityStatus connectionStatus;

  bool networkStatus = false;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void initState() {
    //fetchdestrictFuture = getDistrict("kerala");
    super.initState();

    //initPlatformState();
    // prefcheck();

    SharedPreferences.getInstance().then((prefs) {
      SharedPreferences sharedPrefs;
      setState(() => sharedPrefs = prefs);
      setState(() {
        //townSelectedStore = sharedPrefs.getString('SELECTED_TOWN');
        //mobileNumber = sharedPrefs.getString('USER_MOBILE');
        deviceToken = sharedPrefs.getString('USER_API_Token');
        print("Token $deviceToken");
      });

      //hotSpotsFuture = fetchHotSpot(townSelectedStore);
    });
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focus.hasFocus) {
      if (!GeneralTools()
          .validatePassword(passwordController.text.toString())) {
        validatorPasswordDialoge(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    connectionStatus = Provider.of<ConnectivityStatus>(context);
    checkNetwork();
    return ModalProgressHUD(
      progressIndicator:
          Center(child: SpinKitHourGlass(color: Color(0xffFFB517))),
      inAsyncCall: isload,
      dismissible: false,
      child: Scaffold(
        body: Form(
            key: form,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Container(
                        width: screenWidth,
                        height: screenHeight,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: screenWidth,
                                  height: screenHeight * .30,
                                  child: LoginHeaderWidget("Set Password")),
                              Padding(
                                padding: const EdgeInsets.only(top: 70.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      width: screenWidth * .70,
                                      height: screenHeight / 15,
                                      // padding: EdgeInsets.only(
                                      //     bottom: 5, left: .75, right: .75),
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
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.white,
                                        ),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          obscureText: _isHidden,
                                          obscuringCharacter: "*",
                                          textAlign: TextAlign.center,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          // autofocus: true,
                                          // focusNode: _focus,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return "Password Required";
                                            } else if (value.length < 3) {
                                              return "Minimum length is 3";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: passwordController,
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
                                            hintText: 'Password',
                                            hintStyle:
                                                TextStyle(color: Colors.grey),

                                            //Change this value to custom as you like
                                            isDense: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: screenWidth * .70,
                                      height: screenHeight / 15,
                                      // padding: EdgeInsets.only(
                                      //     bottom: 5, left: .75, right: .75),
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
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.white,
                                        ),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign
                                              .center, //Change this value to custom as you like
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return "Re Enter Password";
                                            } else if (value !=
                                                passwordController.text
                                                    .toString()) {
                                              return "Password is Not Same ";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: confirmpasswordController,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Confirm PassWord',
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            isDense: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 30, bottom: 20, top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    FloatingActionButton(
                                      onPressed: () {
                                        print(widget.mobilenumber);
                                        if (form.currentState.validate()) {
                                          setState(() {
                                            isload = true;
                                          });

                                          if (networkStatus) {
                                            customerCompleteRegistration(
                                                    widget.mobilenumber,
                                                    confirmpasswordController
                                                        .text,
                                                    "kerala",
                                                    widget.chosendistrict,
                                                    widget.chosentown,
                                                    widget.chosenSubtown,
                                                    deviceToken)
                                                .then((value) async => {
                                                      if (value.accStatus == 1)
                                                        {
                                                          setState(() {
                                                            isload = false;
                                                          }),
                                                          userinfo = UserInfo(
                                                            userid: value.accId,
                                                            mobilenumber:
                                                                value.accMobile,
                                                            location:
                                                                value.townName,
                                                            selectedTown:
                                                                value.accTown,
                                                            state: "Kerala",
                                                            district: value
                                                                .accDistrict,
                                                            subtown: value
                                                                .accSubTown,
                                                            apitoken:
                                                                value.accApiKey,
                                                            islogeddIn: "true",
                                                            userType:
                                                                value.usertype,
                                                          ),
                                                          dbHelper.saveUser(
                                                              userinfo),
                                                          GeneralTools()
                                                              .createSnackBarSuccess(
                                                                  "Registered successfully..!",
                                                                  context),
                                                          await Future.delayed(
                                                              Duration(
                                                                  seconds: 1)),
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        MainHomePage()),
                                                          )
                                                          //clerPreferance();
                                                        }
                                                      else if (value
                                                              .accStatus ==
                                                          0)
                                                        {
                                                          setState(() {
                                                            isload = false;
                                                          }),
                                                          GeneralTools()
                                                              .createSnackBarFailed(
                                                                  "Already Registered",
                                                                  context),
                                                        }
                                                    });
                                          } else {
                                            setState(() {
                                              isload = false;
                                            });
                                            GeneralTools().offlinemessage(
                                              "No Internet Connection",
                                              context,
                                            );
                                          }
                                        } else {
                                          setState(() {
                                            isload = false;
                                          });
                                        }
                                      },
                                      backgroundColor:
                                          Theme.of(context).accentColor,
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
                ],
              ),
            )),
      ),
    );
  }

  prefcheck() async {
    // ignore: invalid_use_of_visible_for_testing_member
    //SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();

    setState(() {
      //mobilenumber_passed = prefs.getString('MOBILE_NUMBER');
    });
    //dynamic token = await FlutterSession().get("CustId");

    //print("cid$cid");
  }

  //SharedPreferences preferences = await SharedPreferences.getInstance();
  clerPreferance() async {
    prefs.clear();
  }

  List<String> _states = ['Kerala'];

  // Platform messages are asynchronous, so we initialize in an async method.

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

  checkNetwork() {
    connectionStatus == ConnectivityStatus.Cellular ||
            connectionStatus == ConnectivityStatus.WiFi
        ? networkStatus = true
        : networkStatus = false;
  }
}
