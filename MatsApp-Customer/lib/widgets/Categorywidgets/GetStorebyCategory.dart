import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:matsapp/Modeles/GetAllStoresByCategoryModel.dart';
import 'package:matsapp/Modeles/SqlLiteTableDataModel.dart';
import 'package:matsapp/Network/AddTowishListRest.dart';
import 'package:matsapp/Network/RemovefromwishlistRest.dart';
import 'package:matsapp/Network/getStorebyCategoryRest.dart';
import 'package:matsapp/Pages/StorePage/StorePageProduction.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_vectors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:matsapp/widgets/CategoryAdd/CategoryAdd1.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class GetStorebyCategory extends StatefulWidget {
  final int business_id;
  final String Categoryname;
  GetStorebyCategory(this.business_id, this.Categoryname);

  @override
  GetStorebyCategoryState createState() => GetStorebyCategoryState();
}

class GetStorebyCategoryState extends State<GetStorebyCategory> {
  String townSelectedStore;

  String mobileNumber;

  String userLatitude;

  String userLogitude;

  Future<GetAllStoresByCategoryModel> allCategoryFuture;

  LatLng currentPostion;

  bool wishliststatus = false;

  String apiKey;
  TextEditingController keyNameController = TextEditingController();

  Position _currentPosition;
  StreamController<GetAllStoresByCategoryModel> _userController;

