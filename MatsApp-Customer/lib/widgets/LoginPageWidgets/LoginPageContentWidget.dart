import 'dart:async';
import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matsapp/Modeles/SqlLiteTableDataModel.dart';
import 'package:matsapp/Network/LoginRest.dart';
import 'package:matsapp/Network/newloginpage.dart';
import 'package:matsapp/Pages/HomePages/MainHomePage.dart';
import 'package:matsapp/Pages/Login/Login_Location.dart';
import 'package:matsapp/Pages/Providers/ConnectivityServices.dart';

import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';

import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/NetworkStatusService.dart';
import 'package:matsapp/utilities/connectionStatus.dart';
import 'package:matsapp/utilities/firebase_util.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class LoginPageContentWidget extends StatefulWidget {
  @override
  _LoginPageContentWidgetState createState() => _LoginPageContentWidgetState();
}

class _LoginPageContentWidgetState extends State<LoginPageContentWidget> {
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ProgressDialog pr;
  String deviceToken;
  final passwordFocus = FocusNode();
  final mobileFocus = FocusNode();

  final Connectivity _connectivity = Connectivity();

  //TextEditingController passwordController;
  BuildContext scaffoldContext;
  final _form = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  int user_status;
  int forgotpassword_satus;

  UserInfo product;

  bool isload = false;
  int user_id;
  String userMobile;
  String user_town;
  String apiKey, userType;
  DatabaseHelper dbHelper = new DatabaseHelper();
  SharedPreferences prefs;
  bool _hasBeenPressed = false;
  bool _isHidden = true;

  String _username;

  String _userTown;

  double userLatitude;

  double userLogitude;

  bool isOffline = false;

  var status_code1;

  bool isEnabled = false;

  UserInfo userinfo;

  ConnectivityStatus connectionStatus;

  bool networkStatus = false;

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

  @override
  void initState() {
    dbHelper.initDb();
    setupFirebase();
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

    super.initState();
    //userNameController = TextEditingController(text: "9946185174");
    //passwordController = TextEditingController(text: "Veeru@25");
  }

  @override
  void dispose() {
    passwordFocus.dispose();
    mobileFocus.dispose();
    passwordController.clear();
    userNameController.clear();
    super.dispose();
  }

