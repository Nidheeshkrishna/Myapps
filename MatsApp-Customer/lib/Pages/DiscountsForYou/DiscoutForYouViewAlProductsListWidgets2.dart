import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

import 'package:matsapp/Modeles/DiscountForyouModel.dart';
import 'package:matsapp/Network/AddTowishListRest.dart';
import 'package:matsapp/Network/DiscountForYouRest.dart';
import 'package:matsapp/Network/RemovefromwishlistRest.dart';
import 'package:matsapp/Pages/DiscountsForYou/DiscountsForYouProduct/DiscoutForYouProductPage.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/constants/app_vectors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/size_config.dart';

class DiscoutForYouViewAlProductsListWidgets2 extends StatefulWidget {
  //OfferCardStateless({Key key, this.choice}) : super(key: key);
  //final Choice choice;
  //final int businessId;
  //final String mobileNumber;
  final String selectedTown;
  DiscoutForYouViewAlProductsListWidgets2(this.selectedTown);
  @override
  _ProductsListWidgetsDealsofDayState createState() =>
      _ProductsListWidgetsDealsofDayState();
}

class _ProductsListWidgetsDealsofDayState
    extends State<DiscoutForYouViewAlProductsListWidgets2> {
  String townSelectedStore;

  Future exclusiveFuture;

  String mobileNumber;

  String apiKey;

  Position _currentPosition;

  String userLatitude;

  String userLogitude;

  bool wishliststatus;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();

    dbHelper.getAll().then((value) => {
          setState(() {
            townSelectedStore = value[0].selectedTown;
            mobileNumber = value[0].mobilenumber;
            apiKey = value[0].apitoken;
            // exclusiveFuture = fetchDiscountforyou(townSelectedStore,
            //     mobileNumber, apiKey, userLatitude, userLogitude);
          }),

          // prefcheck(
          //     value[0].mobilenumber, value[0].location, value[0].apitoken),
          // // GeneralTools().prefsetLoginInfo(
          // //     ),
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DiscountForyouModel>(
        future: fetchDiscountforyou(townSelectedStore, mobileNumber, apiKey,
            userLatitude, userLogitude),
        builder: (BuildContext context,
            AsyncSnapshot<DiscountForyouModel> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.list2.length > 0) {
              return GridView.builder(
                itemCount: snapshot.data.list2.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: SizeConfig.heightMultiplier * 1,
                  //crossAxisSpacing: ,
                  childAspectRatio: 1 / 1.25,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.data.list2[index].wishListId == 0) {
                    wishliststatus = false;
                  } else if (snapshot.data.list2[index].wishListId > 0) {
                    wishliststatus = true;
                  }
                  return InkWell(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.widthMultiplier * 2,
                          right: SizeConfig.widthMultiplier * 2,
                          top: SizeConfig.widthMultiplier * 3,
                          bottom: SizeConfig.widthMultiplier * 2,
                        ),
                        child: Container(
                          // margin: EdgeInsets.all(8),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 16,
                                // width: MediaQuery.of(context).size.width * .60,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
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
                                        snapshot.data.list2[index].wishListId ==
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
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 1.1,
                              ),
                              Container(
                                // width: 150,
                                //height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        snapshot.data.list2[index].productImage,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.image, size: 50),
                                    fit: BoxFit.contain,
                                    width:
                                        MediaQuery.of(context).size.width * .50,
                                    height: MediaQuery.of(context).size.height *
                                        .16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        snapshot.data.list2[index].productName,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
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
                                height: SizeConfig.heightMultiplier * .5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  snapshot.data.list2[index].matsappPrice !=
                                              ("0") &&
                                          snapshot.data.list2[index]
                                                  .matsappPrice !=
                                              null
                                      ? Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/rupee.png",
                                              color: AppColors.mHomeGreen,
                                              width:
                                                  SizeConfig.widthMultiplier *
                                                      3.5,
                                              height:
                                                  SizeConfig.widthMultiplier *
                                                      3,
                                            ),
                                            Text(
                                              "${snapshot.data.list2[index].matsappPrice}/-" ??
                                                  "",
                                              style: AppTextStyle
                                                  .productPriceFont(),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  // FaIcon(FontAwesomeIcons.rupeeSign),
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
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DiscoutForYouProductPage(
                                snapshot.data.list2[index].productId,
                                townSelectedStore,
                                snapshot.data.list2[index].businessName,
                                snapshot.data.list2[index].businessId)),
                      );
                    },
                  );
                },
              );
            } else {
              return Container();
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
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
}
