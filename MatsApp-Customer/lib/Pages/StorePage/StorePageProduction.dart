import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:android_intent/android_intent.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matsapp/Modeles/GetStoredetailesModel.dart';
import 'package:matsapp/Modeles/SqlLiteTableDataModel.dart';
import 'package:matsapp/Network/AddTowishListRest.dart';
import 'package:matsapp/Network/GetStoreDetailesRest.dart';
import 'package:matsapp/Network/RatingModelRest.dart';
import 'package:matsapp/Network/RemovefromwishlistRest.dart';
import 'package:matsapp/Pages/HomePages/MainHomePage.dart';
import 'package:matsapp/Pages/StorePage/GiftStorePage.dart';
import 'package:matsapp/Pages/StorePage/StoreWidgets/StoresImage/StoreImages.dart';
import 'package:matsapp/Pages/StorePage/StoreWidgets/StorpageTabs1/StoreCouponTab.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/constants/app_vectors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

import 'StoreWidgets/StorpageTabs1/MainTabPage.dart';

class StorePageProduction extends StatefulWidget {
  final int business_id;
  //
  final String selectedTown;
  final String businessname;

  StorePageProduction(this.business_id, this.selectedTown, this.businessname);

  @override
  _StorePageProductionState createState() => _StorePageProductionState();
}

class _StorePageProductionState extends State<StorePageProduction> {
  GlobalKey<ScaffoldState> scaffKey = new GlobalKey<ScaffoldState>();

  bool status;

  String townSelectedStore;
  SizeConfig config;

  String mobileNumber;
  Future futurestoreDetailes;

  bool wishliststatus = false;
  int store_wishlistId;
  String businessid;

  var apikey;
  StreamController<GetStoredetailesModel> _userController;
  String businessName;

  bool storecoupon = false;

  Position _currentPosition;

  String userLatitude;

  String userLogitude;

  var businessDiscription;

  List<AllOffer> offerdata;

