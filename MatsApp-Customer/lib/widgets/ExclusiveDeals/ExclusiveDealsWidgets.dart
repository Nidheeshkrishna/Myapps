import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:geolocator/geolocator.dart';

import 'package:matsapp/Modeles/ExclusiveDealsModel1.dart';
import 'package:matsapp/Modeles/homePageModels/HomePageModel.dart';
import 'package:matsapp/Network/Bloc/exclussiveDealsBloc.dart';

import 'package:matsapp/Pages/ExclusiveDeals/ProductViewAllpage.dart';
import 'package:matsapp/Pages/Providers/Homeprovider.dart';

import 'package:matsapp/Pages/StorePage/StoreProductPage.dart';

import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:matsapp/widgets/ExclusiveDeals/TimerWidget.dart';
import 'package:matsapp/widgets/LoadingWidgets/Loader4Items.dart';
import 'package:provider/provider.dart';

class ExclusiveDealsWidgets extends StatefulWidget {
  @override
  _ExclusiveDealsWidgetsState createState() => _ExclusiveDealsWidgetsState();
}

class _ExclusiveDealsWidgetsState extends State<ExclusiveDealsWidgets> {
  // List<String> _timeuntils = List(2);

  GlobalKey<_ExclusiveDealsWidgetsState> _myKey = GlobalKey();
  Future<ExclusiveDealsModel1> exclusiveFuture;
  //int seconds;
  String townSelectedStore;
  int estimateTs;
  CountdownTimerController controller;

  String mobileNumber;

  int estimatedendTimeSeconds;

  String apikey;

  Position _currentPosition;

  String userLatitude;
  ExclusiveDealsModel1 exclusiveDealsModelTime;
  String userLogitude;
  //AnimationController _controller;
  StreamController<ExclusiveDealsModel1> _userController1;

  
  void dispose() {
    super.dispose();
    // _exclusiveDealsBloc.dispose();
  }

