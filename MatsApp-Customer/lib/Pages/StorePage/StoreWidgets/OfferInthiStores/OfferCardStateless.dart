import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Modeles/GetStoredetailesModel.dart';
import 'package:matsapp/Network/GetStoreDetailesRest.dart';
import 'package:matsapp/Pages/TrendingOffers/ProductPageTrending.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';

class OfferCardStateless extends StatefulWidget {
  //OfferCardStateless({Key key, this.choice}) : super(key: key);
  //final Choice choice;
  final int businessId;
  final String mobileNumber;
  final String selectedTown;
  OfferCardStateless(this.businessId, this.mobileNumber, this.selectedTown);
  @override
  _OfferCardStatelessState createState() => _OfferCardStatelessState();
}

class _OfferCardStatelessState extends State<OfferCardStateless> {
  var futurestoreDetailes;

  @override
  void initState() {
    futurestoreDetailes = fetchStordetailes(
      widget.businessId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetStoredetailesModel>(
        future: futurestoreDetailes,
        builder: (BuildContext context,
            AsyncSnapshot<GetStoredetailesModel> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data.allOffers.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.3),
                //crossAxisSpacing: ,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        // margin: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // width: 150,
                              //height: 100,
                              child: CachedNetworkImage(
                                imageUrl:
                                    snapshot.data.allOffers[index].productImage,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.image,
                                  size: 50,
                                ),
                                fit: BoxFit.contain,
                                width: MediaQuery.of(context).size.width * .50,
                                height:
                                    MediaQuery.of(context).size.height * .18,
                              ),
                            ),
                            Wrap(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data.allOffers[index].offerName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,

                                  style: AppTextStyle.productNameFont(),
                                  //textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 5, left: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  snapshot.data.allOffers[index].mrp != 0 &&
                                              snapshot.data.allOffers[index]
                                                      .mrp !=
                                                  null ||
                                          snapshot.data.allOffers[index]
                                                      .offerPrice !=
                                                  "0" &&
                                              snapshot.data.allOffers[index]
                                                      .offerPrice !=
                                                  null
                                      ? Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/rupee.png",
                                              color:
                                                  AppColors.kSecondaryDarkColor,
                                              width: 15,
                                              height: 15,
                                            ),
                                            snapshot.data.allOffers[index]
                                                            .mrp !=
                                                        0 ||
                                                    snapshot
                                                            .data
                                                            .allOffers[index]
                                                            .offerPrice !=
                                                        "0"
                                                ? Text(
                                                    "${snapshot.data.allOffers[index].mrp}/-",
                                                    style: AppTextStyle
                                                        .productPriceFont(
                                                            color:
                                                                Colors.black),
                                                  )
                                                : Text(
                                                    "${snapshot.data.allOffers[index].offerPrice}/-",
                                                    style: AppTextStyle
                                                        .productPriceFont(
                                                            color:
                                                                Colors.black),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "${snapshot.data.allOffers[index].rating}",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.orange,
                                          size: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                snapshot.data.allOffers[index].saveAmount !=
                                            "0" ||
                                        snapshot.data.allOffers[index]
                                                .saveAmount !=
                                            null
                                    ? Text(
                                        "${snapshot.data.allOffers[index].saveAmount}",
                                        style: AppTextStyle.productPriceFont(
                                          color: AppColors.success_color,
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductPageTrending(
                              snapshot.data.allOffers[index].offerId,
                              widget.selectedTown,
                              snapshot.data.allOffers[index].businessName ?? "",
                              snapshot.data.allOffers[index].businessId)),
                    );
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
