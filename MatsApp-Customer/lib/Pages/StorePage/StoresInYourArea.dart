import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:matsapp/Network/AddTowishListRest.dart';
import 'package:matsapp/Network/RemovefromwishlistRest.dart';
import 'package:matsapp/Network/Top9storeSearch/top9storeViewAllSearch.dart';
import 'package:matsapp/Network/topstoresRest.dart';
import 'package:matsapp/Pages/StorePage/StorePageProduction.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/constants/app_vectors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:matsapp/widgets/Top9Stores/Top9storesAdd1.dart';
import 'package:matsapp/widgets/Top9Stores/Top9storesAdd2.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../Modeles/TopStoresModel.dart';
import 'StoreMallPage.dart';

class StorsInyourArea extends StatefulWidget {
  // final TopStoresModel topStoresModel;
  // StorsInyourArea(this.topStoresModel);
  @override
  _ProductINAreaPageState createState() => _ProductINAreaPageState();
}

class _ProductINAreaPageState extends State<StorsInyourArea> {
  //PageController _pageController;
  //int _currentIndex = 0;
  TextEditingController keyNameController = TextEditingController();
  String appbarTitleString;
  String mobileNumber;
  Text appBarTitleText;
  int wishlistid;
  bool wishliststatus = false;
  bool wishliststatus2;
  int selectedIndex = 0;

  String townSelectedStore;

  Future _topStoreFuture;

  Position _currentPosition;

  String userLatitude;

  String userLogitude;

  LatLng currentPostion;

  String apikey;
  StreamController<TopStoresModel> _userController;
  StreamController<TopStoresModel> _userController2;

