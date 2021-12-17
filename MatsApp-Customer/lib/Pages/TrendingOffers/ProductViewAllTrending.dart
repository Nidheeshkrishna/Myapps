import 'package:flutter/material.dart';
import 'package:matsapp/Network/StoreDealsRest.dart';
import 'package:matsapp/Pages/HomePages/MainHomePage.dart';

import 'package:matsapp/Pages/TrendingOffers/ProductListWidgetsTrending.dart';
import 'package:matsapp/Pages/TrendingOffers/TrendingProduct/ProductListWidgetsTrending2.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/widgets/TrendingOffersWidget/TrendingOffersAdd1.dart';
import 'package:matsapp/widgets/TrendingOffersWidget/TrendingOffersAdd2.dart';

class ProductViewAllTrending extends StatefulWidget {
  // final int businessId;
  // final String mobileNumber;
  final String selectedTown;

  ProductViewAllTrending(this.selectedTown);
  @override
  _ProductViewAllTrendingState createState() => _ProductViewAllTrendingState();
}

class _ProductViewAllTrendingState extends State<ProductViewAllTrending> {
  String townSelectedStore;

  Future exclusiveFuture;

  TrendingOffersBloc trendingBloc;

  @override
  void initState() {
    super.initState();
    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          setState(() {
            townSelectedStore = value[0].selectedTown;
          }),
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
            'Trending Offers',
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
                TrendingOffersAdd1(),
                ProductListWidgetsTrending(widget.selectedTown),
                TrendingOffersAdd2(),
                ProductListWidgetsTrending2(widget.selectedTown),
              ],
            ),
          )),
    );
  }
}
