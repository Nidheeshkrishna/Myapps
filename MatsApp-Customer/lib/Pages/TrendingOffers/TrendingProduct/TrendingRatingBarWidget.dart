import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:matsapp/Network/RatingModelRest.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/GerneralTools.dart';

class TrendingRatingBarWidget extends StatefulWidget {
  final int businessId;
  TrendingRatingBarWidget(this.businessId);
  @override
  _TrendingRatingBarWidgetState createState() =>
      _TrendingRatingBarWidgetState();
}

class _TrendingRatingBarWidgetState extends State<TrendingRatingBarWidget> {
  String SmilyPath;

  var rating = 1.0;

  double myrating;

  String mobileNumber;
  @override
  void initState() {
    super.initState();
    setState(() {
      SmilyPath = dummyData[1]["image_url"];
    });
    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          setState(() {
            mobileNumber = value[0].mobilenumber;
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    //SmilyPath = dummyData[1]["image_url"];
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kTextTabBarHeight;

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
            width: screenWidth * .90,
            height: screenHeight * .40,
            child: Card(
              elevation: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(SmilyPath),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    //maxRating: ,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                      setState(() {
                        myrating = rating;
                      });
                      if (rating == 1.0) {
                        setState(() {
                          SmilyPath = dummyData[0]["image_url"];
                        });
                      } else if (rating == 2.0) {
                        setState(() {
                          SmilyPath = dummyData[1]["image_url"];
                        });
                      } else if (rating == 3.0) {
                        setState(() {
                          SmilyPath = dummyData[2]["image_url"];
                        });
                      } else if (rating == 4.0) {
                        setState(() {
                          SmilyPath = dummyData[3]["image_url"];
                        });
                      } else if (rating == 5.0) {
                        setState(() {
                          SmilyPath = dummyData[4]["image_url"];
                        });
                      }
                    },
                  ),
                  ElevatedButton(
                    child: Text(
                      "Done",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      setRating("product", widget.businessId, mobileNumber,
                              myrating.toInt())
                          .then((value) => value.result == 1
                              ? GeneralTools().createSnackBarCommon(
                                  "Thanks Your Rating", context)
                              : GeneralTools()
                                  .createSnackBarCommon("Try Again", context));

                      //Navigator.of(context).pop(true);
                    },
                    // color: Theme.of(context).accentColor,
                  )
                ],
              ),
            )),
      ),
    );
  }

  final List<Map<String, Object>> dummyData = [
    {
      'id': '1',
      'image_url': 'assets/images/VeryPoor.png',
    },
    {
      'id': '2',
      'image_url': 'assets/images/Poor.png',
    },
    {
      'id': '3',
      'image_url': 'assets/images/Average.png',
    },
    {
      'id': '4',
      'image_url': 'assets/images/Good.png',
    },
    {
      'id': '5',
      'image_url': 'assets/images/Excellent.png',
    },
  ];
}