  List<AllProduct> coupondata;
  //bool isSwitched = true;
  @override
  void initState() {
    //getdata();
    DatabaseHelper dbHelper = new DatabaseHelper();
    dbHelper.getAll().then((value) => {
          if (mounted)
            {
              setState(() {
                townSelectedStore = value.first.selectedTown;
                mobileNumber = value.first.mobilenumber;
                apikey = value.first.apitoken;
              }),
              _getCurrentLocation(),
            }
        });

    _userController = new StreamController();
    //Timer.periodic(Duration(seconds: 1), (_) => loadDetails());
    loadDetails();

    config = new SizeConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isSelected = false;

    AppBar appbar = AppBar(
      backgroundColor: Colors.white,
      title: Text(widget.businessname,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.25,
              fontSize: 18,
              color: Colors.blueGrey)),
      centerTitle: true,
      leading: InkWell(
        child: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainHomePage()));
        },
      ),
    );
    double screenHeight =
        MediaQuery.of(context).size.height - appbar.preferredSize.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainHomePage()));
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: scaffKey,
        appBar: appbar,
        //bottomNavigationBar: MainHomePageBottambar1(),
        body: Hero(
          tag: "Store page",
          child: SingleChildScrollView(
            child: Container(
                width: screenWidth,
                height: screenHeight,
                child: SingleChildScrollView(
                  child: Column(
                    //mainAxisSize: MainAxisSize.m,
                    //shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          StreamBuilder<GetStoredetailesModel>(
                            stream: _userController.stream,
                            builder: (BuildContext context,
                                AsyncSnapshot<GetStoredetailesModel> snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.result.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (snapshot.data.storeCoupon.length > 0) {
                                      storecoupon = true;
                                    } else {
                                      storecoupon = false;
                                    }
                                    if (snapshot.data.result.length > 0) {
                                      // if (snapshot
                                      //         .data.result[index].description !=
                                      //     null) {
                                      //   businessDiscription = snapshot
                                      //       .data.result[index].description;
                                      // }
                                      // businessName = snapshot
                                      //     .data.result[index].businessName;
                                      // mobileNumber =
                                      //     snapshot.data.result[index].mobile;
                                      store_wishlistId = snapshot
                                          .data.result[index].wishListId;
                                    }

                                    if (snapshot
                                            .data.result[index].wishListId ==
                                        0) {
                                      wishliststatus = false;
                                    } else if (snapshot
                                            .data.result[index].wishListId >
                                        0) {
                                      wishliststatus = true;
                                    }
                                    return Column(children: <Widget>[
                                      Container(
                                        width: screenWidth,
                                        height: screenHeight * .30,
                                        child: Card(
                                          elevation: 10,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot
                                                .data.result[index].coverImage,
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.image, size: 30),
                                            fit: BoxFit.cover,
                                            //width: 200,
                                            //height: 200,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12.0,
                                            right: 10,
                                            bottom: 10,
                                            top: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width:
                                                  SizeConfig.widthMultiplier *
                                                      58,
                                              //height: 100,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      snapshot
                                                          .data
                                                          .result[index]
                                                          .businessName,
                                                      softWrap: true,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: SizeConfig
                                                                  .widthMultiplier *
                                                              5.4),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                IconButton(
                                                  iconSize: screenHeight * .03,
                                                  icon: SvgPicture.asset(
                                                    wishliststatus
                                                        ? AppVectors.ic_heart1
                                                        : AppVectors.ic_heart,
                                                    height: screenHeight * .025,
                                                    // color: wishliststatus
                                                    //     ? Colors.pink
                                                    //     : Colors.blueGrey,
                                                  ),
                                                  color: Colors.black,
                                                  onPressed: () {
                                                    snapshot.data.result[index]
                                                                .wishListId ==
                                                            0
                                                        ? fetchAddTowishList(
                                                            "Store",
                                                            widget.business_id,
                                                          ).then(
                                                            (value) => {
                                                              if (value
                                                                      .result ==
                                                                  1)
                                                                {
                                                                  loadDetails(),
                                                                  //fetchTopStore(town, mobile, latitude, longitude)
                                                                  setState(() {
                                                                    wishliststatus =
                                                                        true;
                                                                  }),
                                                                  // _toggleFavorite(),
                                                                  GeneralTools()
                                                                      .createSnackBarSuccess(
                                                                          "Added to your Wishlist",
                                                                          context)
                                                                }
                                                            },
                                                          )
                                                        : fetchRemoveFromwishList(
                                                                snapshot
                                                                    .data
                                                                    .result[
                                                                        index]
                                                                    .wishListId)
                                                            .then((value) => {
                                                                  if (value
                                                                          .result ==
                                                                      1)
                                                                    {
                                                                      loadDetails(),
                                                                      setState(
                                                                          () {
                                                                        wishliststatus =
                                                                            false;
                                                                      }),
                                                                      // _toggleFavorite(),
                                                                      GeneralTools().createSnackBarFailed(
                                                                          "Removed from Wishlist",
                                                                          context)
                                                                    }
                                                                });
                                                  },
                                                ),
                                                Container(
                                                  width: screenWidth * .12,
                                                  height: screenHeight * .035,
                                                  // ignore: deprecated_member_use
                                                  child: OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      padding: EdgeInsets.zero,
                                                      minimumSize: Size.zero,
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
                                                    onPressed: () {},
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        new Text(
                                                          '${snapshot.data.result[index].rating}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .orange[400],
                                                              fontSize:
                                                                  screenWidth *
                                                                      .04),
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          size:
                                                              screenWidth * .04,
                                                          color: Colors
                                                              .orange[400],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              '${snapshot.data.result[index].openingTime} - ${snapshot.data.result[index].closingTime}',
                                              style: TextStyle(
                                                  fontSize: screenWidth * .04,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return GiftStorePage(
                                                          snapshot
                                                              .data
                                                              .result[index]
                                                              .businessName,
                                                          snapshot
                                                              .data
                                                              .result[index]
                                                              .businessId
                                                              .toString());
                                                    });

                                                // Navigator.pushReplacement(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             GiftStorePage(snapshot
                                                //                 .data
                                                //                 .result[index]
                                                //                 .businessName)));
                                              },
                                              child: snapshot.data.result[index]
                                                          .giftFlag ==
                                                      "true"
                                                  ? Container(
                                                      // width: 80,
                                                      // height: 80,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8),
                                                      // decoration: BoxDecoration(
                                                      //   borderRadius:
                                                      //       BorderRadius.circular(
                                                      //           8.0),
                                                      //   color: Colors.white,
                                                      //   boxShadow: [
                                                      //     BoxShadow(
                                                      //       color:
                                                      //           Colors.blueGrey,
                                                      //       blurRadius: 2.0,
                                                      //       spreadRadius: 0.0,
                                                      //       offset: Offset(2.0,
                                                      //           2.0), // shadow direction: bottom right
                                                      //     )
                                                      //   ],
                                                      // ),
                                                      child: Column(
                                                        children: [
                                                          SvgPicture.asset(
                                                            "assets/vectors/surprisegift.svg",
                                                            fit: BoxFit.contain,
                                                            colorBlendMode:
                                                                BlendMode
                                                                    .colorBurn,
                                                            // color:
                                                            //     Colors.redAccent,
                                                            width: 60,
                                                            height: 60,
                                                          ),
                                                          // Image.asset(
                                                          //   "assets/images/gift.png",
                                                          //   width: 80,
                                                          //   height: 50,
                                                          // ),
                                                          // Padding(
                                                          //   padding:
                                                          //       const EdgeInsets
                                                          //           .all(2.0),
                                                          //   child: Text(
                                                          //     "Surprise Gift",
                                                          //     style: TextStyle(
                                                          //         color:
                                                          //             Colors.red),
                                                          //   ),
                                                          // )
                                                        ],
                                                      ) // child widget, replace with your own
                                                      )
                                                  : Container()),
                                          // Padding(
                                          //   padding:
                                          //       const EdgeInsets.only(right: 8.0),
                                          //   //ignore: deprecated_member_use
                                          //   child: RaisedButton(
                                          //     shape: RoundedRectangleBorder(
                                          //         borderRadius:
                                          //             BorderRadius.circular(7.0),
                                          //         side: BorderSide(
                                          //           color: Theme.of(context)
                                          //               .accentColor,
                                          //         )),
                                          //     onPressed: () {},
                                          //     color: Theme.of(context).accentColor,
                                          //     child: Text("Free Home Delivery",
                                          //         style: TextStyle(
                                          //           color: AppColors.mHomeGreen,
                                          //           fontWeight: FontWeight.w800,
                                          //           fontSize: screenWidth * .04,
                                          //         )),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12.0,
                                            left: 8.0,
                                            right: 8.0,
                                            bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    snapshot.data.result[index]
                                                        .address,

                                                    // overflow: TextOverflow.ellipsis,

                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors
                                                            .kSecondaryDarkColor),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(13.0),
                                      //   child: Wrap(
                                      //     children: [
                                      //       Text(
                                      //         snapshot
                                      //             .data.result[index].description,
                                      //         style: TextStyle(
                                      //             wordSpacing: 1,
                                      //             color: AppColors
                                      //                 .kSecondaryDarkColor),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width:
                                                SizeConfig.widthMultiplier * 30,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Theme.of(context)
                                                      .accentColor,
                                                  elevation: 5,
                                                  onPrimary: Colors.blue,
                                                  shadowColor:
                                                      AppColors.kAccentColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7.0),
                                                      side: BorderSide(
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                      ))),
                                              onPressed: () {
                                                launch(
                                                    "tel:${snapshot.data.result.first.mobile}");
                                              },
                                              child: Text(
                                                "call",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width:
                                                SizeConfig.widthMultiplier * 30,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Theme.of(context)
                                                      .accentColor,
                                                  elevation: 5,
                                                  onPrimary: Colors.blue,
                                                  shadowColor:
                                                      AppColors.kAccentColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7.0),
                                                      side: BorderSide(
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                      ))),
                                              onPressed: () {
                                                generateUrl(
                                                    "$userLatitude,$userLogitude",
                                                    "${snapshot.data.result[0].latitude},${snapshot.data.result[0].longitude}");

                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //       builder: (context) =>
                                                //           VisitLocation(
                                                //               snapshot
                                                //                   .data
                                                //                   .result[0]
                                                //                   .latitude,
                                                //               snapshot
                                                //                   .data
                                                //                   .result[0]
                                                //                   .longitude,
                                                //               userLatitude,
                                                //               userLogitude,
                                                //               widget.businessname),
                                                //     ));

                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //       builder: (context) =>
                                                //           GooglelocationPage(
                                                //               snapshot
                                                //                   .data
                                                //                   .result[0]
                                                //                   .latitude,
                                                //                snapshot
                                                //                   .data
                                                //                   .result[0]
                                                //                   .latitude,
                                                //               widget
                                                //                   .businessname)),
                                                // );
                                              },
                                              child: Text(
                                                "Visit",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width:
                                                SizeConfig.widthMultiplier * 30,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Theme.of(context)
                                                      .accentColor,
                                                  elevation: 5,
                                                  onPrimary: Colors.blue,
                                                  shadowColor:
                                                      AppColors.kAccentColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7.0),
                                                      side: BorderSide(
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                      ))),
                                              onPressed: () {
                                                showAlertDialog(
                                                    context,
                                                    snapshot.data.result[index]
                                                        .businessId);
                                              },
                                              child: Text(
                                                "Rating",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(
                                      //     height:
                                      //         SizeConfig.heightMultiplier * 2),
                                      // Container(
                                      //   padding: EdgeInsets.only(
                                      //     left: 10,
                                      //   ),
                                      //   alignment: Alignment.centerLeft,
                                      //   width: SizeConfig.screenwidth,
                                      //   height: SizeConfig.heightMultiplier * 6,
                                      //   color: Colors.grey.shade300,
                                      //   child: snapshot.data.storeCoupon.length > 0
                                      //       ? Row(
                                      //           mainAxisAlignment:
                                      //               MainAxisAlignment.spaceBetween,
                                      //           children: [
                                      //             Container(
                                      //               width:
                                      //                   SizeConfig.widthMultiplier *
                                      //                       75,
                                      //               child: Text(
                                      //                 snapshot.data.result[index]
                                      //                     .storeDetails,
                                      //                 maxLines: 1,
                                      //                 overflow:
                                      //                     TextOverflow.ellipsis,
                                      //                 softWrap: true,
                                      //               ),
                                      //             ),
                                      //             IconButton(
                                      //               icon: Icon(Icons.info_rounded),
                                      //               onPressed: () {
                                      //                 Dialoges().storeInfoAlert(
                                      //                   context,
                                      //                   snapshot.data.result[index]
                                      //                       .storeDetails,
                                      //                 );
                                      //               },
                                      //             )
                                      //           ],
                                      //         )
                                      //       : Container(),
                                      // ),
                                    ]);
                                  },
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ],
                      ),
                      //product List widgets
                      // ProductsinThisStore(widget.business_id, widget.selectedTown,
                      //     widget.businessname),
                      // //offer List widgets
                      // SizedBox(
                      //   height: 10,
                      // ),
                      StorpageProductMainTabs(
                          widget.selectedTown,
                          widget.business_id,
                          businessDiscription,
                          widget.businessname,
                          offerdata),

                      StoreImages(widget.business_id),

                      offerdata != null
                          ? offerdata.length > 0
                              ? StorecouponWidgetNew(
                                  widget.business_id, widget.selectedTown)
                              : Container()
                          : Container()
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  final List<Map<String, Object>> dummyData = [
    {
      'id': '1',
      'image_url': 'assets/images/kalyan-hypermarket.png',
    },
    {
      'id': '2',
      'image_url': 'assets/images/kalyan-hypermarket.png',
    },
    {
      'id': '3',
      'image_url': 'assets/images/kalyan-hypermarket.png',
    },
    {
      'id': '4',
      'image_url': 'assets/images/kalyan-hypermarket.png',
    },
  ];
  showAlertDialog(BuildContext context, int businessId) {
    int starCount;
    // Create button
    Widget okButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Theme.of(context).accentColor,
          elevation: 10,
          onPrimary: Colors.white,
          shadowColor: Colors.red,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
              side: BorderSide(
                color: Theme.of(context).accentColor,
              ))),
      child: Text("OK"),
      onPressed: () {
        setRating("Store", businessId, mobileNumber, starCount)
            .then((value) => {
                  if (value.result == 1)
                    {
                      GeneralTools()
                          .createSnackBarCommon("Thanks Your Rating", context),
                      loadDetails()
                    }
                  else
                    {GeneralTools().createSnackBarCommon("Try Again", context)}
                });
        Navigator.of(context).pop();
      },
    );
    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Theme.of(context).accentColor,
          elevation: 10,
          onPrimary: Colors.white,
          shadowColor: Colors.red,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
              side: BorderSide(
                color: Theme.of(context).accentColor,
              ))),
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 30),
      title: Text("Store Rating"),
      content: RatingBar.builder(
        initialRating: 0,
        minRating: 0,

        allowHalfRating: false,
        itemCount: 5,

        //maxRating: ,
        //itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          print(rating);
          setState(() {
            starCount = rating.toInt();
          });
        },
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [okButton, cancelButton],
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future getdata() async {
    DatabaseHelper dbHelper = new DatabaseHelper();
    List<UserInfo> user = await dbHelper.getAll();

    setState(() {
      townSelectedStore = user.first.selectedTown;
      mobileNumber = user.first.mobilenumber;
      apikey = user.first.apitoken;
      // store_wishlistId = widget.wishlistId;
      // GeneralTools().prefsetLoginInfo(mobileNumber, apikey, apikey);
      // futurestoreDetailes = fetchStordetailes(
      //     widget.business_id, mobileNumber, widget.selectedTown);
    });
  }

  loadDetails() async {
    fetchStordetailes(widget.business_id).then((res) async {
      //print('LoadDetails of ${res.fname}');

      _userController.add(res);
      setState(() {
        businessDiscription = res.result.first.description;
        offerdata = res.offersList;
        coupondata = res.storeCoupon;
      });

      // if (_isDisposed) {

      //   return res;
      // }
      return res;
    });
  }

  _getCurrentLocation() async {
    //fetchdata();

    // Position position = await Geolocator.getCurrentPosition(
    //   desiredAccuracy: LocationAccuracy.best,
    // );
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((value) {
      setState(() {
        _currentPosition = value;
        userLatitude = ' ${value.latitude}';
        userLogitude = '${value.longitude}';
      });

      print('${value.latitude}');
      print('${value.longitude}');
      // print(' ${position.}');
    }).catchError((e) {
      print(e);
    });
    //fetchdata();
  }

  void generateUrl(String origin, String destination) async {
    if (Platform.isAndroid) {
      final AndroidIntent intent = new AndroidIntent(
          action: 'action_view',
          data: Uri.encodeFull(
              "https://www.google.com/maps/dir/?api=1&origin=" +
                  origin +
                  "&destination=" +
                  destination +
                  "&travelmode=driving"),
          package: 'com.google.android.maps.MapsActivity');
      intent.launch();
    } else {
      String url = "https://www.google.com/maps/dir/?api=1&origin=" +
          origin +
          "&destination=" +
          destination +
          "&travelmode=driving";
      if (await canLaunch(url) != null) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
