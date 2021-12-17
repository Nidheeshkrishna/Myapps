import 'package:flutter/material.dart';
import 'package:matsapp/Pages/ExclusiveDeals/ProductListWidgets2.dart';
import 'package:matsapp/Pages/ExclusiveDeals/ProductsListWidgets.dart';

import 'package:matsapp/Pages/HomePages/MainHomePage.dart';

import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/widgets/ExclusiveDeals/ExclusivedealAdd1.dart';
import 'package:matsapp/widgets/ExclusiveDeals/ExclusivedealAdd2.dart';

class ProductViewAllpage extends StatefulWidget {
  // final int businessId;
  // final String mobileNumber;
  final String selectedTown;

  ProductViewAllpage(this.selectedTown);
  @override
  _ProductViewAllpageState createState() => _ProductViewAllpageState();
}

class _ProductViewAllpageState extends State<ProductViewAllpage> {
  String townSelectedStore;

  Future exclusiveFuture;

  String mobileNumber;

  String userlatitude;

  String userlogitude;

  @override
  void initState() {
    super.initState();

    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          if (mounted)
            {
              setState(() {
                townSelectedStore = value[0].selectedTown;
                mobileNumber = value[0].mobilenumber;
                //apikey = value[0].apitoken;
              }),
            }

          // prefcheck(
          //     value[0].mobilenumber, value[0].location, value[0].apitoken),
          // // GeneralTools().prefsetLoginInfo(
          // //     ),
        });
    super.initState();
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
            'Exclusive Deals',
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.bold),
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
                ExclusivedealsAdd1(),
                ProductListWidgets(widget.selectedTown),
                ExclusivedealsAdd2(),
                ProductListWidgets2(widget.selectedTown),
              ],
            ),
          )),
    );
  }
}
