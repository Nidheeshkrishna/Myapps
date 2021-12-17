import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matsapp/Modeles/TopStoresModel.dart';
import 'package:matsapp/Modeles/homePageModels/HomePageModel.dart';
import 'package:matsapp/Network/Bloc/topstoreBloc.dart';
import 'package:matsapp/Network/HomeScreenServices/homeScreenRepo.dart';
import 'package:matsapp/Network/topstoresRest.dart';
import 'package:matsapp/Pages/Providers/HomeproviderWithOffers.dart';
import 'package:matsapp/Pages/StorePage/StoreMallPage.dart';
import 'package:matsapp/Pages/StorePage/StorePageProduction.dart';
import 'package:matsapp/Pages/StorePage/StoresInYourArea.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/constants/app_vectors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:matsapp/widgets/LoadingWidgets/Loader9Items.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Modeles/TopStoresModel.dart';

// ignore: camel_case_types
class searchTop9Stores extends StatefulWidget {
  @override
  _searchTop9StoresState createState() => _searchTop9StoresState();
}

class _searchTop9StoresState extends State<searchTop9Stores> {
  Future _TopStoreFuture;
  TopStoresModel topStores;
  StreamController<List<Top9Store>> _userController;
  SharedPreferences prefs;
  String mobilenumber;
  String userLatitude, userLogitude;
  String townSelectedStore;

  Position _currentPosition;
  //String _currentAddress;
  String apikey;
  //final counterbloc = _topstoreBloc();
  bool _isDisposed = true;

  TopstoreHomeBloc _topstoreBloc;

  @override
  void initState() {
    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          if (mounted)
            {
              setState(() {
                townSelectedStore = value[0].selectedTown;
              }),
            }
        });
    // _topstoreBloc = TopstoreHomeBloc();

    // _topstoreBloc.eventSink.add(TopStoreHomeAction.fetch);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final topStoresdata = Provider.of<HomePageDataProvider>(context);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (topStoresdata != null) {
    //     if (topStoresdata.post.apiKeyStatus != null) {
    //       if (topStoresdata.post.apiKeyStatus) {
    //         CommonDialoges().sessionTimeOutDialoge(context);
    //       }
    //     }
    //   }
    // });

    return Column(
      children: [
        topStoresdata.post.top9Store.length == 0
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Top Stores in your location",
                      style: AppTextStyle.homeTitlesfont(),
                    ),
                    SizedBox(height: 15),
                    LoaderWidget9(),
                  ],
                ),
              )
            : topStoresdata.loading
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Top Stores in your location",
                          style: AppTextStyle.homeTitlesfont(),
                        ),
                        SizedBox(height: 15),
                        LoaderWidget9(),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, bottom: 5, left: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Top Stores in your location",
                              style: AppTextStyle.homeTitlesfont(),
                            ),

                            // ignore: deprecated_member_use
                            TextButton(
                              // elevation: 2,
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(5.0),
                              // ),
                              child: Row(children: [
                                Text("View All",
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
                                        builder: (context) =>
                                            StorsInyourArea()));
                              },
                              //color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      GridView.builder(
                        padding: EdgeInsets.only(
                          left: SizeConfig.widthMultiplier * 2.5,
                          right: SizeConfig.widthMultiplier * 2,
                        ),
                        itemCount: topStoresdata.post.top9Store.length,
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(children: <Widget>[
                            Container(
                              child: InkWell(
                                child: AspectRatio(
                                  aspectRatio: 5 / 5,
                                  child: Card(
                                    elevation: 3,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: topStoresdata
                                          .post.top9Store[index].coverImageUrl,
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.image, size: 50),
                                      fit: BoxFit.fill,
                                      width: 120,
                                      height: 120,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (topStoresdata
                                      .post.top9Store[index].isMall) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MallPage(
                                                topStoresdata
                                                    .post
                                                    .top9Store[index]
                                                    .pkBusinessId,
                                                topStoresdata
                                                    .post
                                                    .top9Store[index]
                                                    .businessName,
                                              )),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StorePageProduction(
                                                topStoresdata
                                                    .post
                                                    .top9Store[index]
                                                    .pkBusinessId,
                                                topStoresdata
                                                    .post.top9Store[index].town,
                                                topStoresdata
                                                    .post
                                                    .top9Store[index]
                                                    .businessName,
                                              )),
                                    );
                                  }
                                },
                              ),
                            ),
                            topStoresdata.post.top9Store[index].provideOffers !=
                                    "0"
                                ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        top: 2,
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          .30,
                                      //height: MediaQuery.of(context).size.height * .10,
                                      height: 30,
                                      child: Card(
                                          color: AppColors.kAccentColor,
                                          child: Center(
                                            child: Text(
                                              " ${topStoresdata.post.top9Store[index].provideOffers}%",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          )),
                                    ))
                                : Container(),
                          ]);
                        },
                      ),
                    ],
                  )
        // : Container(child: Text("Expired"));

        // } else {
        //   return Container(
        //     color: Colors.amberAccent,
        //     width: 200,
        //     height: 200,
        //   );
        // }
      ],
    );
  }

  final List<Map<String, Object>> dummyData = [
    {
      'id': '1',
      'image_url': 'assets/images/myg.jpg',
    },
    {
      'id': '2',
      'image_url': 'assets/images/Nandilath.jpg',
    },
    {'id': '3', 'image_url': 'assets/images/esaf.png'},
    {'id': '4', 'image_url': 'assets/images/cosmos.jpg'},
    {'id': '5', 'image_url': 'assets/images/mangobake.jpg'},
    {'id': '6', 'image_url': 'assets/images/R-c.jpg'},
    {'id': '7', 'image_url': 'assets/images/venus.jpg'},
    {'id': '8', 'image_url': 'assets/images/Relife.jpg'},
    {'id': '9', 'image_url': 'assets/images/tulips.jpg'},
  ];
  fetchdata() {
    _TopStoreFuture = fetchTopStore(
      townSelectedStore,
      mobilenumber,
      userLatitude,
      userLogitude,
      apikey,
    );
  }

  Future<HomePageModel> TopStores() async {
    return fetchHomeData(
      townSelectedStore,
      mobilenumber,
      userLatitude,
      userLogitude,
      apikey,
    );
  }

  loadDetails() async {
    fetchHomeData(
      townSelectedStore,
      mobilenumber,
      userLatitude,
      userLogitude,
      apikey,
    ).then((res) async {
      //print('LoadDetails of ${res.fname}');

      if (!_isDisposed) {
        _userController.add(res.top9Store);
        return res;
      }
      return res;
    });
  }

  Future alertDialogSuccess(context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });

          return AlertDialog(
            // insetPadding: EdgeInsets.symmetric(vertical: 100),
            content: Container(
              width: 350,
              height: 380,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Successfully Shared !",
                          style: TextStyle(
                              fontSize: 22,
                              color: AppColors.success_color,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 10),
                        SvgPicture.asset(
                          AppVectors.success_svg,
                          height: 150,
                          width: 150,
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Shop Again",
                          style: TextStyle(color: AppColors.kAccentColor),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