  void clearText() {
    passwordController.clear();
    userNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    //UserInfo userinfo;
    WidgetsFlutterBinding.ensureInitialized();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height -
        kToolbarHeight -
        MediaQuery.of(context).padding.top;
    connectionStatus = Provider.of<ConnectivityStatus>(context);
    checkNetwork();
    return Container(
      width: screenWidth,
      height: screenHeight,
      child: ModalProgressHUD(
        progressIndicator:
            Center(child: SpinKitHourGlass(color: Color(0xffFFB517))),
        inAsyncCall: isload,
        dismissible: false,
        opacity: 0,
        child: Padding(
          padding: EdgeInsets.only(
              left: 25.0, top: screenHeight * .02, right: 25, bottom: 20),
          child: Form(
            key: _form,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Login',
                  style: AppTextStyle.titleFont(),
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.01),
                  child: Text('Welcome to MatsApp',
                      style: AppTextStyle.titleFont2()),
                ),
                SizedBox(height: screenHeight * 0.03),
                Container(
                    // padding:
                    //     EdgeInsets.only(bottom: 3, left: .75, right: .75),
                    padding: EdgeInsets.only(bottom: 0, left: 0, right: 0),
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
                        padding: EdgeInsets.only(left: 20, right: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16),
                            textAlign: TextAlign.left,
                            textAlignVertical: TextAlignVertical.center,
                            //keyboardType: TextInputType.phone,
                            controller: userNameController,
                            // autofocus: true,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            onSaved: (val) => _username = val,
                            validator: Validators.compose([
                              Validators.minLength(10, 'Minimum Length is 10'),
                              Validators.required('Mobile no is required'),
                            ]),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Mobile number',
                              hintStyle: TextStyle(color: Colors.grey),
                              suffixIcon: Icon(
                                Icons.phone_android,
                                //color: AppColors.kPrimaryColor,
                              ),
                              //isDense: true,
                            )))),
                SizedBox(height: 12),
                Container(
                    // padding:
                    //     EdgeInsets.only(bottom: 3, left: .75, right: .75),
                    padding: EdgeInsets.only(bottom: 0, left: 0, right: 0),
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
                        padding: EdgeInsets.only(left: 20, right: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                            onSaved: (val) => _userTown = val,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16),
                            obscureText: _isHidden,
                            obscuringCharacter: ".",
                            textAlign: TextAlign.left,
                            textAlignVertical: TextAlignVertical.center,
                            //keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            validator: (value) =>
                                value.isEmpty ? 'Enter your Password' : null,
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.grey),
                              suffixIcon: InkWell(
                                  child: Icon(
                                    _isHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    //color: AppColors.kPrimaryColor,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _isHidden = !_isHidden;
                                    });
                                  }),
                              //isDense: true,
                            )))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.02, right: screenWidth * 0.01),
                      child: RichText(
                          text: TextSpan(
                        text: 'Forgot Password ?',
                        style: TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500,
                            color: _hasBeenPressed
                                ? Colors.purple
                                : const Color(0xe5707070),
                            fontSize: 14),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              _hasBeenPressed = !_hasBeenPressed;
                            });
                            loginCustomer(
                                    userNameController.text.toString(),
                                    passwordController.text.toString(),
                                    deviceToken)
                                .then((value) =>
                                    forgotpassword_satus = value.accVerified)
                                .whenComplete(() => {
                                      Navigator.pushNamed(
                                          context, '/forgotpasswordpage')
                                    });
                          },
                      )),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FloatingActionButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 24,
                          color: Colors.white,
                        ),
                        elevation: 3,
                        onPressed: () async {
                          if (_form.currentState.validate()) {
                            if (networkStatus) {
                              setState(() {
                                isload = true;
                              });
                              loginCustomer(
                                      userNameController.text.toString(),
                                      passwordController.text.toString(),
                                      deviceToken)
                                  .then((value) => {
                                        //status_code1 = value["statuscode"],
                                        if (value.accApiKey != null &&
                                            value.accApiKey.isNotEmpty)
                                          {
                                            user_status = value.status,
                                            user_id = value.accId,
                                            userMobile = value.accMobile,
                                            user_town = value.accTown,
                                            apiKey = value.accApiKey,
                                            userType = value.userType,

                                            print(apiKey),
                                            // dbHelper
                                            //     .getAll()
                                            //     .then((value1) => {
                                            //           if (value1.length > 0)
                                            //             {
                                            //               dbHelper
                                            //                   .deleteUser(),
                                            //             }
                                            //         }),

                                            //userid TEXT PRIMARY KEY, mobilenumber TEXT,location TEXT, selected_town TEXT,selected_state TEXT,selected_district TEXT,apitoken Text,islogeddIn bool
                                            userinfo = UserInfo(
                                              userid: user_id,
                                              mobilenumber: userMobile,
                                              location: value.townName,
                                              selectedTown: user_town,
                                              state: "Kerala",
                                              district: value.accDistrict,
                                              subtown: value.accSubTown,
                                              apitoken: apiKey,
                                              islogeddIn: "true",
                                              userType: userType,
                                            ),
                                            dbHelper.saveUser(userinfo),
                                            //Navigator.pop(context),
                                          }
                                        else
                                          {
                                            GeneralTools().createSnackBarFailed(
                                              "Invalid User Name Or Password!!",
                                              context,
                                            )
                                          },
                                      })
                                  .whenComplete(() => {
                                        if (user_status == 1)
                                          {
                                            setState(() {
                                              isload = false;
                                            }),
                                            GeneralTools()
                                                .createSnackBarSuccess(
                                                  "Login Successfull",
                                                  context,
                                                  
                                                )
                                                .then((value) async => {
                                                      // _getCurrentLocation(),
                                                      await Future.delayed(
                                                          Duration(seconds: 1)),

                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MainHomePage()),
                                                      ).whenComplete(
                                                        () => clearText(),
                                                      )
                                                    })
                                          }
                                        else if (user_status == 0)
                                          {
                                            setState(() {
                                              isload = false;
                                            }),
                                            GeneralTools().createSnackBarFailed(
                                              "Invalid User Name Or Password!!",
                                              context,
                                            )
                                          }
                                        else
                                          {
                                            setState(() {
                                              isload = false;
                                            }),
                                            //Navigator.pop(context),
                                          }
                                      });
                            } else {
                              GeneralTools().offlinemessage(
                                "Check Your Internet connection",
                                context,
                              );
                            }
                          } else {
                            setState(() {
                              isload = false;
                            });
                          }
                        },
                      )
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 40.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       Align(
                //         alignment: FractionalOffset.bottomCenter,
                //         child: RichText(
                //             text: TextSpan(
                //                 text: 'New User?',
                //                 style: TextStyle(
                //                     letterSpacing: 1.25,
                //                     fontWeight: FontWeight.w400,
                //                     color: AppColors.kSecondaryDarkColor,
                //                     fontSize: 16),
                //                 recognizer: TapGestureRecognizer(),
                //                 children: <TextSpan>[
                //               TextSpan(
                //                   text: ' Join Now',
                //                   style: TextStyle(
                //                       letterSpacing: 1.5,
                //                       fontWeight: FontWeight.w900,
                //                       /*color: isEnabled
                //                         ? Colors.blue
                //                         : Colors.purple,*/
                //                       color: AppColors.kAccentColor,
                //                       fontSize: 18),
                //                   recognizer: TapGestureRecognizer()
                //                     ..onTap = () {
                //                       setState(() {
                //                         isEnabled = !isEnabled;
                //                       });
                //                       Navigator.pushNamed(
                //                         context,
                //                         '/signUp2',
                //                       );
                //                     })
                //             ])),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
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

  void showInSnackBar(String value) {
    //Navigator.pop(context);
    Flushbar(
      icon: Icon(
        Icons.check_circle_outlined,
        color: Colors.white,
      ),
      messageText: Text(
        value,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
    )..show(context);
  }

  Future<void> prefsetLoginInfo(String selected_Town) async {
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    await prefs.setString("Selected_Town", selected_Town.toString());

    print("session$selected_Town");
  }

  Future<void> prefsetPremiumUser(bool premiumUser) async {
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await prefs.setBool("PremiumUser", premiumUser);

    //print("session$mobilenumber");
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
  }

  checkNetwork() {
    connectionStatus == ConnectivityStatus.Cellular ||
            connectionStatus == ConnectivityStatus.WiFi
        ? networkStatus = true
        : networkStatus = false;
  }
}
