import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Modeles/Mallpage/MallPageModel.dart';
import 'package:matsapp/Network/MallPageRepo.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../Network/AddTowishListRest.dart';
import '../../Network/RemovefromwishlistRest.dart';
import '../../utilities/GerneralTools.dart';

class MallPageWidget extends StatefulWidget {
  final int businessId;

  MallPageWidget(this.businessId);
  @override
  _MallPageWidgetState createState() => _MallPageWidgetState();
}

class _MallPageWidgetState extends State<MallPageWidget> {
  Future futureMallInfo;

  bool wishliststatus = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      futureMallInfo = fetchMallInfo(
        widget.businessId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height - kToolbarHeight;
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<MallPageModel>(
              future: futureMallInfo,
              builder: (BuildContext context,
                  AsyncSnapshot<MallPageModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data != null) {
                  if (snapshot.data.businessList.length > 0) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.businessList.length,
                        physics: ScrollPhysics(),
                        //physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          if (snapshot.data.businessList[index].wishListId ==
                              0) {
                            wishliststatus = false;
                          } else if (snapshot
                                  .data.businessList[index].wishListId >
                              0) {
                            wishliststatus = true;
                          }
                          return Card(
                              elevation: 10,
                              //clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    width: screenwidth,
                                    height: screenHight * .20,
                                    child: Row(
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Container(
                                              width: screenwidth * .33,
                                              height: screenHight * .20,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                clipBehavior: Clip.hardEdge,
                                                child: CachedNetworkImage(
                                                  imageUrl: snapshot
                                                      .data
                                                      .businessList[index]
                                                      .coverImageUrl,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                          snapshot
                                                              .data
                                                              .businessList[
                                                                  index]
                                                              .businessName,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14)),
                                                    ],
                                                  ),
                                                  Container(
                                                    // width: 200,
                                                    //height: 40,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              left: 5),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            "${snapshot.data.businessList[index].rating}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SmoothStarRating(
                                                              allowHalfRating:
                                                                  false,
                                                              onRated: (v) {},
                                                              starCount: 5,
                                                              rating: snapshot
                                                                  .data
                                                                  .businessList[
                                                                      index]
                                                                  .rating
                                                                  .toDouble(),
                                                              size: 18.0,
                                                              isReadOnly: true,
                                                              filledIconData:
                                                                  Icons
                                                                      .star_rate,
                                                              color: Colors
                                                                  .amberAccent,
                                                              borderColor:
                                                                  Colors
                                                                      .blueGrey,
                                                              spacing: 0.0),
                                                          Text("(12 Reviews)",
                                                              style: TextStyle(
                                                                  fontSize: 11))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text("Location"),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 1,
                                                                  left: 15),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on,
                                                                size: 15,
                                                                color: Colors
                                                                        .orange[
                                                                    300],
                                                              ),
                                                              Text(
                                                                  snapshot
                                                                      .data
                                                                      .businessList[
                                                                          index]
                                                                      .distanceinKm,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Align(
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .50,
                                                              height: 31,
                                                              // MediaQuery.of(context).size.height *
                                                              //.10,
                                                              //height: 30,
                                                              child: Card(
                                                                  color: Colors
                                                                          .orange[
                                                                      400],
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    '${snapshot.data.businessList[index].provideOffers}%',
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
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      icon: Icon(
                                        wishliststatus
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: wishliststatus
                                            ? Colors.pink
                                            : Colors.blueGrey,
                                      ),
                                      onPressed: () {
                                        snapshot.data.businessList[index]
                                                    .wishListId ==
                                                0
                                            ? fetchAddTowishList(
                                                "Store",
                                                snapshot
                                                    .data
                                                    .businessList[index]
                                                    .pkBusinessId,
                                              ).then(
                                                (value) => {
                                                  if (value.result == 1)
                                                    {
                                                      //fetchTopStore(town, mobile, latitude, longitude)
                                                      setState(() {
                                                        wishliststatus = true;
                                                      }),
                                                      GeneralTools()
                                                          .createSnackBarSuccess(
                                                              "Added to your Wishlist",
                                                              context)
                                                    }
                                                },
                                              )
                                            : fetchRemoveFromwishList(snapshot
                                                    .data
                                                    .businessList[index]
                                                    .wishListId)
                                                .then((value) => {
                                                      if (value.result == 1)
                                                        {
                                                          setState(() {
                                                            wishliststatus =
                                                                false;
                                                          }),
                                                          GeneralTools()
                                                              .createSnackBarFailed(
                                                                  "Removed from Wishlist",
                                                                  context)
                                                        }
                                                    });
                                      },
                                    ),
                                  ),
                                ],
                              ));
                        });
                  } else {
                    return Container();
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}
