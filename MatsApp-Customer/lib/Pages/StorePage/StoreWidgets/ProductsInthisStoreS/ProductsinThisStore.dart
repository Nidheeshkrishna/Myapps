import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:matsapp/Modeles/GetStoredetailesModel.dart';
import 'package:matsapp/Network/GetStoreDetailesRest.dart';
import 'package:matsapp/Pages/StorePage/StoreWidgets/ProductsInthisStoreS/ProductInThisStoreViewAllpage.dart';
import 'package:matsapp/Pages/StorePage/StoreProductPage.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';

class ProductsinThisStore extends StatefulWidget {
  final int businessId;
  final String selectedTown;
  final String businessname;
  ProductsinThisStore(this.businessId, this.selectedTown, this.businessname);
  @override
  _ProductsinThisStoreWidgetState createState() =>
      _ProductsinThisStoreWidgetState();
}

class _ProductsinThisStoreWidgetState extends State<ProductsinThisStore> {
  Future futurestoreDetailes;

  String townSelectedStore;

  String mobileNumber;

  var apikey;

  @override
  void initState() {
    DatabaseHelper dbHelper = new DatabaseHelper();
    dbHelper.getAll().then((value) => {
          setState(() {
            townSelectedStore = value[0].selectedTown;
            mobileNumber = value[0].mobilenumber;
            apikey = value[0].apitoken;
            futurestoreDetailes = fetchStordetailes(
              widget.businessId,
            );
          }),
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 8, right: 8),
          //height: screenHeight * .90,
          //width: screenWidth,
          //color: Colors.amberAccent,
          child: FutureBuilder<GetStoredetailesModel>(
              future: futurestoreDetailes,
              builder: (BuildContext context,
                  AsyncSnapshot<GetStoredetailesModel> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.productoffers.isNotEmpty ||
                      snapshot.data.productoffers.length > 0) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text("Products in This Store",
                                  style: AppTextStyle.homeTitlesfont()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextButton(
                                // style: ElevatedButton.styleFrom(
                                //   // background color
                                //   primary: Colors.white,

                                //   textStyle: TextStyle(fontSize: 14),
                                // ),
                                child: Row(children: [
                                  Text("View All ",
                                      style: AppTextStyle.homeViewAllFont()),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: AppColors.kSecondaryDarkColor,
                                  ),
                                ]),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductInThisStoreViewAllpage(
                                                  widget.businessId,
                                                  mobileNumber,
                                                  widget.selectedTown,
                                                  widget.businessname)));
                                },
                              ),
                            )
                          ],
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.productoffers.length,
                          physics: ClampingScrollPhysics(),
                          //primary: true,
                          //physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1 / 1.3,
                                  //crossAxisSpacing: ,
                                  mainAxisSpacing: 8),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: InkWell(
                                  child: Card(
                                      elevation: 2,
                                      //clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 3.0,
                                            bottom: 0.0,
                                            left: 5,
                                            right: 5),
                                        child: Column(
                                          children: <Widget>[
                                            CachedNetworkImage(
                                                imageUrl: snapshot
                                                    .data
                                                    .productoffers[index]
                                                    .productImage,
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Icon(Icons.image, size: 45),
                                                fit: BoxFit.contain,
                                                width: screenWidth * .50,
                                                height: screenHeight * .18),
                                            Container(
                                              alignment: Alignment.bottomRight,
                                              height: screenHeight * .03,
                                              child: Container(
                                                alignment:
                                                    Alignment.bottomRight,
                                                height: screenHeight * .03,
                                                width: screenWidth * .1,
                                                child: OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    padding: EdgeInsets.all(2),
                                                    minimumSize: Size.zero,
                                                    fixedSize: Size.fromWidth(
                                                        screenWidth * .1),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7)),
                                                    side: BorderSide(
                                                      color: kAccentColor,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      new Text(
                                                        '${snapshot.data.productoffers[index].rating}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                screenWidth *
                                                                    .04),
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        size: screenWidth * .04,
                                                        color:
                                                            Colors.orange[400],
                                                      )
                                                    ],
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: screenWidth * .50,
                                              child: Wrap(
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data
                                                        .productoffers[index]
                                                        .productName,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: AppTextStyle
                                                        .productNameFont(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                snapshot
                                                            .data
                                                            .productoffers[
                                                                index]
                                                            .productPrice >
                                                        0
                                                    ? Row(
                                                        children: [
                                                          Text(
                                                            "MRP:",
                                                            style: AppTextStyle
                                                                .productMRPFont(),
                                                          ),
                                                          Text(
                                                            "${snapshot.data.productoffers[index].productPrice}/-" ??
                                                                "",
                                                            style: AppTextStyle
                                                                .productMRPFont(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough),
                                                          ),
                                                        ],
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                            snapshot.data.productoffers[index]
                                                        .matsappPrice >
                                                    0
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Matsapp Price:${snapshot.data.productoffers[index].matsappPrice}/-" ??
                                                              "",
                                                          style: AppTextStyle
                                                              .productPriceFont(
                                                                  color: AppColors
                                                                      .mHomeGreen),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : Container(),
                                            snapshot.data.productoffers[index]
                                                        .discount !=
                                                    0
                                                ? Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                      margin: EdgeInsets.all(2),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .30,
                                                      //height: MediaQuery.of(context).size.height * .10,
                                                      height: 30,
                                                      child: Card(
                                                          color: Colors
                                                              .orange[400],
                                                          child: Center(
                                                            child: Text(
                                                              "Save\r${snapshot.data.productoffers[index].discount}%" ??
                                                                  "",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          )),
                                                    ))
                                                : Container(),
                                          ],
                                        ),
                                      )),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StoreProductPage(
                                                  snapshot
                                                      .data
                                                      .productoffers[index]
                                                      .productId,
                                                  townSelectedStore,
                                                  snapshot
                                                      .data
                                                      .productoffers[index]
                                                      .productName,
                                                  snapshot
                                                      .data
                                                      .productoffers[index]
                                                      .businessId,
                                                  widget.businessname,
                                                )));
                                  }),
                            );
                          },
                        )
                      ],
                    );
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              }),
        ),
      ],
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
