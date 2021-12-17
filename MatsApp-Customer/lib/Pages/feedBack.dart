import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:matsapp/Network/FeedbackService.dart';
import 'package:matsapp/Pages/HomePages/MainHomePage.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class FeedBackPage extends StatefulWidget {
  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  double myRating = 0.0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          setState(() {
            userID = value.first.userid.toString();

            district = value.first.district;
            mobile = value.first.selectedTown;
            town = value.first.location;
            apikey = value.first.apitoken;
            userType = value.first.userType;
          }),
        });
    dbHelper.getLoginUser().then((value) => {
          setState(() {
            district = value.selectedDistrict;
            mobile = value.mobileNumber;
            town = value.location;
            apikey = value.apiToken;
            userType = value.userType;
          }),
        });
  }

  dynamic msg;
  String district, mobile, apikey, userID, town, message, userType;

  TextEditingController feedbackController = TextEditingController();

  final feedBackformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => MainHomePage()));
          },
        ),
      ),
      body: Container(
          width: screenWidth,
          height: screenHeight,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 0,
                ),
                Form(
                  key: feedBackformKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: screenHeight * .20,
                        width: screenWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Please rate us in the following',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            RatingBar.builder(
                                initialRating: 0,
                                minRating: 0,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                glow: true,
                                allowHalfRating: false,
                                itemSize: 38,
                                itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      size: 15,
                                      color: AppColors.kAccentColor,
                                    ),
                                onRatingUpdate: (rating) {
                                  myRating = rating;
                                  print(myRating);
                                }),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        //padding: EdgeInsets.only(left: 20, right: 20),
                        width: screenWidth * .90,
                        height: screenHeight * .50,
                        child: DottedBorder(
                          color: Colors.grey,
                          dashPattern: [10, 5, 10, 5],
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10),
                          strokeCap: StrokeCap.round,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                                textAlign: TextAlign.left,
                                textAlignVertical: TextAlignVertical.center,
                                //keyboardType: TextInputType.phone,
                                controller: feedbackController,
                                // autofocus: true,

                                onSaved: (val) => message = val,
                                validator: Validators.compose([
                                  Validators.minLength(
                                      2, 'Minimum Length is 1'),
                                  Validators.maxLength(
                                      500, 'Max Length is 500'),
                                ]),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      'Please write your concerns or queries. We\'d love to hear it and improve us further..',
                                  hintStyle: TextStyle(color: Colors.grey),

                                  //isDense: true,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    feedBackformKey.currentState.save();
                    if (feedBackformKey.currentState.validate()) {
                      if (feedbackController.text.isNotEmpty) {
                        saveCustomerFeedback(
                                district,
                                mobile,
                                apikey,
                                userID,
                                town,
                                feedbackController.text,
                                "Customer",
                                myRating.toString())
                            .then((value) {
                          setState(() {
                            msg = value;
                          });
                        }).whenComplete(() => {
                                  if (msg == 1)
                                    {
                                      GeneralTools().createSnackBarSuccess(
                                          "Feedback Submitted", context),
                                      feedbackController.clear()
                                    }
                                  else
                                    GeneralTools().createSnackBarFailed(
                                        "Submission Failed", context)
                                });
                      } else {
                        GeneralTools().createSnackBarFailed(
                            "Please Type Something", context);
                      }
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
                      child: Text('Submit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              letterSpacing: 1.14,
                              fontWeight: FontWeight.normal))),
                )
              ],
            ),
          )),
    );
  }
}
