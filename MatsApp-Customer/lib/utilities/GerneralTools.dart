import 'dart:async';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:matsapp/Pages/Login/LoginPage.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DatabaseHelper.dart';

class GeneralTools {
  final Location location = Location();

  PermissionStatus _permissionGranted;

  SharedPreferences prefs, prefsToken;

  SharedPreferences prefs1;

  Future createSnackBarCommon(String message, BuildContext context) async {
    Flushbar(
      message: message,
      messageText: Center(
        child: Text(
          message,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
      ),
      duration: Duration(seconds: 1),
      backgroundColor: Theme.of(context).accentColor,
    )..show(context);
  }

  Future offlinemessage(String message, BuildContext context) async {
    Flushbar(
      message: message,
      icon: Icon(
        Icons.cloud_off_outlined,
        color: Colors.white,
      ),
      messageText: Center(
        child: Text(
          message,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
      ),
      duration: Duration(seconds: 1),
      backgroundColor: Colors.grey[600],
    )..show(context);
  }

  Future createSnackBarFailed(String message, BuildContext context) async {
    Flushbar(
      message: message,
      icon: Icon(
        Icons.warning,
        color: Colors.white,
      ),
      messageText: Center(
        child: Text(
          message,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
    )..show(context);
  }

  Future createSnackBarSuccess(String message, BuildContext context) async {
    Flushbar(
      icon: Icon(
        Icons.check_circle_outlined,
        color: Colors.white,
      ),
      messageText: Center(
        child: Text(
          message,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
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

  static Future<bool> checkInternet() async {
    bool isconnected;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isconnected = true;
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      isconnected = false;
    }
    return isconnected;
  }

  // ignore: missing_return
  Future<void> showMessageSuccess(BuildContext context, String msg) async {
    //await Future.delayed(Duration(seconds: 2));
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> showMessageFailed(BuildContext context, String msg) async {
    //await Future.delayed(Duration(seconds: 1));
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // Future<void> checkPermissions() async {
  //   final PermissionStatus permissionGrantedResult =
  //       await location.hasPermission();
  //   if (_permissionGranted != PermissionStatus.granted) {
  //     requestPermission();
  //   }
  // }

  // Future<void> requestPermission() async {
  //   if (_permissionGranted != PermissionStatus.granted) {
  //     final PermissionStatus permissionRequestedResult =
  //         await location.requestPermission();
  //   }
  // }

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

  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  loadingWidget(BuildContext context) {
    CircularProgressIndicator(
      strokeWidth: 10,
      backgroundColor: Colors.cyanAccent[100],
      valueColor:
          new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
    );
  }

  loaders() {
    SpinKitHourGlass(color: Color(0xffFFB517));
  }

  Future<void> prefsetLoginInfo(
      String userId, String selectedTown, String userApikey) async {
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    await prefs.setString("SELECTED_TOWN", selectedTown.toString());
    //await prefs.setInt("USER_STATUS", status);

    await prefs.setString("USER_MOBILE", userId.toString());
    await prefs.setString("USER_API_KEY", userApikey.toString());

    // await prefs.setString("SELECTED_STATE", login.accState);
    // await prefs.setString("SELECTED_DISTRICT", login.accDistrict);
    // await prefs.setInt("USER_ID", login.accId);

    // LoginUserInfo().setstatus = status;
    // LoginUserInfo().setuserName = userId;
    // LoginUserInfo().setuserTown = selectedTown;

    //print("session$selected_Town");
  }

  Future<void> userLocationInfo(double latitude, double logitude) async {
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    prefs1 = await SharedPreferences.getInstance();
    // prefsLocation = await SharedPreferences.getInstance();
    await prefs1.setDouble("USER_LATITUDE", latitude);
    await prefs1.setDouble("USER_LOGITUDE", logitude);
  }

  Future exitApp(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirm Exit"),
            content: Text("Are you sure you want to exit?"),
            actions: <Widget>[
              TextButton(
                child: Text("YES"),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
              TextButton(
                child: Text("NO"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future logOut(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirm Log Out"),
            content: Text("Are you sure you want to log out?"),
            actions: <Widget>[
              TextButton(
                child: Text("YES"),
                onPressed: () {
                  DatabaseHelper dbHelper = new DatabaseHelper();
                  dbHelper.deleteUser();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
                },
              ),
              TextButton(
                child: Text("NO"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future loctionwarning(BuildContext context) async {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
            width: width,
            height: height,
            child: AlertDialog(
              title: Text("Change You Location"),
              content: Text(
                  "Current Location is Temporarily Unavilable. Please Change Your Locaion"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok"),
                ),
              ],
            ),
          );
        });
  }

  // Future<String> getIMINumber() async {
  //   String deviceId;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     deviceId = await PlatformDeviceId.getDeviceId;
  //   } on PlatformException {
  //     deviceId = 'Failed to get deviceId.';
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   return deviceId;
  // }

  Future<void> apiTokenPreferance(String apiToken) async {
    // ignore: invalid_use_of_visible_for_testing_member
    //SharedPreferences.setMockInitialValues({});
    prefsToken = await SharedPreferences.getInstance();

    await prefsToken.setString("USER_API_Token", apiToken.toString());

    //print("session$selected_Town");
  }

  //

  Future<bool> internetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  Widget dialogSessionExpired(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.limeAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlutterLogo(
              size: 150,
            ),
            Text(
              "This is a Custom Dialog",
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"))
          ],
        ),
      ),
    );
  }

  Widget OfflineWidget(context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenhight = MediaQuery.of(context).size.height - kToolbarHeight;
    return Center(
      child: Container(
        width: screenwidth * .60,
        height: screenhight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              color: AppColors.kAccentColor,
              size: 100,
            ),
            Text("You Are Offline",
                style: TextStyle(
                    color: AppColors.kAccentColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }

  
}
