import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

import 'package:matsapp/Modeles/StoreDealsModel.dart';
import 'package:matsapp/Network/AddTowishListRest.dart';
import 'package:matsapp/Network/RemovefromwishlistRest.dart';

import 'package:matsapp/Network/StoreDealsRest.dart';
import 'package:matsapp/Pages/TrendingOffers/ProductPageTrending.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/constants/app_vectors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/size_config.dart';

class ProductListWidgetsTrending2 extends StatefulWidget {
  //OfferCardStateless({Key key, this.choice}) : super(key: key);
  //final Choice choice;
  //final int businessId;
  //final String mobileNumber;
  final String selectedTown;
  ProductListWidgetsTrending2(this.selectedTown);
  @override
  _ProductListWidgetsTrendingState createState() =>
      _ProductListWidgetsTrendingState();
}

class _ProductListWidgetsTrendingState
    extends State<ProductListWidgetsTrending2> {
  String townSelectedStore;

  Future exclusiveFuture;

  String mobileNumber;

  bool wishliststatus;

  String apikey;

  Position _currentPosition;

  String userLatitude;

  String userLogitude;

  Future<StoreDealsModel> storeDealsFuture;

  TrendingOffersBloc trendingBloc2;

  @override
  void initState() {
    super.initState();

    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          setState(() {
            townSelectedStore = value[0].selectedTown;
            mobileNumber = value[0].mobilenumber;
            apikey = value[0].apitoken;
            // exclusiveFuture =
            //     fetchStoreDeals(townSelectedStore, mobileNumber, apikey);
          }),
          //_getCurrentLocation()
        });
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<List<List1>>(
        stream: trendingBloc2.list2Stream2,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                //crossAxisSpacing: ,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.2),
              ),
              itemBuilder: (BuildContext context, int index) {
                if (snapshot.data[index].wishListId == 0) {
                  wishliststatus = false;
                } else if (snapshot.data[index].wishListId > 0) {
                  wishliststatus = true;
                }
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: screenWidth * .55,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      icon: SvgPicture.asset(
                                        wishliststatus
                                            ? AppVectors.ic_heart1
                                            : AppVectors.ic_heart,
                                        height: screenHeight * .02,
                                        // color: wishliststatus
                                        //     ? Colors.pink
                                        //     : Colors.blueGrey,
                                      ),
                                      onPressed: () {
                                        snapshot.data[index].wishListId == 0
                                            ? fetchAddTowishList(
                                                    "Category",
                                                    snapshot
                                                        .data[index].offerId,
                                                   )
                                                .then(
                                                (value) => {
                                                  if (value.result == 1)
                                                    {
                                                      fetchdata(),
                                                      //fetchTopStore(town, mobile, latitude, longitude)
                                                      setState(() {
                                                        wishliststatus = true;
                                                      }),
                                                      GeneralTools()
                                                          .createSnackBarSuccess(
                                                              "Added to your Wishlist",
                                                              context)
                                                    }
                                                },
                                              )
                                            : fetchRemoveFromwishList(
                                                  
                                                    snapshot
                                                        .data[index].wishListId)
                                                .then((value) => {
                                                      if (value.result == 0)
                                                        {
                                                          fetchdata(),
                                                          setState(() {
                                                            wishliststatus =
                                                                false;
                                                          }),
                                                          GeneralTools()
                                                              .createSnackBarFailed(
                                                                  "Removed from Wishlist",
                                                                  context)
                                                        }
                                                    });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data[index].productImage,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.image,
                                  size: 50,
                                ),
                                fit: BoxFit.contain,
                                width: MediaQuery.of(context).size.width * .40,
                                height:
                                    MediaQuery.of(context).size.height * .18,
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.only(top: 5, left: 6, right: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Text(
                                      snapshot.data[index].offerName,
                                      style: AppTextStyle.productNameFont(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(1),
                                    height: 20,
                                    width: SizeConfig.widthMultiplier * 10,
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
                                          "${snapshot.data[index].rating}" ??
                                              "",
                                          style: TextStyle(fontSize: 12),
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
                            Container(
                              padding:
                                  EdgeInsets.only(bottom: 5, left: 6, right: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  snapshot.data[index].offerPrice != "0.000" &&
                                          snapshot.data[index].offerPrice !=
                                              null
                                      ? Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/rupee.png",
                                              color: Colors.black,
                                              width: 10,
                                              height: 10,
                                            ),
                                            Text(
                                              "${snapshot.data[index].offerPrice}/-" ??
                                                  "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  // FaIcon(FontAwesomeIcons.rupeeSign),

                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 14,
                                          color: Colors.orange[800],
                                        ),
                                        Text(
                                          "${snapshot.data[index].distanceinKm}\rKms" ??
                                              "",
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  snapshot.data[index].saveAmount != "0" &&
                                          snapshot.data[index].saveAmount !=
                                              null
                                      ? Text(
                                          "${snapshot.data[index].saveAmount}" ??
                                              "",
                                          style: TextStyle(
                                              color: AppColors.success_color,
                                              fontWeight: FontWeight.bold,
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3),
                                        )
                                      : Container(),
                                ],
                              ),
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
                              snapshot.data[index].offerId,
                              townSelectedStore,
                              snapshot.data[index].businessName,
                              snapshot.data[index].businessId)),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  fetchdata() {
    trendingBloc2 = TrendingOffersBloc();
    trendingBloc2.eventSink.add(TrendingOffersAction.fetch);
    // storeDealsFuture = fetchStoreDeals(
    //     townSelectedStore, mobileNumber, apikey, userLatitude, userLogitude);
  }

  _getCurrentLocation() {
    //fetchdata();
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        userLatitude = ' ${position.latitude}';
        userLogitude = '${position.longitude}';
      });

      print('${position.latitude}');
      print('${position.longitude}');
      // print(' ${position.}');
    }).catchError((e) {
      print(e);
    });
    //fetchdata();
  }
}