  @override
  void initState() {
    super.initState();
    keyNameController.text = null;
    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          setState(() {
            townSelectedStore = value[0].selectedTown;
            mobileNumber = value[0].mobilenumber;
            apiKey = value[0].apitoken;
          }),
          // _getCurrentLocation(),
        });
    fetchdata("");
    //getdata().then((value) => _getCurrentLocation());

    //prefcheck();
    setState(() {
      //_userController = new StreamController();

      //loadDetails(keyNameController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenhight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        title: Text(
          widget.Categoryname,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenhight * .90,
          width: screenwidth,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: screenwidth * .85,
                    height: screenhight / 15,
                    // padding: EdgeInsets.only(bottom: 5, left: .75, right: .75),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.kPrimaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x12000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                          onFieldSubmitted: (_) {
                            fetchdata(keyNameController.text);
                            //loadDetails(keyNameController.text);
                          },
                          textInputAction: TextInputAction.search,
                          textAlign: TextAlign.center,
                          controller: keyNameController,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search here...',
                            hintStyle:
                                TextStyle(fontSize: 14, color: Colors.grey),
                            isDense: true,
                            suffix: IconButton(
                              icon: Icon(
                                Icons.search,
                                size: 20,
                              ),
                              onPressed: () {
                                //fetchdata(keyNameController.text.toString());
                                setState(() {
                                  fetchdata(keyNameController.text);
                                  //loadDetails(keyNameController.text);
                                  // allCategoryFuture = fetchCategory1(
                                  //     townSelectedStore,
                                  //     mobileNumber,
                                  //     widget.business_id,
                                  //     userLatitude,
                                  //     userLogitude,
                                  //     apiKey,
                                  //     keyNameController.text.toString());
                                });

                                // if (keyNameController.text.toString().isNotEmpty) {
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => searchResultPage(
                                //             userLatitude,
                                //             userLogitude,
                                //             keyNameController.text.toString())),
                                //   );
                                // } else {
                                //   GeneralTools().createSnackBarCommon(
                                //       "Enter a Keyword", context);
                                // }
                              },
                            ),
                          )),
                    ),
                  ),
                ),
                FutureBuilder<GetAllStoresByCategoryModel>(
                    future: allCategoryFuture,
                    builder: (context, snapshot) {
                      //if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        if (snapshot.data.result.length > 0) {
                          return Container(
                            child: Column(
                              children: [
                                Container(
                                    child: CategoryAdd1(widget.business_id)),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.result.length,
                                  physics: ScrollPhysics(),
                                  primary: true,
                                  //physics: const NeverScrollableScrollPhysics(),

                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    //int id = widget.topStoresModel.list1[index].wishListId;
                                    if (snapshot
                                            .data.result[index].wishListId ==
                                        0) {
                                      wishliststatus = false;
                                    } else if (snapshot
                                            .data.result[index].wishListId >
                                        0) {
                                      wishliststatus = true;
                                    }
                                    return InkWell(
                                      child: Card(
                                          elevation: 10,
                                          //clipBehavior: Clip.antiAliasWithSaveLayer,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: screenwidth,
                                                height: screenhight * .25,
                                                child: Row(
                                                  children: <Widget>[
                                                    Row(
                                                      children: [
                                                        Card(
                                                          elevation: 2,
                                                          clipBehavior:
                                                              Clip.hardEdge,
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: snapshot
                                                                .data
                                                                .result[index]
                                                                .coverImageUrl,
                                                            placeholder: (context,
                                                                    url) =>
                                                                Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                            fit: BoxFit.fill,
                                                            width: screenwidth *
                                                                .30,
                                                            height:
                                                                screenhight *
                                                                    .18,
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      screenwidth *
                                                                          .08)),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0,
                                                                  left: 8),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width:
                                                                    screenwidth *
                                                                        .50,
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                        snapshot
                                                                            .data
                                                                            .result[
                                                                                index]
                                                                            .businessName,
                                                                        softWrap:
                                                                            true,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontSize: 14)),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                // width: 200,
                                                                //height: 40,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 10.0,
                                                                      left: 0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Text(
                                                                        "${snapshot.data.result[index].rating}",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      SmoothStarRating(
                                                                          allowHalfRating:
                                                                              false,
                                                                          onRated:
                                                                              (v) {},
                                                                          starCount:
                                                                              5,
                                                                          rating: snapshot.data.result[index].rating
                                                                              .toDouble(),
                                                                          size:
                                                                              18.0,
                                                                          isReadOnly:
                                                                              true,
                                                                          filledIconData: Icons
                                                                              .star_rate,
                                                                          color: Colors
                                                                              .amberAccent,
                                                                          borderColor: Colors
                                                                              .blueGrey,
                                                                          spacing:
                                                                              0.0),
                                                                      // Text(
                                                                      //     "(12 Reviews)",
                                                                      //     style:
                                                                      //         TextStyle(fontSize: 11))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(snapshot
                                                                        .data
                                                                        .result[
                                                                            index]
                                                                        .town),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              1,
                                                                          left:
                                                                              15),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.location_on,
                                                                            size:
                                                                                15,
                                                                            color:
                                                                                Colors.orange[300],
                                                                          ),
                                                                          Text(
                                                                              "${snapshot.data.result[index].distanceinKm}\rKms",
                                                                              style: TextStyle(fontWeight: FontWeight.normal)),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              snapshot.data.result[index].provideOffers ==
                                                                          "0" ||
                                                                      snapshot
                                                                              .data
                                                                              .result[index]
                                                                              .provideOffers ==
                                                                          null
                                                                  ? Container()
                                                                  : Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        children: [
                                                                          Align(
                                                                              alignment: Alignment.bottomCenter,
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width * .50,
                                                                                height: 35,
                                                                                // MediaQuery.of(context).size.height *
                                                                                //.10,
                                                                                //height: 30,
                                                                                child: Card(
                                                                                    color: Colors.orange[400],
                                                                                    child: Center(
                                                                                        child: Text('${snapshot.data.result[index].provideOffers}%',
                                                                                            style: TextStyle(
                                                                                              color: Colors.white,
                                                                                              fontWeight: FontWeight.bold,
                                                                                            )))),
                                                                              ))
                                                                        ],
                                                                      ),
                                                                    )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  icon: SvgPicture.asset(
                                                    wishliststatus
                                                        ? AppVectors.ic_heart1
                                                        : AppVectors.ic_heart,
                                                    height: SizeConfig
                                                            .heightMultiplier *
                                                        3,
                                                    // color: wishliststatus
                                                    //     ? Colors.pink
                                                    //     : Colors.blueGrey,
                                                  ),
                                                  onPressed: () {
                                                    snapshot.data.result[index]
                                                                .wishListId ==
                                                            0
                                                        ? fetchAddTowishList(
                                                            "product",
                                                            snapshot
                                                                .data
                                                                .result[index]
                                                                .pkBusinessId,
                                                          ).then(
                                                            (value) => {
                                                              if (value
                                                                      .result ==
                                                                  1)
                                                                {
                                                                  //fetchTopStore(town, mobile, latitude, longitude)
                                                                  setState(() {
                                                                    wishliststatus =
                                                                        true;
                                                                  }),
                                                                  fetchdata(
                                                                      keyNameController
                                                                          .text
                                                                          .toString()),
                                                                  GeneralTools()
                                                                      .createSnackBarSuccess(
                                                                          "Added to your Wishlist",
                                                                          context)
                                                                }
                                                            },
                                                          )
                                                        : fetchRemoveFromwishList(
                                                                snapshot
                                                                    .data
                                                                    .result[
                                                                        index]
                                                                    .wishListId)
                                                            .then((value) => {
                                                                  if (value
                                                                          .result ==
                                                                      1)
                                                                    {
                                                                      setState(
                                                                          () {
                                                                        wishliststatus =
                                                                            false;
                                                                      }),
                                                                      // _toggleFavorite(),
                                                                      fetchdata(keyNameController
                                                                          .text
                                                                          .toString()),
                                                                      GeneralTools().createSnackBarFailed(
                                                                          "Removed from Wishlist",
                                                                          context)
                                                                    }
                                                                });
                                                  },
                                                ),
                                              ),
                                            ],
                                          )),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StorePageProduction(
                                                    snapshot.data.result[index]
                                                        .pkBusinessId,
                                                    townSelectedStore,
                                                    snapshot.data.result[index]
                                                        .businessName,
                                                  )),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            width: screenwidth,
                            height: screenhight * .50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                    child: SvgPicture.asset(
                                        "assets/vectors/empty_vector.svg")),
                                Text(
                                  "OOPs..!",
                                  style:
                                      TextStyle(color: AppColors.kAccentColor),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("No Stores To show",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          );
                        }
                      } else if (snapshot.hasError) {
                        return Container(
                          width: screenwidth,
                          height: screenhight * .50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: SvgPicture.asset(
                                      "assets/vectors/empty_vector.svg")),
                              Text(
                                "OOPs..!",
                                style: TextStyle(color: AppColors.kAccentColor),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text("No Stores To show",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Container();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  fetchdata([String keyword]) {
    allCategoryFuture = fetchCategory1(widget.business_id, keyword);
  }

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);

      userLatitude = '${currentPostion.latitude}';

      userLogitude = '${currentPostion.longitude}';
    });
    //fetchdata();
  }

  _getCurrentLocation() async {
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
      //fetchdata();
      // print(' ${position.}');
    }).catchError((e) {
      print(e);
    });
  }

  Future getdata() async {
    DatabaseHelper dbHelper = new DatabaseHelper();
    List<UserInfo> user = await dbHelper.getAll();

    setState(() {
      townSelectedStore = user.first.location;
      mobileNumber = user.first.mobilenumber;
      apiKey = user.first.apitoken;
    });
  }

  // loadDetails([String keyword]) async {
  //   fetchCategory1(townSelectedStore, mobileNumber, widget.business_id,
  //           userLatitude, userLogitude, apiKey, keyword)
  //       .then((res) async {
  //     //print('LoadDetails of ${res.fname}');
  //     _userController.sink.add(res);
  //     // if (_isDisposed) {

  //     //   return res;
  //     // }
  //     return res;
  //   });
  // }
}