  TopstoreBloc topstoreBloc;
  @override
  void initState() {
    // _getCurrentLocation();

    // keyNameController.addListener(() {
    //   loadDetails(keyNameController.text);
    //   loadDetails2(keyNameController.text);
    // });
    //keyNameController.text = "";

    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          setState(() {
            townSelectedStore = value[0].selectedTown;
            mobileNumber = value[0].mobilenumber;
            apikey = value[0].apitoken;
            keyNameController.text = "";
          }),
          fetchdata(),
          // prefcheck(
          //     value[0].mobilenumber, value[0].location, value[0].apitoken),
          // // GeneralTools().prefsetLoginInfo(
          // //     ),
        });
    //fetchdata();
    // _userController2 = new StreamController();
    // loadDetails2(keyNameController.text);
    // _userController = new StreamController();
    // loadDetails(keyNameController.text);
    // topstoreBloc = TopstoreBloc();
    // topstoreBloc.eventSink.add(TopStoreAction.fetch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appbar = new AppBar(
      title: Text(
        "Store in your Location",
        style: TextStyle(fontSize: 17, color: Colors.black),
      ),
      backgroundColor: Colors.white,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => MainHomePage()));
            },
            //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      // actions: [
      //   IconButton(
      //     icon: Icon(
      //       Icons.filter_list,
      //       color: Colors.black,
      //     ),
      //     onPressed: () {
      //       //Scaffold.of(context).openDrawer();
      //     },
      //   )
      // ],
    );

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appbar,
      body: Container(
          width: screenWidth,
          height: screenHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Container(
                    width: screenWidth,
                    //height: 60,

                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        shadowColor: AppColors.kSecondaryDarkColor,
                        borderOnForeground: true,
                        elevation: 5,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Align(
                          //alignment: Alignment.topCenter,
                          child: TextFormField(
                            onChanged: (value) {
                              fetchdata();
                              _topStoreFuture = fetchTopStoreSearch(value);
                            },
                            textInputAction: TextInputAction.search,
                            textAlign: TextAlign.center,
                            controller: keyNameController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search here...',
                                hintStyle: TextStyle(color: Colors.grey),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      fetchdata();
                                      // loadDetails(keyNameController.text);
                                      // loadDetails2(keyNameController.text);
                                    });
                                  },
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  //height: screenHeight * .90,
                  //width: screenWidth,
                  child: FutureBuilder<TopStoresModel>(
                      future: _topStoreFuture,
                      builder: (context, snapshot) {
                        //if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          if (snapshot.data.list1.length > 0) {
                            return Column(
                              children: [
                                Container(
                                  child: Top9storesAdd1(),
                                ),
                                Column(
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.list1.length,
                                      physics: ScrollPhysics(),
                                      primary: true,
                                      //physics: const NeverScrollableScrollPhysics(),

                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        //int id = widget.topStoresModel.list1[index].wishListId;
                                        if (snapshot
                                                .data.list1[index].wishListId ==
                                            0) {
                                          wishliststatus = false;
                                        } else if (snapshot
                                                .data.list1[index].wishListId >
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
                                                    padding: EdgeInsets.only(
                                                        left: 5),
                                                    width: screenWidth,
                                                    height: screenHeight * .20,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Row(
                                                          children: [
                                                            Card(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        screenWidth *
                                                                            .08),
                                                              ),
                                                              elevation: 3,
                                                              clipBehavior:
                                                                  Clip.hardEdge,
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: snapshot
                                                                    .data
                                                                    .list1[
                                                                        index]
                                                                    .coverImageUrl,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                                fit:
                                                                    BoxFit.fill,
                                                                width:
                                                                    screenWidth *
                                                                        .3,
                                                                height:
                                                                    screenWidth *
                                                                        .3,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: 10.0,
                                                                  left:
                                                                      screenWidth *
                                                                          .01),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Container(
                                                                    width:
                                                                        screenWidth *
                                                                            .52,
                                                                    // height:
                                                                    //     screenHeight /
                                                                    //         25,
                                                                    child: Wrap(
                                                                      children: [
                                                                        Text(
                                                                            snapshot.data.list1[index].businessName,
                                                                            softWrap: true,
                                                                            maxLines: 2,
                                                                            // textAlign:
                                                                            //     TextAlign.center,
                                                                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14)),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    // width: 200,
                                                                    //height: 40,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              10.0,
                                                                          left:
                                                                              0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Text(
                                                                            "${snapshot.data.list1[index].rating}",
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.normal),
                                                                          ),
                                                                          SmoothStarRating(
                                                                              allowHalfRating: false,
                                                                              onRated: (v) {},
                                                                              starCount: 5,
                                                                              rating: snapshot.data.list1[index].rating.toDouble(),
                                                                              size: 18.0,
                                                                              isReadOnly: true,
                                                                              filledIconData: Icons.star_rate,
                                                                              color: Colors.amberAccent,
                                                                              borderColor: Colors.blueGrey,
                                                                              spacing: 0.0),
                                                                          // Text(
                                                                          //     "(12 Reviews)",
                                                                          //     style:
                                                                          //         TextStyle(fontSize: 11))
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            5.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          "${snapshot.data.list1[index].town}" ??
                                                                              "",
                                                                          style:
                                                                              AppTextStyle.commonFont(),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                              top: 1,
                                                                              left: screenWidth * .08),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.location_on,
                                                                                size: 15,
                                                                                color: Colors.orange[300],
                                                                              ),
                                                                              Text(
                                                                                snapshot.data.list1[index].distanceinKm + "Kms",
                                                                                style: AppTextStyle.commonFont(),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  snapshot.data.list1[index]
                                                                              .provideOffers ==
                                                                          "0"
                                                                      ? Container()
                                                                      : Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(top: 3.0),
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
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
                                                                                            child: Text(
                                                                                          '${snapshot.data.list1[index].provideOffers}%',
                                                                                          style: TextStyle(color: Colors.white),
                                                                                        ))),
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
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: IconButton(
                                                      icon: SvgPicture.asset(
                                                        wishliststatus
                                                            ? 'assets/vectors/ic_heart1.svg'
                                                            : 'assets/vectors/ic_heart.svg',
                                                        height: SizeConfig
                                                                .heightMultiplier *
                                                            3,

                                                        // color: wishliststatus
                                                        //     ? Colors.pink
                                                        //     : Colors.blueGrey,
                                                      ),
                                                      onPressed: () {
                                                        snapshot
                                                                    .data
                                                                    .list1[
                                                                        index]
                                                                    .wishListId ==
                                                                0
                                                            ? fetchAddTowishList(
                                                                    "Store",
                                                                    snapshot
                                                                        .data
                                                                        .list1[
                                                                            index]
                                                                        .pkBusinessId,
                                                                   )
                                                                .then(
                                                                (value) => {
                                                                  if (value
                                                                          .result ==
                                                                      1)
                                                                    {
                                                                      fetchdata(),

                                                                      setState(
                                                                          () {
                                                                        wishliststatus =
                                                                            true;
                                                                      }),
                                                                      // _toggleFavorite(),
                                                                      GeneralTools().createSnackBarSuccess(
                                                                          "Added to your Wishlist",
                                                                          context)
                                                                    }
                                                                },
                                                              )
                                                            : fetchRemoveFromwishList(
                                                                  
                                                                    snapshot
                                                                        .data
                                                                        .list1[
                                                                            index]
                                                                        .wishListId)
                                                                .then(
                                                                    (value) => {
                                                                          if (value.result ==
                                                                              1)
                                                                            {
                                                                              fetchdata(),
                                                                              // loadDetails(keyNameController.text),
                                                                              // loadDetails2(keyNameController.text),
                                                                              setState(() {
                                                                                wishliststatus = false;
                                                                              }),
                                                                              // _toggleFavorite(),
                                                                              GeneralTools().createSnackBarFailed("Removed from Wishlist", context)
                                                                            }
                                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          onTap: () {
                                            if (snapshot
                                                .data.list1[index].isMall) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MallPage(
                                                          snapshot
                                                              .data
                                                              .list1[index]
                                                              .pkBusinessId,
                                                          snapshot
                                                              .data
                                                              .list1[index]
                                                              .businessName,
                                                         
                                                        )),
                                              );
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        StorePageProduction(
                                                          snapshot
                                                              .data
                                                              .list1[index]
                                                              .pkBusinessId,
                                                          townSelectedStore,
                                                          snapshot
                                                              .data
                                                              .list1[index]
                                                              .businessName,
                                                        )),
                                              );
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return Container(
                              width: screenWidth,
                              height: screenHeight * .50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                      child: SvgPicture.asset(
                                          "assets/vectors/empty_vector.svg")),
                                  Text(
                                    "OOPs..!",
                                    style: TextStyle(
                                        color: AppColors.kAccentColor),
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
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Container(
                            width: screenWidth,
                            height: screenHeight * .50,
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
                        } else {
                          return Container();
                        }
                      }),
                ),
                Container(
                  // height: screenHeight,
                  // width: screenWidth,
                  child: FutureBuilder<TopStoresModel>(
                      future: _topStoreFuture,
                      builder: (context, snapshot) {
                        //if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  child: Top9storesAdd2(),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.list2.length,
                                      physics: ScrollPhysics(),
                                      primary: true,
                                      //physics: const NeverScrollableScrollPhysics(),

                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        //int id = widget.topStoresModel.list1[index].wishListId;
                                        if (snapshot
                                                .data.list2[index].wishListId ==
                                            0) {
                                          wishliststatus2 = false;
                                        } else if (snapshot
                                                .data.list2[index].wishListId >
                                            0) {
                                          wishliststatus2 = true;
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
                                                    padding: EdgeInsets.only(
                                                        left: 2),
                                                    width: screenWidth,
                                                    height: screenHeight * .25,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Row(
                                                          children: [
                                                            Card(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        screenWidth *
                                                                            .08),
                                                              ),
                                                              elevation: 3,
                                                              clipBehavior:
                                                                  Clip.hardEdge,
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: snapshot
                                                                    .data
                                                                    .list2[
                                                                        index]
                                                                    .coverImageUrl,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                                fit:
                                                                    BoxFit.fill,
                                                                width:
                                                                    screenWidth *
                                                                        .3,
                                                                height:
                                                                    screenWidth *
                                                                        .3,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: 8.0,
                                                                  left:
                                                                      screenWidth *
                                                                          .02),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Container(
                                                                    width:
                                                                        screenWidth *
                                                                            .52,
                                                                    // height:
                                                                    //     screenHeight /
                                                                    //         25,
                                                                    child: Wrap(
                                                                      children: [
                                                                        Text(
                                                                            snapshot.data.list2[index].businessName,
                                                                            softWrap: true,
                                                                            // textAlign:
                                                                            //     TextAlign.center,
                                                                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14)),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    // width: 200,
                                                                    //height: 40,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              2.0,
                                                                          left:
                                                                              0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Text(
                                                                            "${snapshot.data.list2[index].rating}",
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.normal),
                                                                          ),
                                                                          SmoothStarRating(
                                                                              allowHalfRating: false,
                                                                              onRated: (v) {},
                                                                              starCount: 5,
                                                                              rating: snapshot.data.list2[index].rating.toDouble(),
                                                                              size: 18.0,
                                                                              isReadOnly: true,
                                                                              filledIconData: Icons.star_rate,
                                                                              color: Colors.amberAccent,
                                                                              borderColor: Colors.blueGrey,
                                                                              spacing: 0.0),
                                                                          // Text(
                                                                          //     "(12 Reviews)",
                                                                          //     style: TextStyle(
                                                                          //         fontSize:
                                                                          //             11))
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            2.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          "${snapshot.data.list2[index].town}" ??
                                                                              "",
                                                                          style:
                                                                              AppTextStyle.commonFont(),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                              top: 1,
                                                                              left: screenWidth * .08),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Icon(
                                                                                Icons.location_on,
                                                                                size: 15,
                                                                                color: Colors.orange[300],
                                                                              ),
                                                                              Text(
                                                                                "${snapshot.data.list2[index].distanceinKm}\rKms",
                                                                                style: AppTextStyle.commonFont(),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  snapshot.data.list2[index]
                                                                              .provideOffers ==
                                                                          "0"
                                                                      ? Container()
                                                                      : Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(top: 2.0),
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
                                                                                            child: Text(
                                                                                          '${snapshot.data.list2[index].provideOffers}%',
                                                                                          style: TextStyle(color: Colors.white),
                                                                                        ))),
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
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: IconButton(
                                                      icon: SvgPicture.asset(
                                                        wishliststatus2
                                                            ? AppVectors
                                                                .ic_heart1
                                                            : AppVectors
                                                                .ic_heart,
                                                        height: SizeConfig
                                                                .heightMultiplier *
                                                            3,
                                                        // color: wishliststatus2
                                                        //     ? Colors.pink
                                                        //     : Colors.blueGrey,
                                                      ),
                                                      onPressed: () {
                                                        snapshot
                                                                    .data
                                                                    .list2[
                                                                        index]
                                                                    .wishListId ==
                                                                0
                                                            ? fetchAddTowishList(
                                                                    "Store",
                                                                    snapshot
                                                                        .data
                                                                        .list2[
                                                                            index]
                                                                        .pkBusinessId,
                                                                   )
                                                                .then(
                                                                (value) => {
                                                                  if (value
                                                                          .result ==
                                                                      1)
                                                                    {
                                                                      fetchdata(),
                                                                      //fetchTopStore(town, mobile, latitude, longitude)
                                                                      setState(
                                                                          () {
                                                                        wishliststatus2 =
                                                                            true;
                                                                      }),
                                                                      GeneralTools().createSnackBarSuccess(
                                                                          "Added to your Wishlist",
                                                                          context)
                                                                    }
                                                                },
                                                              )
                                                            : fetchRemoveFromwishList(
                                                                   
                                                                    snapshot
                                                                        .data
                                                                        .list2[
                                                                            index]
                                                                        .wishListId)
                                                                .then(
                                                                    (value) => {
                                                                          if (value.result ==
                                                                              1)
                                                                            {
                                                                              fetchdata(),
                                                                              setState(() {
                                                                                wishliststatus2 = false;
                                                                              }),
                                                                              GeneralTools().createSnackBarFailed("Removed from Wishlist", context)
                                                                            }
                                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          onTap: () {
                                            if (snapshot
                                                .data.list2[index].isMall) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MallPage(
                                                          snapshot
                                                              .data
                                                              .list2[index]
                                                              .pkBusinessId,
                                                          snapshot
                                                              .data
                                                              .list2[index]
                                                              .businessName,
                                                         
                                                        )),
                                              );
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        StorePageProduction(
                                                          snapshot
                                                              .data
                                                              .list2[index]
                                                              .pkBusinessId,
                                                          townSelectedStore,
                                                          snapshot
                                                              .data
                                                              .list2[index]
                                                              .businessName,
                                                        )),
                                              );
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                ),
              ],
            ),
          )),
    );
  }

  final List<Map<String, Object>> dummyData = [
    {
      'id': '1',
      'Name': 'JBL Box Media',
      'image_url': 'assets/images/jblsp.png',
    },
    {
      'id': '2',
      'Name': 'Watch',
      'image_url': 'assets/images/applewatch.jpg',
    },
    {
      'id': '3',
      'Name': 'Combo Offer',
      'image_url': 'assets/images/bluetoothspeaker.png'
    },
    {
      'id': '4',
      'Name': 'Sony Cybershot',
      'image_url': 'assets/images/sonycybershot.jpeg'
    },
    {'id': '5', 'Name': 'Watch', 'image_url': 'assets/images/mangobake.jpg'},
    {
      'id': '6',
      'Name': 'Watch',
      'image_url': 'assets/images/sonycybershot.jpeg'
    },
    {
      'id': '7',
      'Name': 'Headset',
      'image_url': 'assets/PRODUCT/headphones.jpeg'
    },
    {
      'id': '8',
      'Name': 'Oven',
      'image_url': 'assets/images/microvWaveOven.jpg'
    },
    {'id': '9', 'Name': 'Watch', 'image_url': 'assets/PRODUCT/watch.jpeg'},
  ];
  // ignore: missing_return
  Widget favoriteiconSelected() {
    return Icon(
      Icons.favorite,
      color: Colors.pinkAccent,
    );
  }

  Widget favoriteiconUnSelected() {
    return Icon(
      Icons.favorite_border,
      color: Colors.blueGrey,
    );
  }

  fetchdata() {
    if (keyNameController.text.isNotEmpty) {
      _topStoreFuture = fetchTopStoreSearch(keyNameController.text.toString());
    } else {
      _topStoreFuture = fetchTopStoreSearch();
    }
  }

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
      userLatitude = "${currentPostion.latitude}";
      userLogitude = "${currentPostion.longitude}";
    });
    fetchdata();
  }

  _getCurrentLocation() {
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

  void checkFavStatus(name) {
    if (name == 0) {
      setState(() {
        wishliststatus = false;
      });
    } else if (name > 0) {
      setState(() {
        wishliststatus = true;
      });
    }
  }

  loadDetails([String keyword]) async {
    fetchTopStore(townSelectedStore, mobileNumber, userLatitude, userLogitude,
            apikey, keyword)
        .then((res) async {
      //print('LoadDetails of ${res.fname}');
      //_userController.sink.close();

      _userController.add(res);
      // if (_isDisposed) {

      //   return res;
      // }
      return res;
    });
  }

  search([String keyword]) async {
    fetchTopStore(townSelectedStore, mobileNumber, userLatitude, userLogitude,
            apikey, keyword)
        .then((res) async {
      //print('LoadDetails of ${res.fname}');
      //_userController.sink.close();

      _userController2.add(res);
      // if (_isDisposed) {

      //   return res;
      // }
      return res;
    });
  }
}
