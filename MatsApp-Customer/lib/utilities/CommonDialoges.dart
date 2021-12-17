import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matsapp/Pages/Login/LoginPage.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:matsapp/widgets/HomeWidgets/HomePageLocation.dart';

class CommonDialoges {
  DatabaseHelper dbHelper = new DatabaseHelper();
  Widget sessionDialog(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        width: screenWidth,
        height: screenHeight * .30,
        child: Center(
          child: Dialog(
              insetPadding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Session Expired",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "Your Session Is Expired...!",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text("Ok"),
                        onPressed: () {
                          dbHelper.deleteUser();
                          Navigator.of(context, rootNavigator: true).pop();

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (route) => false);
                        },
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  serverMaintanenceDialoge(context, String messages) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
            content: Container(
              width: SizeConfig.screenwidth * .90,
              height: SizeConfig.screenheight * .40,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SvgPicture.asset("assets/vectors/warning.svg",
                        width: 150, height: 150),
                    Wrap(
                      children: [
                        Text(
                          messages,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  ClaimAllowedDialog(context, double earnedAmount) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(10),
            title: Text("Claim Not Allowed!!"),
            actions: <Widget>[
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
            content: Container(
              width: SizeConfig.screenwidth,
              height: SizeConfig.screenheight * .15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Your Earned Amount $earnedAmount \nMinimum claim amount is 1000",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        });
  }

  greetingsDialoge(context, String messages) async {
    final keyIsFirstLoaded = 'is_first_loaded';

    return showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                width: SizeConfig.screenwidth,
                height: SizeConfig.screenheight * .65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: SizeConfig.screenwidth * .80,
                      height: SizeConfig.screenheight * .60,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: SizeConfig.screenwidth * .70,
                            height: SizeConfig.screenheight * .70,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(messages),
                                    fit: BoxFit.fill)),
                          ),
                          Positioned(
                            right: 10.0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: CircleAvatar(
                                      radius: 18.0,
                                      backgroundColor: Colors.white,
                                      child:
                                          Icon(Icons.close, color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  sessionTimeOutDialoge(context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text('Session Expired'),
            actions: <Widget>[
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  dbHelper.deleteUser();
                  Navigator.of(context, rootNavigator: true).pop();

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
                },
              ),
            ],
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Your Session Is Expired...!',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

Widget changeLocationDialog(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Center(
    child: Container(
      width: screenWidth,
      height: screenHeight * .30,
      child: Dialog(
          insetPadding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Change Your Location",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "Current Location is Temporarily Unavilable. Please Change Your Locaion",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: AppColors.success_color,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePageLocation()));
                    },
                    child: Text("Change"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: AppColors.danger_color,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false);
                    },
                    child: Text("Cancel"),
                  ),
                ],
              ),
            ],
          )),
    ),
  );
}

Widget dialogContent(BuildContext context, String messages) {
  return Container(
    margin: EdgeInsets.only(left: 0.0, right: 0.0),
    child: Stack(
      children: <Widget>[
        Container(
          height: SizeConfig.screenheight * .50, // USE PROVIDED ANIMATION
          width: SizeConfig.screenwidth * .95,
          child: Container(
              width: 200, height: 200, child: Image.network(messages)),
        ),
        Positioned(
          right: 0.0,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                radius: 14.0,
                backgroundColor: Colors.white,
                child: Icon(Icons.close, color: Colors.red),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class ImageDialog extends StatelessWidget {
  final String messages;
  ImageDialog(this.messages);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: SizeConfig.screenwidth,
        height: SizeConfig.screenheight * .65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: SizeConfig.screenwidth * .80,
              height: SizeConfig.screenheight * .60,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: SizeConfig.screenwidth * .70,
                    height: SizeConfig.screenheight * .70,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(messages), fit: BoxFit.fill)),
                  ),
                  Positioned(
                    right: 10.0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              radius: 18.0,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.close, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
