import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matsapp/Network/StoreDealsRest.dart';
import 'package:matsapp/Pages/Providers/HomeproviderWithOffers.dart';
import 'package:matsapp/Pages/TrendingOffers/ProductPageTrending.dart';
import 'package:matsapp/Pages/TrendingOffers/ProductViewAllTrending.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrendingOfferers extends StatefulWidget {
  @override
  _ExclusiveDealsWidget1State createState() => _ExclusiveDealsWidget1State();
}

class _ExclusiveDealsWidget1State extends State<TrendingOfferers> {
  SharedPreferences prefs;
  Future storeDealsFuture;

  String townSelectedStore;

  String mobileNumber;

  var apikey;

  Position _currentPosition;

  String userLatitude;

  String userLogitude;

  @override
  void initState() {
    super.initState();
    //_getCurrentLocation();
    //getLocation();
    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          if (mounted)
            setState(() {
              townSelectedStore = value[0].selectedTown;
              mobileNumber = value[0].mobilenumber;
              apikey = value[0].apitoken;
              // storeDealsFuture = fetchStoreDeals(townSelectedStore, mobileNumber,
              //     apikey, userLatitude, userLogitude);
            }),

          // prefcheck(
          //     value[0].mobilenumber, value[0].location, value[0].apitoken),
          // // GeneralTools().prefsetLoginInfo(
          // //     ),
        });
    // _trendingBloc = TrendingHomeBloc();
    // _trendingBloc.eventSink.add(TrendingHomeAction.fetch);
    //prefcheck();
  }

  @override
  Widget build(BuildContext context) {
    final trendingDealsdata = Provider.of<HomePageDataProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    final curlScale = MediaQuery.of(context).textScaleFactor;
    //;
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height * .80,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/theme2.png"),
          fit: BoxFit.cover,
        )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              trendingDealsdata.post.apiKeyStatus ?? false
                  ? trendingDealsdata.post.trendingOffer != null
                      ? trendingDealsdata.loading
                          ? Container()
                          : trendingDealsdata.post.trendingOffer.length > 0
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Trending Offers",
                                            style: AppTextStyle.homeWhitefont(),
                                          ),
                                          // ignore: deprecated_member_use
                                          TextButton(
                                            // style: ElevatedButton.styleFrom(
                                            //     primary: Colors.white,
                                            //     elevation: 10,
                                            //     onPrimary: Colors.blue,
                                            //     shape: RoundedRectangleBorder(
                                            //       borderRadius:
                                            //           BorderRadius.circular(7.0),
                                            //     )),
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
                                                        ProductViewAllTrending(
                                                            townSelectedStore)),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    GridView.builder(
                                      padding: EdgeInsets.only(
                                        left: SizeConfig.widthMultiplier * 2.5,
                                        right: SizeConfig.widthMultiplier * 2,
                                      ),
                                      shrinkWrap: true,
                                      itemCount: trendingDealsdata
                                          .post.trendingOffer.length,
                                      physics: ScrollPhysics(),
                                      //physics: const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 1 / 1.4,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 1.0,
                                        mainAxisSpacing: 1.0,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            width: size.shortestSide,
                                            height: size.shortestSide * .65,
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Stack(
                                                      children: <Widget>[
                                                        Card(
                                                            elevation: 2,
                                                            //clipBehavior: Clip.antiAliasWithSaveLayer,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      12.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            1.0),
                                                                    child:
                                                                        InkWell(
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        imageUrl: trendingDealsdata
                                                                            .post
                                                                            .trendingOffer[index]
                                                                            .productImage,
                                                                        placeholder:
                                                                            (context, url) =>
                                                                                Center(child: CircularProgressIndicator()),
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            Icon(
                                                                          Icons
                                                                              .image,
                                                                          size:
                                                                              50,
                                                                        ),
                                                                        fit: BoxFit
                                                                            .contain,
                                                                        width: screenWidth *
                                                                            .50,
                                                                        height: screenHeight *
                                                                            .16,
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => ProductPageTrending(trendingDealsdata.post.trendingOffer[index].offerId, townSelectedStore, trendingDealsdata.post.trendingOffer[index].businessName, trendingDealsdata.post.trendingOffer[index].businessId)),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomCenter,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: Text(
                                                                                  trendingDealsdata.post.trendingOffer[index].offerName ?? "",
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  maxLines: 1,
                                                                                  style: AppTextStyle.productNameFont(),
                                                                                  textAlign: TextAlign.center,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Text("Mrp:", style: AppTextStyle.productMRPFont()),
                                                                                    trendingDealsdata.post.trendingOffer[index].mrp != 0
                                                                                        ? Text(
                                                                                            "\r${trendingDealsdata.post.trendingOffer[index].mrp}/-",
                                                                                            style: TextStyle(color: AppColors.kSecondaryDarkColor, fontWeight: FontWeight.normal, fontSize: 12 * curlScale, decoration: TextDecoration.lineThrough, decorationThickness: 2),
                                                                                            textAlign: TextAlign.center,
                                                                                          )
                                                                                        : Container()
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(2.0),
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: trendingDealsdata.post.trendingOffer[index].offerPrice != "0"
                                                                                      ? Text(
                                                                                          "Offer Price:\r${trendingDealsdata.post.trendingOffer[index].offerPrice}/-",
                                                                                          style: AppTextStyle.productPriceFont(color: Colors.black),
                                                                                          textAlign: TextAlign.center,
                                                                                        )
                                                                                      : Container(),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 20,
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                screenWidth * .60,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                trendingDealsdata.post.trendingOffer[index].saveAmount != "0"
                                                                                    ? Flexible(
                                                                                        flex: 2,
                                                                                        child: Text(
                                                                                          "${trendingDealsdata.post.trendingOffer[index].saveAmount}",
                                                                                          style: AppTextStyle.productPriceFont(color: AppColors.success_color),
                                                                                          textAlign: TextAlign.center,
                                                                                        ),
                                                                                      )
                                                                                    : Container(),
                                                                                SizedBox(
                                                                                  height: 20,
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )),
                                                                ],
                                                              ),
                                                            )),
                                                        trendingDealsdata
                                                                    .post
                                                                    .trendingOffer[
                                                                        index]
                                                                    .discount >
                                                                0
                                                            ? Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          4.0),
                                                                  child: Stack(
                                                                    children: [
                                                                      Image.asset(
                                                                          "assets/images/topbadge.png"),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            top:
                                                                                8.0,
                                                                            left:
                                                                                8,
                                                                            right:
                                                                                5),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              "\r${trendingDealsdata.post.trendingOffer[index].discount}%\nOFF",
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ))
                                                            : Container()
                                                      ]),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              : Container()
                      : Container()
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  prefcheck() async {
    // ignore: invalid_use_of_visible_for_testing_member
    //SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    setState(() {
      townSelectedStore = prefs.getString('Selected_Town');
    });
    //print("selected town @@@@@@@@@@@@@@@$townSelectedStore");
  }

  final List<Map<String, Object>> dummyData = [
    {
      'id': '1',
      'image_url': 'assets/images/microvWaveOven.jpg',
      'title': "Hurry up",
      "product": "Microwave Oven"
    },
    {
      'id': '2',
      'image_url': 'assets/images/applewatch.jpg',
      'title': "Hurry up",
      "product": "Watches"
    },
    {
      'id': '3',
      'image_url': 'assets/images/bluetoothspeaker.png',
      'title': "Hurry up",
      "product": "Bluetooh Speaker"
    },
    {
      'id': '3',
      'image_url': 'assets/images/fashion.jpg',
      'title': "Hurry up",
      "product": "Fasion"
    },
  ];
  fetchdata() {
    storeDealsFuture = fetchStoreDeals(
        townSelectedStore, mobileNumber, apikey, userLatitude, userLogitude);
  }
}
