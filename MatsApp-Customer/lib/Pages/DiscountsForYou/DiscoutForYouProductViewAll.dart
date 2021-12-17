import 'package:flutter/material.dart';
import 'package:matsapp/Pages/DiscountsForYou/DiscoutForYouViewAlProductsListWidgets1.dart';
import 'package:matsapp/Pages/DiscountsForYou/DiscoutForYouViewAlProductsListWidgets2.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/widgets/DiscountForyouWidgets/DiscountForyouAdd1.dart';
import 'package:matsapp/widgets/DiscountForyouWidgets/DiscountForyouAdd2.dart';
import 'package:matsapp/Pages/HomePages/MainHomePage.dart';

class DiscoutForYouProductViewAll extends StatefulWidget {
  // final int businessId;
  // final String mobileNumber;
  final String selectedTown;

  DiscoutForYouProductViewAll(this.selectedTown);
  @override
  _ProductViewAllDealsOfDayState createState() =>
      _ProductViewAllDealsOfDayState();
}

class _ProductViewAllDealsOfDayState
    extends State<DiscoutForYouProductViewAll> {
  String townSelectedStore;

  Future exclusiveFuture;

  @override
  void initState() {
    super.initState();

    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          setState(() {
            townSelectedStore = value[0].selectedTown;
          }),

          // prefcheck(
          //     value[0].mobilenumber, value[0].location, value[0].apitoken),
          // // GeneralTools().prefsetLoginInfo(
          // //     ),
        });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => MainHomePage()));
            Navigator.pop(context);
          },
        ),
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'Discount For you',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
          width: screenWidth,
          height: screenHeight,
          color: Colors.yellow[300],
          padding: EdgeInsets.all(6),
          child: SingleChildScrollView(
            child: Column(
              children: [
                DiscountForyouAdd1(),
                DiscoutForYouViewAlProductsListWidgets1(widget.selectedTown),
                DiscountsForYouAdd2(),
                DiscoutForYouViewAlProductsListWidgets2(widget.selectedTown),
              ],
            ),
          )),
    );
  }
}
