import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:matsapp/Modeles/SearchOffersListModel.dart';
import 'package:matsapp/Network/SearchOfferslistRepo.dart';
import 'package:matsapp/Pages/Search/offerviewAllSearch.dart';
import 'package:matsapp/Pages/TrendingOffers/ProductPageTrending.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/size_config.dart';

class OfferInYourAreaSearch extends StatefulWidget {
  final String selected_town;
  final double userLatitude;
  final double userLogitude;
  final String keyword;
  OfferInYourAreaSearch(
      this.selected_town, this.userLatitude, this.userLogitude, this.keyword);
  @override
  _OfferInYourAreaSearchState createState() => _OfferInYourAreaSearchState();
}

class _OfferInYourAreaSearchState extends State<OfferInYourAreaSearch> {
  Future<SearchListModel> futurestoresearchoffers;

  String townSelectedStore;

  Future<SearchListModel> futurestoresearch;

  var currentPostion;

  var userLatitude;

  var userLogitude;

  @override
  void initState() {
    super.initState();
    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          setState(() {
            townSelectedStore = value[0].selectedTown;
          }),
        });
    _getUserLocation();
    //  setState(() {
    //   futurestoresearchoffers = fetchSearchOffers(widget.keyword,
    //       townSelectedStore, widget.userLatitude, widget.userLogitude);
    // });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          FutureBuilder<SearchListModel>(
              future: futurestoresearch,
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.offers.length > 0) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text("Offers in your Area ",
                                  style: AppTextStyle.homeTitlesfont()),
                            ),
                            TextButton(
                              // style: ElevatedButton.styleFrom(
                              //     primary: Colors.white,
                              //     elevation: 10,
                              //     onPrimary: Colors.blue,
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(7.0),
                              //     )),
                              child: Row(children: [
                                Text("View All ",
                                    style: AppTextStyle.homeViewAllFont()),
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
                                      builder: (context) => offerviewAllSearch(
                                          widget.selected_town,
                                          widget.userLatitude,
                                          widget.userLogitude,
                                          widget.keyword)),
                                );
                              },
                            )
                          ],
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          // scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.offers.length,
                          physics: ClampingScrollPhysics(),
                          primary: true,
                          //physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  //crossAxisSpacing: ,
                                  childAspectRatio: 1 / 1.3),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: InkWell(
                                child: Card(
                                    elevation: 2,
                                    //clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: CachedNetworkImage(
                                                imageUrl: snapshot.data
                                                    .offers[index].productImage,
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Icon(Icons.image, size: 30),
                                                fit: BoxFit.contain,
                                                width: screenWidth * .50,
                                                height: screenHeight * .15),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Row(
                                              //mainAxisAlignment:
                                              // MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    snapshot.data.offers[index]
                                                        .offerName,
                                                    textAlign: TextAlign.left,
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTextStyle
                                                        .productNameFont(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/rupee.png",
                                                      color: Colors.black,
                                                      width: 15,
                                                      height: SizeConfig
                                                              .widthMultiplier *
                                                          3,
                                                    ),
                                                    Text(
                                                      "${snapshot.data.offers[index].mrp}/-",
                                                      style: AppTextStyle
                                                          .productPriceFont(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 14,
                                                    color: Colors.orange[400],
                                                  ),
                                                  new Text(
                                                    '${snapshot.data.offers[index].distanceinKm}\rKms',
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                margin: EdgeInsets.all(2),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .50,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    18,
                                                //height: 30,
                                                child: Card(
                                                    color: Colors.orange[400],
                                                    child: Center(
                                                      child: Text(
                                                        " Save ${snapshot.data.offers[index].discount}%",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    )),
                                              ))
                                        ],
                                      ),
                                    )),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductPageTrending(
                                                snapshot
                                                    .data.offers[index].offerId,
                                                townSelectedStore,
                                                snapshot.data.offers[index]
                                                    .offerName,
                                                snapshot.data.offers[index]
                                                    .businessId)),
                                  );
                                },
                              ),
                            );
                          },
                        )
                      ],
                    );
                  } else {
                    return Container(
                        //     child: Center(
                        //   child: AspectRatio(
                        //     aspectRatio: 7 / 7,
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Text("Oops!.....",
                        //             style: TextStyle(
                        //                 fontSize: 18, fontWeight: FontWeight.bold)),
                        //         SvgPicture.asset(
                        //             "assets/vectors/search_result_empty.svg"),
                        //       ],
                        //     ),
                        //   ),
                        //
                        );
                  }
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }

  fetchdata() {
    futurestoresearch = fetchSearchOffers(
      widget.keyword,
      widget.selected_town,
    );
  }

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
      userLatitude = currentPostion.latitude;
      userLogitude = currentPostion.longitude;
    });
    fetchdata();
  }
}
