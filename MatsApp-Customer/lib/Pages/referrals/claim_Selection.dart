import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matsapp/Pages/referrals/claim.dart';
import 'package:matsapp/constants/app_colors.dart';

class ClaimSelectionPage extends StatefulWidget {
  @override
  _ClaimSelectionState createState() => _ClaimSelectionState();
}

class _ClaimSelectionState extends State<ClaimSelectionPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    // DatabaseHelper dbHelper = new DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Claim"),
        automaticallyImplyLeading: true,
      ),
      body: Container(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                  child: Text(
                "Select mode Of Claim.",
                style: TextStyle(fontSize: 15),
              )),
              SizedBox(
                height: 5,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClaimPage(selection: "Bank"),
                    ),
                  );
                },
                child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.0),
                      color: AppColors.kPrimaryColor,
                    ),
                    child: Text('Bank',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            letterSpacing: 1.14,
                            fontWeight: FontWeight.normal))),
              ),
              Text("OR"),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClaimPage(selection: "Upi"),
                    ),
                  );
                },
                child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.0),
                      color: AppColors.kPrimaryColor,
                    ),
                    child: Text('UPI',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            letterSpacing: 1.14,
                            fontWeight: FontWeight.normal))),
              ),
            ],
          )),
    );
  }
}

class DatatoClaimPage {
  String selection = "";
  DatatoClaimPage(
    this.selection,
  );
}
