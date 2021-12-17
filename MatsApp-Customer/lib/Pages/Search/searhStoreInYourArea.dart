import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:matsapp/Modeles/SearchOffersListModel.dart';
import 'package:matsapp/Network/SearchOfferslistRepo.dart';
import 'package:matsapp/Pages/Search/SearchViewAllProduct.dart';
import 'package:matsapp/Pages/StorePage/StorePageProduction.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';

// ignore: camel_case_types
class searchStoreInYourArea extends StatefulWidget {
  final String selected_state;
  final double userLatitude;
  final double userLogitude;
  final String keyword;
  searchStoreInYourArea(
      this.selected_state, this.userLatitude, this.userLogitude, this.keyword);
  @override
  _searchStoreInYourAreaState createState() => _searchStoreInYourAreaState();
}

// ignore: camel_case_types
class _searchStoreInYourAreaState extends State<searchStoreInYourArea> {
  Future<SearchListModel> futurestoresearch;

  double userLatitude;

  double userLogitude;

  LatLng currentPostion;

  String townSelectedStore;

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
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder<SearchListModel>(
        future: futurestoresearch,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.stores.length > 0) {
              print(snapshot.data.stores.length);
              return Column(
                //scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Stores in your Area ",
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
                                builder: (context) => SearchViewAllProduct(
                                    widget.selected_state,
                                    widget.userLatitude,
                                    widget.userLogitude,
                                    widget.keyword)),
                          );
                        },
                      )
                    ],
                  ),
                  Container(
                    width: screenWidth,
                    height: screenHeight * .34,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.stores.length,
                        //physics: ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        // primary: true,
                        //physics: const NeverScrollableScrollPhysics(),

                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Card(
                                      elevation: 2,
                                      clipBehavior: Clip.hardEdge,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data.stores[index].coverImageUrl,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(
                                                Icons.image,
                                                size: 50,
                                              ),
                                          fit: BoxFit.fill,
                                          width: screenWidth * .50,
                                          height: screenHeight * .25),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          snapshot
                                              .data.stores[index].businessName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 2.0, bottom: 10),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 12,
                                                    color: Colors.orange[400],
                                                  ),
                                                  new Text(
                                                    '${snapshot.data.stores[index].distanceinKm}\rKms',
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StorePageProduction(
                                          snapshot
                                              .data.stores[index].pkBusinessId,
                                          townSelectedStore,
                                          snapshot
                                              .data.stores[index].businessName,
                                        )),
                              );
                            },
                          );
                        }),
                  ),
                ],
              );
            } else {
              return Container();
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  fetchdata() {
    futurestoresearch = fetchSearchOffers(
        widget.keyword, widget.selected_state,);
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
