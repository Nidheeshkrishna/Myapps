import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:matsapp/Network/Bloc/hotSpotHomeBloc.dart';

import 'package:matsapp/Pages/Providers/Homeprovider.dart';
import 'package:matsapp/Pages/Providers/HomeproviderWithOffers.dart';
import 'package:matsapp/Pages/StorePage/StorePageProduction.dart';
import 'package:matsapp/constants/app_colors.dart';

import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/widgets/HotspotsWidgets/HotspotViewAllWidget.dart';

import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HotspotsHomeWidgets extends StatefulWidget {
  @override
  _HotspotsHomeWidgetsState createState() => _HotspotsHomeWidgetsState();
}

class _HotspotsHomeWidgetsState extends State<HotspotsHomeWidgets> {
  SharedPreferences prefs;
  Future hotSpotsFuture;

  String townSelected;

  String townSelectedStore;

  String mobileNumber;

  HotSpotHomeBloc _hotSpotHomeBloc;
  @override
  void dispose() {
    super.dispose();
  }

  var apikey;
  @override
  void initState() {
    super.initState();
    // _hotSpotHomeBloc = HotSpotHomeBloc();
    // _hotSpotHomeBloc.eventSink.add(HotSpotHomeeAction.fetch);
    //hotSpotsFuture = fetchHotSpot("Thrissur");
    prefcheck();

    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          if (mounted)
            setState(() {
              townSelectedStore = value[0].selectedTown;
              mobileNumber = value[0].mobilenumber;
              apikey = value[0].apitoken;
              // hotSpotsFuture =
              //     fetchHotSpot(townSelectedStore, mobileNumber, apikey);
            }),
        });
  }

  @override
  Widget build(BuildContext context) {
    //prefcheck();
    //hotSpotsFuture = fetchHotSpot("Thrissur");
    final hotspotdata = Provider.of<HomePageDataProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
        child: hotspotdata.post.apiKeyStatus ?? false
            ? hotspotdata.post.hotspot != null
                ? hotspotdata.post.hotspot.length > 0
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8.0, left: 13, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Exclusive Stores",
                                    style: AppTextStyle.homeTitlesfont()),
                                SizedBox(width: 5),
                                TextButton(
                                  // style: ElevatedButton.styleFrom(
                                  //     primary: Colors.white,
                                  //     elevation: 10,
                                  //     onPrimary: Colors.blue,
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(7.0),
                                  //     )),
                                  child: Row(
                                    children: [
                                      Text("View All ",
                                          style:
                                              AppTextStyle.homeViewAllFont()),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 14,
                                        color: AppColors.kSecondaryDarkColor,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HotspotViewAllWidget()),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth,
                            height: screenHeight * .28,
                            child: ListView.builder(
                                shrinkWrap: true,
                                //physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: hotspotdata.post.hotspot.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: [
                                      Column(
                                        children: [
                                          InkWell(
                                              child: Card(
                                                //color: Colors.blueAccent,
                                                elevation: 5,

                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                child: CachedNetworkImage(
                                                  imageUrl: hotspotdata
                                                      .post
                                                      .hotspot[index]
                                                      .coverImageUrl,
                                                  placeholder: (context, url) =>
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
                                                          Icon(Icons.error),
                                                  fit: BoxFit.fill,
                                                  width: screenWidth * .50,
                                                  height: screenHeight * .25,
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          StorePageProduction(
                                                            hotspotdata
                                                                .post
                                                                .hotspot[index]
                                                                .businessId,
                                                            townSelectedStore,
                                                            hotspotdata
                                                                .post
                                                                .hotspot[index]
                                                                .businessName,
                                                          )),
                                                );
                                              }),
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      )
                    : Container()
                : Container()
            : Container());
  }

  prefcheck() async {
    // ignore: invalid_use_of_visible_for_testing_member
    //SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();

    setState(() {
      townSelected = prefs.getString('SELECTED_TOWN');
      // hotSpotsFuture = fetchHotSpot("$townSelectedStore");
    });
    print("&&&&&&&&&&&&&&&$townSelected");
  }

  final List<Map<String, Object>> dummyData = [
    {
      'id': '1',
      'image_url': 'assets/PRODUCT/joyalukas.jpg',
    },
    {
      'id': '2',
      'image_url': 'assets/PRODUCT/joyalukas.jpg',
    },
  ];
}
