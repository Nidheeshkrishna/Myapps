import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:matsapp/Modeles/DiscountForyouModel.dart';
import 'package:matsapp/Modeles/homePageModels/HomePageModel.dart';
import 'package:matsapp/Network/Bloc/DiscounsHomeBloc.dart';

import 'package:matsapp/Network/DiscountForYouRest.dart';
import 'package:matsapp/Pages/DiscountsForYou/DiscountsForYouProduct/DiscoutForYouProductPage.dart';
import 'package:matsapp/Pages/DiscountsForYou/DiscoutForYouProductViewAll.dart';
import 'package:matsapp/Pages/Providers/Homeprovider.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:provider/provider.dart';

class HomePageDiscountswidgets extends StatefulWidget {
  @override
  _HomePageDiscountswidgetsState createState() =>
      _HomePageDiscountswidgetsState();
}

class _HomePageDiscountswidgetsState extends State<HomePageDiscountswidgets> {
  Future discountForyouFuture;

  String townSelectedStore;

  String mobileNumber;

  String apiKey;

  Position _currentPosition;

  String userLatitude;

  String userLogitude;

 

  //var apikey;
  @override
  void initState() {
    super.initState();

    DatabaseHelper dbHelper = new DatabaseHelper();
    dbHelper.getAll().then((value) => {
          if (mounted)
            {
              setState(() {
                townSelectedStore = value[0].selectedTown;
                mobileNumber = value[0].mobilenumber;
                apiKey = value[0].apitoken;
              }),
            },
          //_getCurrentLocation(),
        });
    // _discountforyouBloc = DiscountsForYouHomeBloc();
    // _discountforyouBloc.eventSink.add(DiscountsHomeAction.fetch);
  }

  @override
  Widget build(BuildContext context) {
    final discountsForYoudata = Provider.of<PostDataProvider>(context);
    return discountsForYoudata.post.apiKeyStatus != null ||
                discountsForYoudata.post.apiKeyStatus ??
            false
        ? discountsForYoudata.post != null
            ? discountsForYoudata.loading
                ? Container()
                : discountsForYoudata.post.discountForyou.length > 0
                    ? Container(
                        child: Card(
                          elevation: 2,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Discounts for you",
                                        style: AppTextStyle.homeTitlesfont()),
                                    TextButton(
                                      // style: ElevatedButton.styleFrom(
                                      //   primary: Colors.white,
                                      //   shadowColor: Theme.of(context).accentColor,
                                      //   elevation: 5,
                                      // ),
                                      child: Row(children: [
                                        Text("View All ",
                                            style:
                                                AppTextStyle.homeViewAllFont()),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14,
                                          color: AppColors.kSecondaryDarkColor,
                                        ),
                                      ]),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DiscoutForYouProductViewAll(
                                                      townSelectedStore)),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: GridView.builder(
                                  padding: EdgeInsets.only(
                                    left: SizeConfig.widthMultiplier * 2.5,
                                    right: SizeConfig.widthMultiplier * 2,
                                  ),
                                  itemCount: discountsForYoudata
                                      .post.discountForyou.length,
                                  shrinkWrap: true,
                                  //physics: const NeverScrollableScrollPhysics(),
                                  physics: ScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 4.0,
                                    mainAxisSpacing: 4.0,
                                  ),

                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return AspectRatio(
                                      aspectRatio: 2 / 2,
                                      child: InkWell(
                                        child: Stack(children: <Widget>[
                                          Container(
                                              // decoration: BoxDecoration(
                                              //     border:
                                              //         Border.all(color: Colors.grey)),
                                              child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Column(
                                              children: <Widget>[
                                                Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        discountsForYoudata
                                                            .post
                                                            .discountForyou[
                                                                index]
                                                            .productImage,
                                                    placeholder:
                                                        (context, url) =>
                                                            Center(
                                                                child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.image,
                                                                size: 50),
                                                    fit: BoxFit.contain,
                                                    width: 150,
                                                    height: 110,
                                                  ),
                                                ),
                                                Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          discountsForYoudata
                                                              .post
                                                              .discountForyou[
                                                                  index]
                                                              .productName,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                          "Matsapp Price:${discountsForYoudata.post.discountForyou[index].matsappPrice}/-",
                                                          style: AppTextStyle
                                                              .productPriceFont(),
                                                        ),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          )),
                                        ]),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DiscoutForYouProductPage(
                                                        discountsForYoudata
                                                            .post
                                                            .discountForyou[
                                                                index]
                                                            .productId,
                                                        townSelectedStore,
                                                        discountsForYoudata
                                                            .post
                                                            .discountForyou[
                                                                index]
                                                            .businessName,
                                                        discountsForYoudata
                                                            .post
                                                            .discountForyou[
                                                                index]
                                                            .businessId)),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container()
            : Container()
        : Container();
  }

  final List<Map<String, Object>> dummyData = [
    {
      'id': '1',
      'image_url': 'assets/PRODUCT/onePlusTv.jpeg',
      'title': "Hurry up",
      "product": "One Plus TV"
    },
    {
      'id': '2',
      'image_url': 'assets/PRODUCT/waterpurifiyer.jpeg',
      'title': "Hurry up",
      "product": "Water Purifier"
    },
    {
      'id': '3',
      'image_url': 'assets/PRODUCT/MicrowaveOven1.jpeg',
      'title': "Hurry up",
      "product": "Microwave Oven"
    },
    {
      'id': '3',
      'image_url': 'assets/PRODUCT/BluetoothSpeaker.jpeg',
      'title': "Hurry up",
      "product": "Bluetooth Speaker"
    },
  ];
  fetchdata() {
    discountForyouFuture = fetchDiscountforyou(
        townSelectedStore, mobileNumber, apiKey, userLatitude, userLogitude);
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
