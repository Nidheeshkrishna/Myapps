import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:matsapp/Modeles/homePageModels/HomePageWithOffersModel.dart';
import 'package:matsapp/Network/StoreDealsRest.dart';
import 'package:matsapp/Pages/HomePageOfferCategory/OfferCategory_1/OfferCategoryViewAll/OfferCategoryViewAll.dart';
import 'package:matsapp/Pages/TrendingOffers/ProductPageTrending.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfferCategoryPage extends StatefulWidget {
  final List<Offer1> Offer;
  final bool apiKeyStatus;
  OfferCategoryPage(this.Offer, this.apiKeyStatus);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<OfferCategoryPage> {
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
    //final trendingDealsdata = Provider.of<PostDataProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final curlScale = MediaQuery.of(context).textScaleFactor;
    Size size = MediaQuery.of(context).size;
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
              widget.apiKeyStatus ?? false
                  ? widget.Offer != null
                      ? widget.Offer.length > 0
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.Offer.first.offerHeading,
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
                                                    OffersItemesViewAll(
                                                        widget.Offer.first
                                                            .offerHeading,
                                                        widget.Offer.first
                                                            .offerHeadingId)),
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
                                  itemCount: widget.Offer.length,
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
                                              child: Stack(children: <Widget>[
                                                Card(
                                                    elevation: 2,
                                                    //clipBehavior: Clip.antiAliasWithSaveLayer,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 1.0),
                                                            child: InkWell(
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: widget
                                                                    .Offer[
                                                                        index]
                                                                    .productImage,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                                errorWidget:
                                                                    (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(
                                                                  Icons.image,
                                                                  size: 50,
                                                                ),
                                                                fit: BoxFit
                                                                    .contain,
                                                                width:
                                                                    screenWidth *
                                                                        .50,
                                                                height:
                                                                    screenHeight *
                                                                        .16,
                                                              ),
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => ProductPageTrending(
                                                                          widget
                                                                              .Offer[
                                                                                  index]
                                                                              .offerId,
                                                                          townSelectedStore,
                                                                          widget
                                                                              .Offer[
                                                                                  index]
                                                                              .businessName,
                                                                          widget
                                                                              .Offer[index]
                                                                              .businessId)),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          Align(
                                                              alignment: Alignment
                                                                  .bottomCenter,
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          widget.Offer[index].offerName ??
                                                                              "",
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          maxLines:
                                                                              1,
                                                                          style:
                                                                              AppTextStyle.productNameFont(),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  widget.Offer[index]
                                                                              .offerPrice ==
                                                                          "0"
                                                                      ? Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Expanded(
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text("Mrp:", style: AppTextStyle.productMRPFont()),
                                                                                  widget.Offer[index].mrp != 0
                                                                                      ? Text(
                                                                                          "\r${widget.Offer[index].mrp}/-",
                                                                                          style: TextStyle(color: AppColors.kSecondaryDarkColor, fontWeight: FontWeight.normal, fontSize: 12 * curlScale, decorationThickness: 2),
                                                                                          textAlign: TextAlign.center,
                                                                                        )
                                                                                      : Container()
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Expanded(
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text("Mrp:", style: AppTextStyle.productMRPFont()),
                                                                                  widget.Offer[index].mrp != 0
                                                                                      ? Text(
                                                                                          "\r${widget.Offer[index].mrp}/-",
                                                                                          style: TextStyle(color: AppColors.kSecondaryDarkColor, decoration: TextDecoration.lineThrough, fontWeight: FontWeight.normal, fontSize: 12 * curlScale, decorationThickness: 2),
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
                                                                        const EdgeInsets.all(
                                                                            2.0),
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Expanded(
                                                                          child: widget.Offer[index].offerPrice != "0"
                                                                              ? Text(
                                                                                  "Offer Price:\r${widget.Offer[index].offerPrice}/-",
                                                                                  style: AppTextStyle.productPriceFont(color: Colors.black),
                                                                                  textAlign: TextAlign.center,
                                                                                )
                                                                              : Container(),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              20,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            2.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          screenWidth *
                                                                              .60,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Flexible(
                                                                            flex:
                                                                                2,
                                                                            child: widget.Offer[index].saveAmount != "0"
                                                                                ? Text(
                                                                                    "${widget.Offer[index].saveAmount}",
                                                                                    style: AppTextStyle.productPriceFont(color: AppColors.success_color),
                                                                                    textAlign: TextAlign.center,
                                                                                  )
                                                                                : Container(),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                20,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                        ],
                                                      ),
                                                    )),
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

  // _getCurrentLocation() {
  //   //fetchdata();
  //   Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.best,
  //           forceAndroidLocationManager: true)
  //       .then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //       userLatitude = ' ${position.latitude}';
  //       userLogitude = '${position.longitude}';
  //     });

  //     print('${position.latitude}');
  //     print('${position.longitude}');
  //     // print(' ${position.}');
  //   }).catchError((e) {
  //     print(e);
  //   });
  //   fetchdata();
  // }
  getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    var lcp = _locationData.latitude;
    var lgp = _locationData.longitude;
    print("Latitudssss:$lcp");
    print("Logitudeess:$lgp");
    location.enableBackgroundMode(enable: true);
  }
}
