import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matsapp/Modeles/DealsOftheDayModel.dart';
import 'package:matsapp/Network/AddTowishListRest.dart';
import 'package:matsapp/Network/DealsofTheDayRest.dart';
import 'package:matsapp/Network/RemovefromwishlistRest.dart';

import 'package:matsapp/Pages/DealsofDay/DealsofDayProduct/DealsOTheDayProductPage.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/constants/app_vectors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/size_config.dart';

class ProductsListWidgetsDealsofDay2 extends StatefulWidget {
  //OfferCardStateless({Key key, this.choice}) : super(key: key);
  //final Choice choice;
  //final int businessId;
  //final String mobileNumber;
  final String selectedTown;
  ProductsListWidgetsDealsofDay2(this.selectedTown);
  @override
  _ProductsListWidgetsDealsofDayState createState() =>
      _ProductsListWidgetsDealsofDayState();
}

class _ProductsListWidgetsDealsofDayState
    extends State<ProductsListWidgetsDealsofDay2> {
  String townSelectedStore;

  Future exclusiveFuture;

  String mobileNumber;

  bool wishliststatus;

  String apikey;

  double userlatitude;

  double userlogitude;

  String userLatitude;

  Position _currentPosition;

  String userLogitude;

  StreamController<DealsOftheDayModel> _userController;

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
          }),

          // prefcheck(
          //     value[0].mobilenumber, value[0].location, value[0].apitoken),
          // // GeneralTools().prefsetLoginInfo(
          // //     ),
        });
    //_getCurrentLocation();
    // _userController = new StreamController();
    // Timer.periodic(Duration(seconds: 1), (_) => loadDetails());
    _userController = new StreamController();
    loadDetails();
    //loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<DealsOftheDayModel>(
            stream: _userController.stream,
            builder: (BuildContext context,
                AsyncSnapshot<DealsOftheDayModel> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.list2.length > 0) {
                  return GridView.builder(
                    itemCount: snapshot.data.list2.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        //crossAxisSpacing: ,
                        childAspectRatio: 46 / 65),
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.data.list2[index].wishListId == 0) {
                        wishliststatus = false;
                      } else if (snapshot.data.list2[index].wishListId > 0) {
                        wishliststatus = true;
                      }
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Container(
                          // margin: EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 25,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        icon: SvgPicture.asset(
                                          wishliststatus
                                              ? AppVectors.ic_heart1
                                              : AppVectors.ic_heart,
                                          // color: wishliststatus
                                          //     ? Colors.pink
                                          //     : Colors.blueGrey,
                                        ),
                                        onPressed: () {
                                          snapshot.data.list2[index]
                                                      .wishListId ==
                                                  0
                                              ? fetchAddTowishListProduct(
                                                      "Category",
                                                      snapshot.data.list2[index]
                                                          .couponId,
                                                      mobileNumber)
                                                  .then(
                                                  (value) => {
                                                    if (value.result == 1)
                                                      {
                                                        //fetchTopStore(town, mobile, latitude, longitude)
                                                        setState(() {
                                                          wishliststatus = true;
                                                        }),
                                                        // _toggleFavorite(),
                                                        GeneralTools()
                                                            .createSnackBarSuccess(
                                                                "Added to your Wishlist",
                                                                context)
                                                      }
                                                  },
                                                )
                                              : fetchRemoveFromwishList(
                                                    
                                                      snapshot.data.list2[index]
                                                          .wishListId)
                                                  .then((value) => {
                                                        if (value.result == 1)
                                                          {
                                                            setState(() {
                                                              wishliststatus =
                                                                  false;
                                                            }),
                                                            // _toggleFavorite(),
                                                            GeneralTools()
                                                                .createSnackBarFailed(
                                                                    "Removed from Wishlist",
                                                                    context)
                                                          }
                                                      });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: InkWell(
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data.list2[index].productImage,
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.image,
                                        size: 50,
                                      ),
                                      fit: BoxFit.contain,
                                      width: MediaQuery.of(context).size.width *
                                          .40,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .18,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DealsOTheDayProductPage(
                                                    snapshot.data.list2[index]
                                                        .productId,
                                                    townSelectedStore,
                                                    snapshot.data.list2[index]
                                                        .businessName,
                                                    snapshot.data.list2[index]
                                                        .businessId)),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.widthMultiplier * 2,
                                      right: SizeConfig.widthMultiplier * 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          snapshot.data.list2[index]
                                                  .productName ??
                                              "",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: AppTextStyle.productNameFont(),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(1),
                                        height: 20,
                                        width: 45,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.orange),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "${snapshot.data.list2[index].rating}" ??
                                                  "",
                                              style: TextStyle(fontSize: 10),
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
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        snapshot.data.list2[index]
                                                        .matsappPrice ==
                                                    "0" ||
                                                snapshot.data.list2[index]
                                                        .productPrice ==
                                                    "0"
                                            ? Text(
                                                "Rs:\r${snapshot.data.list2[index].productPrice}/-" ??
                                                    "",
                                                style: AppTextStyle
                                                    .productPriceFont(
                                                        color: Colors.black),
                                              )
                                            : Text(
                                                "Rs:\r${snapshot.data.list2[index].matsappPrice}/-" ??
                                                    "",
                                                style: AppTextStyle
                                                    .productPriceFont(),
                                              )
                                      ],
                                    ),

                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 16,
                                            color: Colors.orange[800],
                                          ),
                                          Text(
                                            "${snapshot.data.list2[index].distanceinKm}\rKms" ??
                                                "",
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                    )
                                    // FaIcon(FontAwesomeIcons.rupeeSign),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ],
    );
  }

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

  loadDetails() async {
    fetchDelsOftheDay().then((res) async {
      //print('LoadDetails of ${res.fname}');
      if (res != null) {
        _userController.add(res);
      }

      // if (_isDisposed) {

      //   return res;
      // }
      return res;
    });
  }
}
