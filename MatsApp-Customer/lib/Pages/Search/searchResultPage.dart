import 'package:flutter/material.dart';
import 'package:matsapp/Pages/Search/OffersInyourarea.dart';
import 'package:matsapp/Pages/Search/Products/searchedProducts.dart';

import 'package:matsapp/Pages/Search/searhStoreInYourArea.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';

// ignore: camel_case_types
class searchResultPage extends StatefulWidget {
  final double userLatitude;
  final double userLogitude;
  final String keyword;
  // ignore: non_constant_identifier_names
  searchResultPage(this.userLatitude, this.userLogitude, this.keyword);

  @override
  _SearchMainPageState createState() => _SearchMainPageState();
}

class _SearchMainPageState extends State<searchResultPage> {
  String townSelectedStore;

  String mobileNumber;

  String apikey;

  @override
  void initState() {
    DatabaseHelper dbHelper = new DatabaseHelper();
    dbHelper.getAll().then((value) => {
          setState(() {
            townSelectedStore = value[0].selectedTown;
            mobileNumber = value[0].mobilenumber;
            apikey = value[0].apitoken;
          }),
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - kToolbarHeight;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              "Search Now",
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
            backgroundColor: Colors.white,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            )),
        body: SingleChildScrollView(
          child: Container(
              width: screenWidth,
              height: screenHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Here What We Found !",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    // Align(
                    //   heightFactor: .90,
                    //   widthFactor: .100,
                    //   child: Container(
                    //     //width: screenWidth,
                    //     //height: screenHeight * .15,
                    //     child: Card(
                    //       shadowColor: Colors.orange,
                    //       elevation: 10,
                    //       clipBehavior: Clip.antiAliasWithSaveLayer,
                    //       child: TextFormField(
                    //           textAlign: TextAlign.center,
                    //           //controller: userNameController,
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.bold, fontSize: 14),
                    //           decoration: const InputDecoration(
                    //               hintText: 'Stores / Offers / Coupons etc...',
                    //               hintStyle:
                    //                   TextStyle(fontSize: 14, color: Colors.grey),
                    //               isDense: true,
                    //               suffixIcon: Icon(Icons.search),
                    //               focusedBorder: UnderlineInputBorder(
                    //                 borderSide: BorderSide(
                    //                     color: Colors.orange, width: 5),
                    //               ))),
                    //     ),
                    //   ),
                    // ),
                    OfferInYourAreaSearch(
                        townSelectedStore,
                        widget.userLatitude,
                        widget.userLogitude,
                        widget.keyword),
                    SearchedProducts(townSelectedStore, 
                    widget.userLatitude,
                        widget.userLogitude, widget.keyword),
                    searchStoreInYourArea(
                        townSelectedStore,
                        widget.userLatitude,
                        widget.userLogitude,
                        widget.keyword)
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
