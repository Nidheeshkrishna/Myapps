import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Modeles/GetStoredetailesModel.dart';
import 'package:matsapp/Network/GetStoreDetailesRest.dart';
import 'package:matsapp/Pages/StorePage/StoreWidgets/OfferInthiStores/offerViewAllproductpage.dart';
import 'package:matsapp/Pages/TrendingOffers/ProductPageTrending.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';

class StorePageProductListWidget extends StatefulWidget {
  final int businessId;
  final String selectedTown;
  final String businessName;
  final List<AllOffer> offersList;
  StorePageProductListWidget(
      this.businessId, this.selectedTown, this.businessName, this.offersList);
  @override
  _StorePageProductListWidgetState createState() =>
      _StorePageProductListWidgetState();
}

class _StorePageProductListWidgetState
    extends State<StorePageProductListWidget> {
  Future futurestoreDetailes;

  String townSelectedStore;

  String mobileNumber;

  @override
  void initState() {
    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          setState(() {
            townSelectedStore = value[0].selectedTown;
            mobileNumber = value[0].mobilenumber;
            futurestoreDetailes = fetchStordetailes(
              widget.businessId,
            );
            //apikey = value[0].apitoken;
          }),

          // prefcheck(
          //     value[0].mobilenumber, value[0].selectedTown, value[0].apitoken),
          // // GeneralTools().prefsetLoginInfo(
          // //     ),
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Container(
                //height: screenHeight * .90,
                //width: screenWidth,
                child: FutureBuilder<GetStoredetailesModel>(
                    future: futurestoreDetailes,
                    builder: (BuildContext context,
                        AsyncSnapshot<GetStoredetailesModel> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.offersList.length > 0) {
                          return Container(
                            width: screenWidth,
                            //height: screenHeight * .88,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                                  Colors.orange[300],
                                  Colors.orange[100],
                                  Colors.orange[50]
                                ],
                                stops: [0, 1, 2],
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text("Exclusive Offers ",
                                          style: AppTextStyle.homeWhitefont()),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(
                                        // style: TextButton(
                                        //   // background color
                                        //   primary: Colors.white,

                                        //   textStyle: TextStyle(fontSize: 14),
                                        // ),
                                        child: Row(children: [
                                          Text("View All ",
                                              style: AppTextStyle
                                                  .homeViewAllWhite()),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                        ]),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OffersViewAllpage(
                                                          widget.businessId,
                                                          mobileNumber,
                                                          widget.selectedTown,
                                                          widget
                                                              .businessName)));
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                GridView.builder(
                                  padding: EdgeInsets.only(
                                      left: 8.0, right: 8.0, bottom: 8),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.offersList.length,
                                  physics: ScrollPhysics(),
                                  //primary: true,
                                  //physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 1,
                                          childAspectRatio:
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      1.3)),

                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 6.0, bottom: 6.0),
                                          child: Card(
                                              elevation: 2,
                                              //clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2,
                                                    left: 8,
                                                    right: 8,
                                                    bottom: 0),
                                                child: Column(
                                                  children: <Widget>[
                                                    CachedNetworkImage(
                                                        imageUrl: snapshot
                                                            .data
                                                            .offersList[index]
                                                            .productImage,
                                                        placeholder: (context,
                                                                url) =>
                                                            Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.image,
                                                                size: 50),
                                                        fit: BoxFit.contain,
                                                        width:
                                                            screenWidth * .50,
                                                        height:
                                                            screenHeight * .18),
                                                    SizedBox(height: 3),
                                                    Container(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        height:
                                                            screenHeight * .035,
                                                        child: OutlinedButton(
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            minimumSize:
                                                                Size.zero,
                                                            fixedSize:
                                                                Size.fromWidth(
                                                                    screenWidth *
                                                                        .1),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7)),
                                                            side: BorderSide(
                                                              color:
                                                                  kAccentColor,
                                                            ),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              new Text(
                                                                '${snapshot.data.offersList[index].rating}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        screenWidth *
                                                                            .04),
                                                              ),
                                                              Icon(
                                                                Icons.star,
                                                                size:
                                                                    screenWidth *
                                                                        .04,
                                                                color: Colors
                                                                        .orange[
                                                                    400],
                                                              )
                                                            ],
                                                          ),
                                                          onPressed: () {},
                                                        )),
                                                    Wrap(
                                                      // mainAxisAlignment:
                                                      //     MainAxisAlignment
                                                      //         .spaceAround,
                                                      children: [
                                                        Text(
                                                          snapshot
                                                              .data
                                                              .offersList[index]
                                                              .offerName,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: AppTextStyle
                                                              .productNameFont(),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        snapshot
                                                                        .data
                                                                        .offersList[
                                                                            index]
                                                                        .mrp !=
                                                                    0 ||
                                                                snapshot
                                                                        .data
                                                                        .offersList[
                                                                            index]
                                                                        .mrp !=
                                                                    null
                                                            ? Text(
                                                                "Mrp: ${snapshot.data.offersList[index].mrp}/-" ??
                                                                    "",
                                                                style: AppTextStyle
                                                                    .productMRPFont())
                                                            : Container(),
                                                        snapshot
                                                                    .data
                                                                    .offersList[
                                                                        index]
                                                                    .offerPrice !=
                                                                "0"
                                                            ? Text(
                                                                "Offer Price: ${snapshot.data.offersList[index].offerPrice}/-" ??
                                                                    "",
                                                                style: AppTextStyle
                                                                    .productMRPFont())
                                                            : Container(),
                                                        snapshot
                                                                        .data
                                                                        .offersList[
                                                                            index]
                                                                        .saveAmount !=
                                                                    "0" &&
                                                                snapshot
                                                                        .data
                                                                        .offersList[
                                                                            index]
                                                                        .saveAmount !=
                                                                    null
                                                            ? Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                      "${snapshot.data.offersList[index].saveAmount}" ??
                                                                          "",
                                                                      style: TextStyle(
                                                                          fontSize: 12 *
                                                                              MediaQuery.textScaleFactorOf(
                                                                                  context),
                                                                          color:
                                                                              AppColors.success_color)),
                                                                ],
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[],
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductPageTrending(
                                                        snapshot
                                                            .data
                                                            .offersList[index]
                                                            .offerId,
                                                        townSelectedStore,
                                                        snapshot
                                                            .data
                                                            .offersList[index]
                                                            .businessName,
                                                        snapshot
                                                            .data
                                                            .offersList[index]
                                                            .businessId)),
                                          );
                                        });
                                  },
                                )
                              ],
                            ),
                          );
                        } else {
                          return Center(
                            child: Container(
                              width: screenWidth * .70,
                              height: screenHeight * .40,
                              //margin: EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/images/NoOffers.png",
                                    width: screenWidth * .70,
                                    height: screenHeight * .30,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      } else {
                        return Container();
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final List<Map<String, Object>> dummyData = [
    {
      'id': '1',
      'Name': 'JBL Box Media',
      'image_url': 'assets/images/jblsp.png',
    },
    {
      'id': '2',
      'Name': 'Watch',
      'image_url': 'assets/images/applewatch.jpg',
    },
    {
      'id': '3',
      'Name': 'Combo Offer',
      'image_url': 'assets/PRODUCT/BluetoothSpeaker.jpeg'
    },
    {
      'id': '4',
      'Name': 'Sony Cybershot',
      'image_url': 'assets/images/sonycybershot.jpeg'
    },
    {'id': '5', 'Name': 'Watch', 'image_url': 'assets/images/mangobake.jpg'},
    {'id': '6', 'Name': 'Watch', 'image_url': 'assets/images/R-c.jpg'},
    {
      'id': '7',
      'Name': 'Headset',
      'image_url': 'assets/PRODUCT/headphones.jpeg'
    },
    {
      'id': '8',
      'Name': 'Oven',
      'image_url': 'assets/images/microvWaveOven.jpg'
    },
    {'id': '9', 'Name': 'Watch', 'image_url': 'assets/PRODUCT/watch.jpeg'},
  ];
}
