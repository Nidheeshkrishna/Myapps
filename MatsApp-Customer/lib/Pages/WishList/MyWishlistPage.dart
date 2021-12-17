import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:matsapp/Modeles/WishlistModel.dart';
import 'package:matsapp/Network/wishlistRest.dart';
import 'package:matsapp/Pages/StorePage/StorePageProduction.dart';
import 'package:matsapp/Pages/StorePage/StoreProductPage.dart';
import 'package:matsapp/Pages/TrendingOffers/ProductPageTrending.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MyWishlistPage extends StatefulWidget {
  //final String mobile;
  //final double Latitude, Longitude;
  //MyWishlistPage({this.mobile, this.Latitude, this.Longitude});
  @override
  _Wishlistpage1State createState() => _Wishlistpage1State();
}

class _Wishlistpage1State extends State<MyWishlistPage> {
  Future wishlist;

  double userLatitude;

  double userLogitude;

  String mobileNumber;

  String user_town;

  LatLng currentPostion;

  Position _currentPosition;

  @override
  void initState() {
    super.initState();
    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          setState(() {
            mobileNumber = value.first.mobilenumber;
            user_town = value.first.selectedTown;
            _getUserLocation();
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey[800],
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'WishList',
            style: TextStyle(color: Colors.grey[800], fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<WishlistModel>(
            future: wishlist,
            builder:
                (BuildContext context, AsyncSnapshot<WishlistModel> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.result.length > 0) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.result.length,
                      physics: ClampingScrollPhysics(),
                      //physics: const NeverScrollableScrollPhysics(),

                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child: Card(
                            elevation: 5,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    clipBehavior: Clip.hardEdge,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          snapshot.data.result[index].imageUrl,
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      fit: BoxFit.fill,
                                      width: MediaQuery.of(context).size.width *
                                          .30,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .20,
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .50,
                                    height: MediaQuery.of(context).size.height *
                                        .20,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                snapshot.data.result[index]
                                                    .businessName,
                                                softWrap: true,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          children: [
                                            Text(snapshot
                                                .data.result[index].rating
                                                .toString()),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            SmoothStarRating(
                                                allowHalfRating: false,
                                                onRated: (v) {},
                                                starCount: 5,
                                                rating: snapshot
                                                    .data.result[index].rating
                                                    .toDouble(),
                                                size: 15.0,
                                                isReadOnly: true,
                                                color: Colors.orange[800],
                                                borderColor: Colors.orange[800],
                                                spacing: 0.0),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            // Text(
                                            //   snapshot.data.result[index].rating
                                            //           .toString() +
                                            //       '(Reviews)',
                                            //   style: TextStyle(fontSize: 10),
                                            // ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            // Container(
                                            //     child: Text(
                                            //   'Location :',
                                            //   style: TextStyle(fontSize: 12),
                                            // )),
                                            Container(
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        50,
                                                child: Text(
                                                  snapshot.data.result[index]
                                                          .location ??
                                                      "",
                                                  overflow: TextOverflow.fade,
                                                  softWrap: false,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        // SizedBox(
                                        //   width: 20,
                                        // ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                size: 16,
                                                color: Colors.orange[800],
                                              ),
                                              Text(
                                                '${snapshot.data.result[index].distanceinKm}\rKms',
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: 8,
                                        // ),
                                        snapshot.data.result[index]
                                                        .provideOffers ==
                                                    "0" ||
                                                snapshot.data.result[index]
                                                        .provideOffers ==
                                                    null
                                            ? Container()
                                            : Container(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 45,
                                                                  right: 45),
                                                          primary: Colors
                                                              .yellow[800]),
                                                  // padding: EdgeInsets.only(
                                                  //     left: 35, right: 35),
                                                  // color: Colors.yellow[800],
                                                  onPressed: () {},
                                                  child: Text(
                                                    "${snapshot.data.result[index].provideOffers}%",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                          onTap: () {
                            switch (snapshot.data.result[index].category) {
                              case "Store":
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            StorePageProduction(
                                              (snapshot.data.result[index]
                                                  .categoryId),
                                              user_town,
                                              snapshot.data.result[index]
                                                  .businessName,
                                            )),
                                  );
                                }
                                break;
                              case "Product":
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StoreProductPage(
                                              snapshot.data.result[index]
                                                  .categoryId,
                                              user_town,
                                              snapshot.data.result[index]
                                                  .productName,
                                              snapshot.data.result[index]
                                                  .businessId,
                                              snapshot.data.result[index]
                                                  .businessName,
                                            )),
                                  );
                                }
                                break;

                              case "Offer":
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductPageTrending(
                                                (snapshot.data.result[index]
                                                    .categoryId),
                                                user_town,
                                                snapshot.data.result[index]
                                                    .businessName,
                                                (snapshot.data.result[index]
                                                    .categoryId))),
                                  );
                                }
                            }
                          },
                        );
                      });
                } else {
                  return Center(
                      child: Text(
                    'Your wishlist is Empty...',
                    style: TextStyle(
                        color: AppColors.kAccentColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ));
                }
              } else if (snapshot.hasError) {
                return Center(child: Text('Something went wrong...'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
      userLatitude = currentPostion.latitude;
      userLogitude = currentPostion.longitude;
    });
    fetchData();
  }

  fetchData() {
    wishlist = fetchWishlist(mobileNumber, userLatitude, userLogitude);
  }
}