  @override
  void initState() {
    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          if (mounted)
            {
              setState(() {
                townSelectedStore = value[0].selectedTown;
                mobileNumber = value[0].mobilenumber;
                apikey = value[0].apitoken;
              }),
              _getCurrentLocation(),
            }
        });
    //Timer.periodic(Duration(seconds: 10), (_) => fetchdata());
    // _userController1 = new StreamController();
    // Timer.periodic(Duration(seconds: 1), (_) => loadDetails());
    // _exclusiveDealsBloc = ExclussiveDealsHomeBloc();
    // _exclusiveDealsBloc.eventSink.add(ExclussiveDealsHomeBlocAction.fetch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //dateAndTimeDifferance("2021/4/8", "5:00:00", "2021/5/8", "9:00:00");
    final exclusiveDealsdata = Provider.of<PostDataProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;

    double screenheight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.amberAccent,
      // width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height * .90,
      // decoration: BoxDecoration(
      //image: DecorationImage(
      //image: AssetImage("assets/images/theme.png"),
      // fit: BoxFit.cover,
      // )),

      child: Container(
        child: Column(
          children: [
            exclusiveDealsdata.post.apiKeyStatus ?? false
                ? exclusiveDealsdata.post.exclusiveDeals != null
                    ? exclusiveDealsdata.loading
                        ? Container(
                            child: LoaderWidget4("Exclusive Deals"),
                          )
                        : exclusiveDealsdata.post.exclusiveDeals.length > 0
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                        left: 13,
                                        right: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "Exclusive Deals",
                                              style:
                                                  AppTextStyle.homeTitlesfont(
                                                      color: Colors.grey[900]),
                                            )
                                          ],
                                        ),

                                        TextButton(
                                          // style: ElevatedButton.styleFrom(
                                          //   primary: Colors.white,
                                          //   onPrimary: Colors.blue,
                                          // ),
                                          child: Row(children: [
                                            Text("View All ",
                                                style: AppTextStyle
                                                    .homeViewAllFont(
                                                        color:
                                                            Colors.grey[900])),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 14,
                                              color: Colors.grey[900],
                                            ),
                                          ]),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductViewAllpage(
                                                          townSelectedStore)),
                                            );
                                          },
                                        )
                                        // ignore: deprecated_member_use
                                      ],
                                    ),
                                  ),
                                  GridView.builder(
                                    padding: EdgeInsets.only(
                                      left: SizeConfig.widthMultiplier * 2.5,
                                      right: SizeConfig.widthMultiplier * 2,
                                    ),
                                    itemCount: exclusiveDealsdata
                                        .post.exclusiveDeals.length,
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisSpacing: 10,
                                            crossAxisCount: 2,
                                            childAspectRatio: 1 / 1.3),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Stack(children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 0, right: 0),
                                          //width: 400,
                                          //height: 200,
                                          child: InkWell(
                                              child: Card(
                                                  elevation: 2,
                                                  //clipBehavior: Clip.antiAliasWithSaveLayer,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Container(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 2.0),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: exclusiveDealsdata
                                                                  .post
                                                                  .exclusiveDeals[
                                                                      index]
                                                                  .productImage,
                                                              placeholder:
                                                                  (context,
                                                                          url) =>
                                                                      Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        50.0),
                                                                child: Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                              ),
                                                              errorWidget:
                                                                  (context, url,
                                                                          error) =>
                                                                      Icon(
                                                                Icons.image,
                                                                size: 50,
                                                              ),
                                                              fit: BoxFit
                                                                  .contain,
                                                              width:
                                                                  screenWidth *
                                                                      .32,
                                                              height:
                                                                  screenheight *
                                                                      .18,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets.only(
                                                                      left:
                                                                          SizeConfig.widthMultiplier *
                                                                              1,
                                                                      right: SizeConfig
                                                                          .widthMultiplier),
                                                                  child: Text(
                                                                    exclusiveDealsdata
                                                                            .post
                                                                            .exclusiveDeals[index]
                                                                            .productName ??
                                                                        "",
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: AppTextStyle
                                                                        .productNameFont(),
                                                                    softWrap:
                                                                        true,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                              //Text("Hurry up"),
                                                            ],
                                                          ),
                                                          Container(
                                                            width: screenWidth *
                                                                .5,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    exclusiveDealsdata.post.exclusiveDeals[index].matsappPrice ==
                                                                            "0"
                                                                        ? Container()
                                                                        : Text(
                                                                            "Matsapp Price:\r${exclusiveDealsdata.post.exclusiveDeals[index].matsappPrice}/-",
                                                                            style:
                                                                                AppTextStyle.productPriceFont(),
                                                                            softWrap:
                                                                                true,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                    //Text("Hurry up"),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 5),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          exclusiveDealsdata.post.exclusiveDeals[index].endingDateTime == null
                                                                              ? ""
                                                                              : "Ends in " + exclusiveDealsdata.post.exclusiveDeals[index].endingDateTime,
                                                                          style: TextStyle(
                                                                              fontStyle: FontStyle.italic,
                                                                              color: Colors.black38,
                                                                              fontSize: 10),
                                                                        ),
                                                                        // TimerWidget(
                                                                        //     exclusiveDealsdata
                                                                        //         .post
                                                                        //         .exclusiveDeals[
                                                                        //             index]
                                                                        //         .endDate,
                                                                        //     exclusiveDealsdata
                                                                        //         .post
                                                                        //         .exclusiveDeals[
                                                                        //             index]
                                                                        //         .endTime),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            StoreProductPage(
                                                              exclusiveDealsdata
                                                                  .post
                                                                  .exclusiveDeals[
                                                                      index]
                                                                  .productId,
                                                              townSelectedStore,
                                                              exclusiveDealsdata
                                                                  .post
                                                                  .exclusiveDeals[
                                                                      index]
                                                                  .productName,
                                                              exclusiveDealsdata
                                                                  .post
                                                                  .exclusiveDeals[
                                                                      index]
                                                                  .businessId,
                                                              exclusiveDealsdata
                                                                  .post
                                                                  .exclusiveDeals[
                                                                      index]
                                                                  .businessName,
                                                            )));
                                              }),
                                        ),
                                        exclusiveDealsdata
                                                        .post
                                                        .exclusiveDeals[index]
                                                        .matsappDiscount !=
                                                    "0" &&
                                                exclusiveDealsdata
                                                        .post
                                                        .exclusiveDeals[index]
                                                        .matsappDiscount !=
                                                    null
                                            ? Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0),
                                                    child: Stack(
                                                      children: [
                                                        Image.asset(
                                                            "assets/images/badge1.png"),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20.0,
                                                                  top: 10),
                                                          child: Text(
                                                            "${exclusiveDealsdata.post.exclusiveDeals[index].matsappDiscount}" ??
                                                                "",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      ],
                                                    )))
                                            : Container()
                                      ]);
                                    },
                                  ),
                                  SizedBox(height: 10)
                                ],
                              )
                            : Container()
                    : Container()
                : Container()
          ],
        ),
      ),
    );
  }

  final List<Map<String, Object>> dummyData = [
    {
      'id': '1',
      'image_url': 'assets/PRODUCT/headphones.jpeg',
      'title': "Hurry up",
      "product": "Headphones"
    },
    {
      'id': '2',
      'image_url': 'assets/PRODUCT/washingMachine.jpeg',
      'title': "Hurry up",
      "product": "Washing Machines"
    },
    {
      'id': '3',
      'image_url': 'assets/PRODUCT/watch.jpeg',
      'title': "Hurry up",
      "product": "Watches"
    },
    {
      'id': '3',
      'image_url': 'assets/PRODUCT/waterbottle.jpeg',
      'title': "Hurry up",
      "product": "Bottles"
    },
  ];

  // fetchdata() {
  //   exclusiveFuture = fetchTopExclusiveDeals1(
  //       townSelectedStore, mobileNumber, apikey, userLatitude, userLogitude);
  // }

  _getCurrentLocation() {
    //fetchdata();
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        userLatitude = '${position.latitude}';
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

  // loadDetails() async {
  //   fetchTopExclusiveDeals1(
  //           townSelectedStore, mobileNumber, apikey, userLatitude, userLogitude)
  //       .then((res) async {
  //     //print('LoadDetails of ${res.fname}');

  //     if (_isDisposed) {
  //       _userController1.add(res);
  //       return res;
  //     }
  //     return res;
  //   });
  // }
}
