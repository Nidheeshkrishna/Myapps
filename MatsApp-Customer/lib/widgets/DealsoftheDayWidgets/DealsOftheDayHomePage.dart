import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:matsapp/Modeles/DealsOftheDayModel.dart';
import 'package:matsapp/Modeles/SqlLiteTableDataModel.dart';
import 'package:matsapp/Modeles/homePageModels/HomePageModel.dart';
import 'package:matsapp/Network/Bloc/dealsOfTheDayHomeBloc.dart';

import 'package:matsapp/Network/DealsofTheDayRest.dart';
import 'package:matsapp/Pages/DealsofDay/DealsofDayProduct/DealsOTheDayProductPage.dart';
import 'package:matsapp/Pages/DealsofDay/ProductViewAllDealsOfDay.dart';
import 'package:matsapp/Pages/Providers/Homeprovider.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:provider/provider.dart';

class ExclusiveDealsWidget2 extends StatefulWidget {
  @override
  _ExclusiveDealsWidget2State createState() => _ExclusiveDealsWidget2State();
}

class _ExclusiveDealsWidget2State extends State<ExclusiveDealsWidget2> {
  String townSelectedStore;

  Future discountForyouFuture;

  String mobileNumber;
  String apikey;

  Position _currentPosition;

  String userLatitude;

  String userLogitude;

  @override
  void initState() {
    super.initState();

    getdata();
  }

