import 'package:flutter/material.dart';
import 'package:matsapp/Pages/DealsofDay/ProductsListWidgetsDealsofDay1.dart';
import 'package:matsapp/Pages/DealsofDay/ProductsListWidgetsDealsofDay2.dart';
import 'package:matsapp/Pages/HomePages/MainHomePage.dart';

import 'package:matsapp/widgets/DealsoftheDayWidgets/DealsoftheDayAdd1.dart';
import 'package:matsapp/widgets/DealsoftheDayWidgets/DealsoftheDayAdd2.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProductViewAllDealsOfDay extends StatefulWidget {
  // final int businessId;
  // final String mobileNumber;
  final String selectedTown;

  ProductViewAllDealsOfDay(this.selectedTown);
  @override
  _ProductViewAllDealsOfDayState createState() =>
      _ProductViewAllDealsOfDayState();
}

class _ProductViewAllDealsOfDayState extends State<ProductViewAllDealsOfDay> {
  String townSelectedStore;

  Future exclusiveFuture;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      SharedPreferences sharedPrefs;
      setState(() => sharedPrefs = prefs);
      setState(() {
        townSelectedStore = sharedPrefs.getString('SELECTED_TOWN');
        //mobileNumber = sharedPrefs.getString('USER_MOBILE');
        //exclusiveFuture = fetchTopExclusiveDeals1(townSelectedStore);
      });
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
            Navigator.pop(context);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => MainHomePage()));
          },
        ),
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'Deals Of The Day',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
        actions: [],
      ),
      body: Container(
          width: screenWidth,
          height: screenHeight,
          color: Colors.yellow[300],
          padding: EdgeInsets.all(6),
          child: SingleChildScrollView(
            child: Column(
              children: [
                DealsoftheDayAdd1(),
                ProductsListWidgetsDealsofDay1(widget.selectedTown),
                DealsoftheDayAdd2(),
                ProductsListWidgetsDealsofDay2(widget.selectedTown),
              ],
            ),
          )),
    );
  }
}
