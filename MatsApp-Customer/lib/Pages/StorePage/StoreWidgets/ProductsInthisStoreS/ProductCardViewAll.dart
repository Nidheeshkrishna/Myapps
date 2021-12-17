import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:matsapp/Modeles/GetStoredetailesModel.dart';
import 'package:matsapp/Network/GetStoreDetailesRest.dart';
import 'package:matsapp/Pages/StorePage/StoreProductPage.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/size_config.dart';

class ProductCardViewAll extends StatefulWidget {
  //OfferCardStateless({Key key, this.choice}) : super(key: key);
  //final Choice choice;
  final int businessId;
  final String mobileNumber;
  final String selectedTown;
  final String businessname;
  ProductCardViewAll(
      this.businessId, this.mobileNumber, this.selectedTown, this.businessname);
  @override
  _ProductCardViewAllState createState() => _ProductCardViewAllState();
}

class _ProductCardViewAllState extends State<ProductCardViewAll> {
  var futurestoreDetailes;

  @override
  void initState() {
    super.initState();
    futurestoreDetailes = fetchStordetailes(widget.businessId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetStoredetailesModel>(
        future: futurestoreDetailes,
        builder: (BuildContext context,
            AsyncSnapshot<GetStoredetailesModel> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data.allProducts.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: SizeConfig.heightMultiplier,
                  crossAxisCount: 2,
                  //crossAxisSpacing: ,
                  childAspectRatio: 1 / 1.3),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, right: 5, left: 5),
                      child: Container(
                        // margin: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              // width: 150,
                              //height: 100,
                              child: CachedNetworkImage(
                                imageUrl: snapshot
                                    .data.allProducts[index].productImage,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.image, size: 50),
                                fit: BoxFit.contain,
                                width: MediaQuery.of(context).size.width * .50,
                                height:
                                    MediaQuery.of(context).size.height * .18,
                              ),
                            ),
                            Wrap(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, left: 5.0),
                                  child: Text(
                                    snapshot
                                        .data.allProducts[index].productName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: AppTextStyle.productNameFont(),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                snapshot.data.allProducts[index].productPrice >
                                        0
                                    ? Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/rupee.png",
                                            color:
                                                AppColors.kSecondaryDarkColor,
                                            width: 12,
                                            height: 12,
                                          ),
                                          snapshot.data.allProducts[index]
                                                      .matsappPrice ==
                                                  0
                                              ? Text(
                                                  "MRP:${snapshot.data.allProducts[index].productPrice}/-",
                                                  style: AppTextStyle
                                                      .productMRPFont(),
                                                )
                                              : Text(
                                                  "MRP:${snapshot.data.allProducts[index].productPrice}/-",
                                                  style: AppTextStyle
                                                      .productMRPFont(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                )
                                        ],
                                      )
                                    : Container(),
                                // FaIcon(FontAwesomeIcons.rupeeSign),

                                Container(
                                  padding: EdgeInsets.all(1),
                                  height: 20,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.orange),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      new Text(
                                        '${snapshot.data.allProducts[index].rating}',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.orange[400],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            snapshot.data.allProducts[index].matsappPrice > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.0,
                                            bottom:
                                                SizeConfig.heightMultiplier),
                                        child: Text(
                                          "Matsapp Price:${snapshot.data.allProducts[index].matsappPrice}/-",
                                          style:
                                              AppTextStyle.productPriceFont(),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StoreProductPage(
                                  snapshot.data.allProducts[index].productId,
                                  widget.selectedTown,
                                  snapshot.data.allProducts[index]
                                          .productName ??
                                      "",
                                  snapshot.data.allProducts[index].businessId,
                                  widget.businessname,
                                )));
                  },
                );
              },
            );
          } else {
            return Container();
          }
        });
  }
}
