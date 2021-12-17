import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Modeles/GetStoredetailesModel.dart';
import 'package:matsapp/Network/GetStoreDetailesRest.dart';
import 'package:matsapp/Pages/coupon_generate/coupon_generateNew.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/DetailesDialog.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:matsapp/widgets/Couponbackground.dart';

class StorecouponWidgetNew extends StatefulWidget {
  final int business_id;
  final String selectedTown;

  StorecouponWidgetNew(this.business_id, this.selectedTown);

  @override
  _StorecouponWidgetState createState() => _StorecouponWidgetState();
}

class _StorecouponWidgetState extends State<StorecouponWidgetNew> {
  var futurestoreDetailes;

  String townSelectedStore;

  String mobileNumber;

  var apikey;

  // _StorecouponWidgetState({Key key}) : super(key: key);
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
    futurestoreDetailes = fetchStordetailes(widget.business_id);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // MediaQuery.of(context).padding.top -
    // kTextTabBarHeight;

    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: screenHeight * .40,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            //width: screenWidth,
            // height: screenHeight * .40,
            child: FutureBuilder<GetStoredetailesModel>(
                future: futurestoreDetailes,
                builder: (BuildContext context,
                    AsyncSnapshot<GetStoredetailesModel> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.storeCoupon.length > 0) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 8, bottom: 10),
                                //padding: const EdgeInsets.only(top: 0.0, left: 8, bottom: 10),
                                child: Text(
                                  "Your Discount coupon",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.storeCoupon.length,
                              physics: ScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: screenWidth * .75,
                                  height: screenHeight * .50,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        snapshot.data.storeCoupon[index]
                                                        .freeCouponFlag ==
                                                    null ||
                                                snapshot.data.storeCoupon[index]
                                                        .freeCouponFlag ==
                                                    "false"
                                            ? Container()
                                            : Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                      snapshot
                                                          .data
                                                          .storeCoupon[index]
                                                          .freeCouponFlag,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: SizeConfig
                                                                  .blockSizeVertical *
                                                              2.5,
                                                          color: AppColors
                                                              .success_color),
                                                      textAlign:
                                                          TextAlign.start),
                                                ),
                                              ),

                                        InkWell(
                                          child: Stack(
                                            children: [
                                              Couponbackground(
                                                  snapshot
                                                      .data
                                                      .storeCoupon[index]
                                                      .couponType,
                                                  snapshot
                                                          .data
                                                          .storeCoupon[index]
                                                          .couponLeft ??
                                                      ""),
                                              Container(
                                                margin: EdgeInsets.all(10),
                                                width: screenWidth * .88,
                                                height: screenHeight * .25,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      width: screenWidth * .60,
                                                      height:
                                                          screenHeight * .20,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Up to\r",
                                                                  style: TextStyle(
                                                                      letterSpacing:
                                                                          .75,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          SizeConfig.widthMultiplier *
                                                                              6),
                                                                ),
                                                                Text(
                                                                  "${snapshot.data.storeCoupon[index].discount}%",
                                                                  style: TextStyle(
                                                                      letterSpacing:
                                                                          .75,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          SizeConfig.widthMultiplier *
                                                                              6),
                                                                ),
                                                              ],
                                                            ),
                                                            Text("Discount",
                                                                style: TextStyle(
                                                                    letterSpacing:
                                                                        .75,
                                                                    fontSize:
                                                                        SizeConfig.widthMultiplier *
                                                                            5,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white)),
                                                            SizedBox(
                                                              height: SizeConfig
                                                                      .heightMultiplier *
                                                                  1,
                                                            ),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: SizeConfig
                                                                      .widthMultiplier *
                                                                  18,
                                                              height: SizeConfig
                                                                      .heightMultiplier *
                                                                  4.5,
                                                              child:
                                                                  ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: AppColors
                                                                      .kAccentColor,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              2),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              SizeConfig.widthMultiplier)),
                                                                  side:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    new Text(
                                                                      "Details",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            SizeConfig.widthMultiplier *
                                                                                2.5,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                onPressed: () {
                                                                  Dialoges()
                                                                      .detaiesDialogSuccess(
                                                                    context,
                                                                    snapshot
                                                                        .data
                                                                        .storeCoupon[
                                                                            index]
                                                                        .coupondetails,
                                                                  );
                                                                },
                                                              ),
                                                            )
                                                            // Container(
                                                            //   width: screenWidth * .55,
                                                            //   height: screenHeight / 30,
                                                            //   child: Row(
                                                            //     crossAxisAlignment:
                                                            //         CrossAxisAlignment
                                                            //             .center,

                                                            //     // mainAxisAlignment:
                                                            //     //     MainAxisAlignment.center,
                                                            //     children: [
                                                            //       snapshot
                                                            //                   .data
                                                            //                   .storeCoupon[
                                                            //                       index]
                                                            //                   .endDate !=
                                                            //               null
                                                            //           ? Text(
                                                            //               "Until\r:${snapshot.data.storeCoupon[index].endDate}",
                                                            //               style:
                                                            //                   TextStyle(
                                                            //                 fontSize: 12,
                                                            //                 fontWeight:
                                                            //                     FontWeight
                                                            //                         .w500,
                                                            //                 color: Colors
                                                            //                     .white,
                                                            //               ))
                                                            //           : Container(),
                                                            //       SizedBox(width: 8),
                                                            //       snapshot
                                                            //               .data
                                                            //               .storeCoupon[
                                                            //                   index]
                                                            //               .couponType
                                                            //               .contains(
                                                            //                   "Free")
                                                            //           ? Container(
                                                            //               alignment:
                                                            //                   Alignment
                                                            //                       .center,
                                                            //               width: SizeConfig
                                                            //                       .widthMultiplier *
                                                            //                   12,
                                                            //               height: SizeConfig
                                                            //                       .heightMultiplier *
                                                            //                   3.6,
                                                            //               child:
                                                            //                   ElevatedButton(
                                                            //                 style: ElevatedButton
                                                            //                     .styleFrom(
                                                            //                   primary:
                                                            //                       AppColors
                                                            //                           .freecoupon_color,
                                                            //                   padding:
                                                            //                       EdgeInsets
                                                            //                           .all(2),
                                                            //                   shape: RoundedRectangleBorder(
                                                            //                       borderRadius:
                                                            //                           BorderRadius.circular(SizeConfig.widthMultiplier)),
                                                            //                   side:
                                                            //                       BorderSide(
                                                            //                     color: Colors
                                                            //                         .white,
                                                            //                   ),
                                                            //                 ),
                                                            //                 child: Row(
                                                            //                   mainAxisAlignment:
                                                            //                       MainAxisAlignment
                                                            //                           .center,
                                                            //                   children: [
                                                            //                     new Text(
                                                            //                       "Details",
                                                            //                       style:
                                                            //                           TextStyle(
                                                            //                         color:
                                                            //                             Colors.white,
                                                            //                         fontSize:
                                                            //                             SizeConfig.widthMultiplier * 2.5,
                                                            //                       ),
                                                            //                     ),
                                                            //                   ],
                                                            //                 ),
                                                            //                 onPressed:
                                                            //                     () {
                                                            //                   Dialoges()
                                                            //                       .detaiesDialogSuccess(
                                                            //                     context,
                                                            //                     snapshot
                                                            //                         .data
                                                            //                         .storeCoupon[
                                                            //                             index]
                                                            //                         .coupondetails,
                                                            //                   );
                                                            //                 },
                                                            //               ),
                                                            //             )
                                                            //           : Container()
                                                            //     ],
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: screenWidth * .28,
                                                      height:
                                                          screenHeight * .19,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Card(
                                                            //color: Colors.blueAccent,
                                                            elevation: 2,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: snapshot
                                                                  .data
                                                                  .storeCoupon[
                                                                      index]
                                                                  .productImage,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  Center(
                                                                      child:
                                                                          CircularProgressIndicator()),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Icon(Icons
                                                                      .error),
                                                              fit: BoxFit.fill,
                                                              width: SizeConfig
                                                                      .widthMultiplier *
                                                                  18,
                                                              height: SizeConfig
                                                                      .widthMultiplier *
                                                                  18,
                                                            ),
                                                          ),
                                                          // snapshot.data.storeCoupon[index]
                                                          //         .couponType
                                                          //         .contains("Free")
                                                          //     ? Container(
                                                          //         width: 101,
                                                          //         child: Row(
                                                          //           mainAxisAlignment:
                                                          //               MainAxisAlignment
                                                          //                   .center,
                                                          //           children: [
                                                          //             Image.asset(
                                                          //                 "assets/images/rupee.png",
                                                          //                 color: Colors
                                                          //                     .white,
                                                          //                 width: 15,
                                                          //                 height: 15),
                                                          //             FittedBox(
                                                          //               fit: BoxFit
                                                          //                   .fitWidth,
                                                          //               child: new Text(
                                                          //                 "${snapshot.data.storeCoupon[index].couponValue}",
                                                          //                 style: TextStyle(
                                                          //                     fontWeight:
                                                          //                         FontWeight
                                                          //                             .bold,
                                                          //                     color: Colors
                                                          //                         .white,
                                                          //                     fontSize:
                                                          //                         SizeConfig.widthMultiplier *
                                                          //                             7),
                                                          //               ),
                                                          //             ),
                                                          //           ],
                                                          //         ),
                                                          //       ):
                                                          // Container(
                                                          //     alignment: Alignment.center,
                                                          //     width: SizeConfig
                                                          //             .widthMultiplier *
                                                          //         12,
                                                          //     height: SizeConfig
                                                          //             .heightMultiplier *
                                                          //         3.6,
                                                          //     child: OutlinedButton(
                                                          //       style: OutlinedButton
                                                          //           .styleFrom(
                                                          //         padding:
                                                          //             EdgeInsets.all(2),
                                                          //         shape: RoundedRectangleBorder(
                                                          //             borderRadius:
                                                          //                 BorderRadius.circular(
                                                          //                     SizeConfig
                                                          //                         .widthMultiplier)),
                                                          //         side: BorderSide(
                                                          //           color: Colors.white,
                                                          //         ),
                                                          //       ),
                                                          //       child: Row(
                                                          //         mainAxisAlignment:
                                                          //             MainAxisAlignment
                                                          //                 .center,
                                                          //         children: [
                                                          //           new Text(
                                                          //             "Details",
                                                          //             textAlign: TextAlign
                                                          //                 .center,
                                                          //             style: TextStyle(
                                                          //               color:
                                                          //                   Colors.white,
                                                          //               fontSize: SizeConfig
                                                          //                       .widthMultiplier *
                                                          //                   2.5,
                                                          //             ),
                                                          //           ),
                                                          //         ],
                                                          //       ),
                                                          //       onPressed: () {
                                                          //         Dialoges()
                                                          //             .detaiesDialogSuccess(
                                                          //           context,
                                                          //           snapshot
                                                          //               .data
                                                          //               .storeCoupon[
                                                          //                   index]
                                                          //               .coupondetails,
                                                          //         );
                                                          //       },
                                                          //     )),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            var couponId = (snapshot.data
                                                .storeCoupon[index].couponId);
                                            if (snapshot.data.storeCoupon[index]
                                                    .couponAvailableFlag ==
                                                "false") {
                                              GeneralTools().createSnackBarCommon(
                                                  "This Coupon is Already Purchased",
                                                  context);
                                            } else {
                                              if (snapshot
                                                      .data
                                                      .storeCoupon[index]
                                                      .couponType ==
                                                  "Paid") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CouponGeneratePageNew(
                                                              couponId:
                                                                  couponId,
                                                              type: "Store",
                                                              couponType: snapshot
                                                                  .data
                                                                  .storeCoupon[
                                                                      index]
                                                                  .couponType,
                                                            )));
                                              } else if (snapshot
                                                      .data
                                                      .storeCoupon[index]
                                                      .couponType ==
                                                  "Free") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CouponGeneratePageNew(
                                                              couponId:
                                                                  couponId,
                                                              type: "Store",
                                                              couponType: snapshot
                                                                  .data
                                                                  .storeCoupon[
                                                                      index]
                                                                  .couponType,
                                                            )));
                                              }
                                            }
                                          },
                                        ),
                                        // Container(
                                        //   width: screenWidth,
                                        //   height: screenHeight / 20,
                                        //   child: Center(
                                        //     child: Column(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.spaceBetween,
                                        //       children: [
                                        //         snapshot.data.storeCoupon[index]
                                        //                 .couponType
                                        //                 .contains("Free")
                                        //             ? Row(
                                        //                 mainAxisAlignment:
                                        //                     MainAxisAlignment
                                        //                         .spaceAround,
                                        //                 crossAxisAlignment:
                                        //                     CrossAxisAlignment.center,
                                        //                 children: [
                                        //                   Text(
                                        //                     "Get Rs ${snapshot.data.storeCoupon[index].couponValue}\rcoupon for Free",
                                        //                     style: TextStyle(
                                        //                         fontSize: SizeConfig
                                        //                                 .widthMultiplier *
                                        //                             4.8,
                                        //                         color: Colors.grey),
                                        //                   ),
                                        //                   Icon(Icons.arrow_forward)
                                        //                 ],
                                        //               )
                                        //             : Row(
                                        //                 mainAxisAlignment:
                                        //                     MainAxisAlignment
                                        //                         .spaceAround,
                                        //                 crossAxisAlignment:
                                        //                     CrossAxisAlignment.center,
                                        //                 children: [
                                        //                   Row(
                                        //                     children: [
                                        //                       Text(
                                        //                         "Coupon Starting from",
                                        //                         style: TextStyle(
                                        //                             fontSize: SizeConfig
                                        //                                     .widthMultiplier *
                                        //                                 4.8,
                                        //                             color:
                                        //                                 Colors.grey),
                                        //                       ),
                                        //                       Text(
                                        //                         "\rRs\r${snapshot.data.storeCoupon[index].couponValue}",
                                        //                         style: TextStyle(
                                        //                             fontSize: SizeConfig
                                        //                                     .widthMultiplier *
                                        //                                 5,
                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .bold,
                                        //                             color: Colors
                                        //                                 .grey[600]),
                                        //                       )
                                        //                     ],
                                        //                   ),
                                        //                   Icon(Icons.arrow_forward)
                                        //                 ],
                                        //               ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                        // SizedBox(
                                        //   height: 10,
                                        // ),
                                        // snapshot.data.storeCoupon.length == 1
                                        //     ? Divider(
                                        //         height: 2,
                                        //         thickness: 3,
                                        //         color: Colors.grey[180],
                                        //       )
                                        //     : Container()
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }
}
