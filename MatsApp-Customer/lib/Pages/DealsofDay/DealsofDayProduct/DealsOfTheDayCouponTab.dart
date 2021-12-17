import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Modeles/ProductListModel.dart';
import 'package:matsapp/Network/ProductRepo.dart';
import 'package:matsapp/Pages/coupon_generate/coupon_generateNew.dart';

import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/DetailesDialog.dart';
import 'package:matsapp/widgets/ProductCouponBground.dart';

class DealsOfTheDayCouponTab extends StatefulWidget {
  final int productId;
  final String selectedtown;

  DealsOfTheDayCouponTab(this.productId, this.selectedtown);

  @override
  _CouponsTabState createState() => _CouponsTabState();
}

class _CouponsTabState extends State<DealsOfTheDayCouponTab> {
  Future futureProduct;
  @override
  void initState() {
    super.initState();
    setState(() {
      futureProduct = fetchTopProduct(widget.productId, widget.selectedtown);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kTextTabBarHeight;

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder<ProductListModel>(
          future: futureProduct,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.result.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      child: Container(
                        width: screenWidth,
                        height: screenHeight * .42,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Stack(
                              children: [
                                ProductCouponBground(
                                    snapshot.data.result[index].couponType),
                                Center(
                                  child: Container(
                                    width: screenWidth * .92,
                                    height: screenHeight * .32,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: screenWidth * .50,
                                          height: screenHeight * .15,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "${snapshot.data.result.first.discount}%",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30),
                                                ),
                                                Text("Discount",
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  width: screenWidth * .55,
                                                  height: screenHeight / 30,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    // mainAxisAlignment:
                                                    //     MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                          "Until\r:${snapshot.data.result.first.expiryDate}",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.white,
                                                          )),
                                                      SizedBox(width: 8),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: screenWidth * .35,
                                          height: screenHeight * .20,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: Card(
                                                  //color: Colors.blueAccent,
                                                  elevation: 5,

                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  child: CachedNetworkImage(
                                                      imageUrl: snapshot
                                                          .data
                                                          .result
                                                          .first
                                                          .productImage,
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                      fit: BoxFit.fill,
                                                      width: 70,
                                                      height: 70),
                                                ),
                                              ),
                                              Container(
                                                  width: 80,
                                                  height: 30,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: snapshot
                                                                  .data
                                                                  .result[index]
                                                                  .couponType ==
                                                              "Paid"
                                                          ? AppColors
                                                              .kAccentColor
                                                          : AppColors
                                                              .freecoupon_color,
                                                      onPrimary:
                                                          Colors.transparent,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        new Text(
                                                          "Details",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      Dialoges()
                                                          .detaiesDialogSuccess(
                                                        context,
                                                        snapshot
                                                            .data
                                                            .result
                                                            .first
                                                            .couponDetails,
                                                      );
                                                    },
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: screenWidth,
                              height: screenHeight / 20,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Coupon Starting from",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              "\rRs\r${snapshot.data.result.first.couponValue}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[600]),
                                            )
                                          ],
                                        ),
                                        Icon(Icons.arrow_forward)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CouponGeneratePageNew(
                                    couponId:
                                        snapshot.data.result[index].couponId,
                                    type: "Product",
                                    couponType: snapshot
                                        .data.result[index].couponType)));
                      },
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
