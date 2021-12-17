import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matsapp/Modeles/ExclusiveDealsModel1.dart';
import 'package:matsapp/Network/AddTowishListRest.dart';
import 'package:matsapp/Network/ExclusiveDealsRest1.dart';
import 'package:matsapp/Network/RemovefromwishlistRest.dart';
import 'package:matsapp/Pages/StorePage/StoreProductPage.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/constants/app_vectors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/size_config.dart';

class ProductListWidgets extends StatefulWidget {
  //OfferCardStateless({Key key, this.choice}) : super(key: key);
  //final Choice choice;
  //final int businessId;
  //final String mobileNumber;
  final String selectedTown;
  ProductListWidgets(this.selectedTown);
  @override
  _ProductListWidgetsState createState() => _ProductListWidgetsState();
}

class _ProductListWidgetsState extends State<ProductListWidgets> {
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

  StreamController<ExclusiveDealsModel1> _userController;

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
    // _getCurrentLocation();
    // _userController = new StreamController();
    // Timer.periodic(Duration(seconds: 1), (_) => loadDetails());
    loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<ExclusiveDealsModel1>(
            future: fetchTopExclusiveDeals1(townSelectedStore, mobileNumber,
                apikey, userLatitude, userLogitude),
            builder: (BuildContext context,
                AsyncSnapshot<ExclusiveDealsModel1> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.list1.length > 0) {
                  return GridView.builder(
                    itemCount: snapshot.data.list1.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        //crossAxisSpacing: ,
                        childAspectRatio: 46 / 65),
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.data.list1[index].wishListId == 0) {
                        wishliststatus = false;
                      } else if (snapshot.data.list1[index].wishListId > 0) {
                        wishliststatus = true;
                      }
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Container(
                          // margin: EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 3.0, right: 3.0, bottom: 3.0, top: 3.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: SizeConfig.heightMultiplier * 2.5,

                                  // height:
                                  //     MediaQuery.of(context).size.height / 20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: SvgPicture.asset(
                                          wishliststatus
                                              ? AppVectors.ic_heart1
                                              : AppVectors.ic_heart,

                                          // color: wishliststatus
                                          //     ? Colors.pink
                                          //     : Colors.blueGrey,
                                        ),
                                        onPressed: () {
                                          snapshot.data.list1[index]
                                                      .wishListId ==
                                                  0
                                              ? fetchAddTowishListProduct(
                                                      "Category",
                                                      snapshot.data.list1[index]
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
                                              : fetchRemoveFromwishList(snapshot
                                                      .data
                                                      .list1[index]
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
                                          .data.list1[index].productImage,
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
                                                StoreProductPage(
                                                  snapshot.data.list1[index]
                                                      .productId,
                                                  townSelectedStore,
                                                  snapshot.data.list1[index]
                                                      .productName,
                                                  snapshot.data.list1[index]
                                                      .businessId,
                                                  snapshot.data.list1[index]
                                                      .businessName,
                                                )),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 3, right: 3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          snapshot.data.list1[index]
                                                  .productName ??
                                              "",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15),
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
                                              "${snapshot.data.list1[index].rating}" ??
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
                                Container(
                                  padding: EdgeInsets.only(left: 3, right: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          snapshot.data.list1[index]
                                                          .matsappPrice ==
                                                      "0" ||
                                                  snapshot.data.list1[index]
                                                          .productPrice ==
                                                      "0"
                                              ? snapshot.data.list1[index]
                                                          .productPrice !=
                                                      null
                                                  ? Text(
                                                      "Rs:\r${snapshot.data.list1[index].productPrice}/-" ??
                                                          0,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10),
                                                    )
                                                  : Container()
                                              : snapshot.data.list1[index]
                                                          .matsappPrice !=
                                                      null
                                                  ? Text(
                                                      "Rs:\r${snapshot.data.list1[index].matsappPrice}/-" ??
                                                          0,
                                                      style: AppTextStyle
                                                          .productPriceFont(),
                                                    )
                                                  : Container()
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
                                              "${snapshot.data.list1[index].distanceinKm}\rKms" ??
                                                  "",
                                              style: TextStyle(fontSize: 11),
                                            )
                                          ],
                                        ),
                                      )
                                      // FaIcon(FontAwesomeIcons.rupeeSign),
                                    ],
                                  ),
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
    fetchTopExclusiveDeals1().then((res) async {
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