  @override
  Widget build(BuildContext context) {
    final dealsofTheDaydata = Provider.of<PostDataProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        dealsofTheDaydata.post.apiKeyStatus ?? false
            ? dealsofTheDaydata.post.dealsoftheDay != null
                ? dealsofTheDaydata.loading
                    ? Container()
                    : dealsofTheDaydata.post.dealsoftheDay.length > 0
                        ? Container(
                            // width: MediaQuery.of(context).size.width,
                            //height: MediaQuery.of(context).size.height * .90,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/images/theme1.png"),
                              fit: BoxFit.cover,
                            )),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 8.0,
                                      left: 13.0,
                                      right: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Deals Of The Day",
                                        style: AppTextStyle.homeWhitefont(),
                                      ),
                                      TextButton(
                                        // style: ElevatedButton.styleFrom(
                                        //     primary: Colors.white,
                                        //     elevation: 10,
                                        //     onPrimary: Colors.blue,
                                        //     shape: RoundedRectangleBorder(
                                        //         borderRadius:
                                        //             BorderRadius.circular(7.0),
                                        //         side: BorderSide(
                                        //           color: Theme.of(context).accentColor,
                                        //         ))),
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
                                                    ProductViewAllDealsOfDay(
                                                        townSelectedStore)),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  //width: MediaQuery.of(context).size.width,
                                  //height: MediaQuery.of(context).size.height * .60,
                                  child: GridView.builder(
                                    padding: EdgeInsets.only(
                                      left: SizeConfig.widthMultiplier * 2.5,
                                      right: SizeConfig.widthMultiplier * 2,
                                    ),
                                    shrinkWrap: true,
                                    itemCount: dealsofTheDaydata
                                        .post.dealsoftheDay.length,
                                    physics: ScrollPhysics(),
                                    //physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 1.0,
                                            mainAxisSpacing: 6.0,
                                            childAspectRatio: 1 / 1.3),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Stack(children: <Widget>[
                                        InkWell(
                                          child: Card(
                                              elevation: 5,
                                              //clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .widthMultiplier *
                                                        2.5,
                                                    left: SizeConfig
                                                            .widthMultiplier *
                                                        2.5,
                                                    right: SizeConfig
                                                            .widthMultiplier *
                                                        2.5),
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              dealsofTheDaydata
                                                                  .post
                                                                  .dealsoftheDay[
                                                                      index]
                                                                  .productImage,
                                                          placeholder: (context,
                                                                  url) =>
                                                              Center(
                                                                  child:
                                                                      Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20.0),
                                                            child:
                                                                CircularProgressIndicator(),
                                                          )),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(
                                                            Icons.image,
                                                            size: 50,
                                                          ),
                                                          fit: BoxFit.contain,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .40,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .18,
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              dealsofTheDaydata
                                                                  .post
                                                                  .dealsoftheDay[
                                                                      index]
                                                                  .productName,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: AppTextStyle
                                                                  .productNameFont(),
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  child: dealsofTheDaydata
                                                                              .post
                                                                              .dealsoftheDay[index]
                                                                              .matsappPrice ==
                                                                          "0"
                                                                      ? Container()
                                                                      : Text(
                                                                          "Matsapp Price:\r${dealsofTheDaydata.post.dealsoftheDay[index].matsappPrice}/-",
                                                                          style:
                                                                              AppTextStyle.productPriceFont(),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          softWrap:
                                                                              true,
                                                                        ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              )),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DealsOTheDayProductPage(
                                                          dealsofTheDaydata
                                                              .post
                                                              .dealsoftheDay[
                                                                  index]
                                                              .productId,
                                                          townSelectedStore,
                                                          dealsofTheDaydata
                                                              .post
                                                              .dealsoftheDay[
                                                                  index]
                                                              .businessName,
                                                          dealsofTheDaydata
                                                              .post
                                                              .dealsoftheDay[
                                                                  index]
                                                              .productId)),
                                            );
                                          },
                                        ),
                                        dealsofTheDaydata
                                                    .post
                                                    .dealsoftheDay[index]
                                                    .matsappDiscount !=
                                                null
                                            ? Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Stack(
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/roundStar.png",
                                                      ),
                                                      Text(
                                                        "\n\r\r\r\rSave  \n\r\r\r\r${dealsofTheDaydata.post.dealsoftheDay[index].matsappDiscount}%",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.blueGrey,
                                                            fontSize: 11),
                                                      )
                                                    ],
                                                  ),
                                                ))
                                            : Container()
                                      ]);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container()
                : Container()
            : Container(),
      ],
    );
  }

  final List<Map<String, Object>> dummyData = [
    {
      'id': '1',
      'image_url': 'assets/images/himalaya.jpg',
      'title': "Hurry up",
      "product": "Himalaya"
    },
    {
      'id': '2',
      'image_url': 'assets/images/jblsp.png',
      'title': "Hurry up",
      "product": "JBL Box Media"
    },
    {
      'id': '3',
      'image_url': 'assets/images/sonycybershot.jpeg',
      'title': "Hurry up",
      "product": "Sony CyberShot"
    },
    {
      'id': '3',
      'image_url': 'assets/PRODUCT/assembled.jpeg',
      'title': "Hurry up",
      "product": "Assembled 1ST Core 2"
    },
  ];
  Future getdata() async {
    DatabaseHelper dbHelper = new DatabaseHelper();
    List<UserInfo> user = await dbHelper.getAll();
    if (mounted) {
      setState(() {
        townSelectedStore = user.first.selectedTown;
        mobileNumber = user.first.mobilenumber;
        apikey = user.first.apitoken;
      });
    }
  }

  fetchdata() {
    discountForyouFuture = fetchDelsOftheDay(
        townSelectedStore, mobileNumber, apikey, userLatitude, userLogitude);
  }

  _getCurrentLocation() {
    //fetchdata();
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
          userLatitude = ' ${position.latitude}';
          userLogitude = '${position.longitude}';
        });
      }

      print('${position.latitude}');
      print('${position.longitude}');
      // print(' ${position.}');
    }).catchError((e) {
      print(e);
    });
    fetchdata();
  }

  // loadDetails() async {
  //   fetchDelsOftheDay(
  //           townSelectedStore, mobileNumber, apikey, userLatitude, userLogitude)
  //       .then((res) async {
  //     //print('LoadDetails of ${res.fname}');
  //     _dealsofthedaystream.add(res);
  //     // if (_isDisposed) {

  //     //   return res;
  //     // }
  //     return res;
  //   });
  // }
}
