import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/services/referrals/claim_service.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/GerneralTools.dart';

import 'package:wc_form_validators/wc_form_validators.dart';

// ignore: must_be_immutable
class ClaimPage extends StatefulWidget {
  String selection;

  ClaimPage({
    Key key,
    this.selection,
  }) : super(key: key);
  @override
  _ClaimPageState createState() => _ClaimPageState();
}

class _ClaimPageState extends State<ClaimPage> {
  @override
  void initState() {
    super.initState();
    selection = widget.selection;
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    DatabaseHelper dbHelper = new DatabaseHelper();

    dbHelper.getAll().then((value) => {
          setState(() {
            userid = value[0].userid.toString();

            userMobile = value[0].mobilenumber;

            apiKey = value[0].apitoken;
            userType = value[0].userType;
          }),
        });
  }

  bool msg;
  String selection;
  String userid, userMobile, apiKey, userType, userName, pointAmount = "20";
  String bank, branch, bankAccNo, ifsc, upiId;
  TextEditingController bankController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController upiIdController = TextEditingController();
  final bankform = GlobalKey<FormState>();
  final upiIdKey = GlobalKey<FormState>();
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Text(
                  selection == "Bank"
                      ? "Enter details to claim rewards."
                      : "Enter UPI ID",
                  style: TextStyle(fontSize: 15),
                )),
                SizedBox(
                  height: 5,
                ),
                selection == "Bank"
                    ? Form(
                        key: bankform,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 20, right: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16),
                                    textAlign: TextAlign.left,
                                    textAlignVertical: TextAlignVertical.center,
                                    //keyboardType: TextInputType.phone,
                                    controller: bankController,
                                    // autofocus: true,

                                    onSaved: (val) => bank = val,
                                    validator: Validators.compose([
                                      Validators.minLength(
                                          3, 'Minimum Length is 3'),
                                      Validators.maxLength(
                                          20, 'Max Length is 20'),
                                      Validators.required(
                                          'Bank Name is required'),
                                    ]),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: ' Bank Name',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      suffixIcon: Icon(
                                        Icons.account_balance,
                                        //color: AppColors.kPrimaryColor,
                                      ),
                                      //isDense: true,
                                    ))),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 20, right: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16),
                                    textAlign: TextAlign.left,
                                    textAlignVertical: TextAlignVertical.center,
                                    //keyboardType: TextInputType.phone,
                                    controller: branchController,
                                    // autofocus: true,

                                    onSaved: (val) => branch = val,
                                    validator: Validators.compose([
                                      Validators.minLength(
                                          4, 'Minimum Length is 4'),
                                      Validators.maxLength(
                                          15, 'Max Length is 15'),
                                      Validators.required(
                                          'Branch Name is required'),
                                    ]),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: ' Branch Name',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      suffixIcon: Icon(
                                        Icons.location_pin,
                                        //color: AppColors.kPrimaryColor,
                                      ),
                                      //isDense: true,
                                    ))),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 20, right: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16),
                                    textAlign: TextAlign.left,
                                    textAlignVertical: TextAlignVertical.center,
                                    //keyboardType: TextInputType.phone,
                                    controller: accountNoController,
                                    // autofocus: true,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onSaved: (val) => bankAccNo = val,
                                    validator: Validators.compose([
                                      Validators.minLength(
                                          10, 'Minimum Length is 10'),
                                      Validators.maxLength(
                                          25, 'Max Length is 25'),
                                      Validators.required(
                                          'Account Number is required'),
                                    ]),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: ' Bank account number',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      suffixIcon: Icon(
                                        Icons.lock,
                                        //color: AppColors.kPrimaryColor,
                                      ),
                                      //isDense: true,
                                    ))),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 20, right: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16),
                                    textAlign: TextAlign.left,
                                    textAlignVertical: TextAlignVertical.center,
                                    //keyboardType: TextInputType.phone,
                                    controller: ifscController,
                                    // autofocus: true,

                                    onSaved: (val) => ifsc = val,
                                    validator: Validators.compose([
                                      Validators.minLength(
                                          10, 'Minimum Length is 10'),
                                      Validators.maxLength(
                                          15, 'Max Length is 15'),
                                      Validators.required(
                                          'Ifsc code is required'),
                                    ]),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: ' Ifsc code',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      suffixIcon: Icon(
                                        Icons.apartment_rounded,
                                        //color: AppColors.kPrimaryColor,
                                      ),
                                      //isDense: true,
                                    ))),
                          ],
                        ),
                      )
                    : Form(
                        key: upiIdKey,
                        child: Container(
                            padding: EdgeInsets.only(left: 20, right: 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                                textAlign: TextAlign.left,
                                textAlignVertical: TextAlignVertical.center,
                                //keyboardType: TextInputType.phone,
                                controller: upiIdController,
                                // autofocus: true,

                                // onSaved: (val) => upiId = val,
                                validator: Validators.compose([
                                  Validators.minLength(
                                      5, 'Minimum Length is 5'),
                                  Validators.maxLength(25, 'Max Length is 25'),
                                  Validators.required('UPI ID is required'),
                                ]),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: ' UPI ID',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  // suffixIcon: Icon(
                                  //   Icons.account_balance,
                                  //   //color: AppColors.kPrimaryColor,
                                  // ),
                                  //isDense: true,
                                ))),
                      ),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    selection == "Bank"
                        ? bankform.currentState.save()
                        : upiIdKey.currentState.save();
                    if (selection == "Bank"
                        ? bankform.currentState.validate()
                        : upiIdKey.currentState.validate()) {
                      referalClaim(
                              userid,
                              userMobile,
                              apiKey,
                              pointAmount,
                              bankController.text.toString(),
                              branchController.text.toString(),
                              accountNoController.text.toString(),
                              ifscController.text.toString(),
                              upiIdController.text.toString())
                          .then((value) {
                        setState(() {
                          msg = value.result;
                        });
                      }).whenComplete(() => {
                                if (selection == "Bank" && msg == true)
                                  {
                                    bankController.clear(),
                                    branchController.clear(),
                                    accountNoController.clear(),
                                    ifscController.clear(),
                                    GeneralTools().createSnackBarSuccess(
                                        "Claim Request Placed", context)
                                  }
                                else if (selection == "Upi" && msg == true)
                                  {
                                    upiIdController.clear(),
                                    GeneralTools().createSnackBarSuccess(
                                        "Claim Request Placed", context)
                                  }
                                else if (msg == false)
                                  {
                                    GeneralTools().createSnackBarFailed(
                                        "Request Failed", context)
                                  }
                              });
                    }
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      padding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.0),
                        color: AppColors.kPrimaryColor,
                      ),
                      child: Text('Claim',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.white,
                              letterSpacing: 1.14,
                              fontWeight: FontWeight.normal))),
                ),
              ],
            ),
          )),
    );
  }
}
