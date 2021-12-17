import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:matsapp/Modeles/homePageModels/HomePageModel.dart';
import 'package:matsapp/Modeles/homeTopBannerModel.dart';
import 'package:matsapp/Network/Bloc/homeAdsBloc.dart';
import 'package:matsapp/Network/homeTopbannerRepo.dart';
import 'package:matsapp/Pages/Providers/Homeprovider.dart';
import 'package:matsapp/Pages/Providers/HomeproviderWithOffers.dart';
import 'package:matsapp/Pages/StorePage/StorePageProduction.dart';
import 'package:matsapp/Pages/StorePage/StoreProductPage.dart';
import 'package:matsapp/Pages/TrendingOffers/ProductPageTrending.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/widgets/LoadingWidgets/LoaderItem.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

class HomePageTopAddWidget extends StatefulWidget {
  @override
  _HomePageTopAddWidgetState createState() => _HomePageTopAddWidgetState();
}

class _HomePageTopAddWidgetState extends State<HomePageTopAddWidget> {
  Future futureTopBanner;

  String townSelectedStore;

  HomeAdsBloc _homeAdsBloc;
  //int current = 0;
  int count = 0;

  Size size;

  Size unselectedSize;

  EdgeInsets margin;

  int current = 0;
  String apikey;

  String mobileNumber;
  @override
  void initState() {
    // _homeAdsBloc = HomeAdsBloc();
    // _homeAdsBloc.eventSink.add(HomeAdsBlocAction.fetch);
    DatabaseHelper dbHelper = new DatabaseHelper();
    dbHelper.getAll().then((value) => {
          if (mounted)
            setState(() {
              townSelectedStore = value[0].selectedTown;
              mobileNumber = value[0].mobilenumber;
              apikey = value[0].apitoken;
              // futureTopBanner = fetchAdvertisement(townSelectedStore, 'HomePage',
              //     'TopBanner', mobileNumber, apikey);
            }),

          // prefcheck(
          //     value[0].mobilenumber, value[0].location, value[0].apitoken),
          // // GeneralTools().prefsetLoginInfo(
          // //     ),
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addata = Provider.of<HomePageDataProvider>(context);
    // WidgetsFlutterBinding.ensureInitialized();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    CarouselController buttonCarouselController = CarouselController();
    //
    //final controller = PageController(viewportFraction: 0.8);
    if (addata.post.banners1 != null) {
      count = addata.post.banners1.length;
    }

    return SingleChildScrollView(
      child: Container(
          //width: screenWidth,

          // height: screenHeight * .26,
          child: SingleChildScrollView(
        child: Column(
          children: [
            //count = snapshot.data.length;

            addata.post.banners1 == null
                ? LoaderItemWidget()
                : addata.post.banners1.length > 0 ?? 0
                    ? CarouselSlider.builder(
                        itemCount: addata.post.banners1.length,
                        carouselController: buttonCarouselController,
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return InkWell(
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: CachedNetworkImage(
                                imageUrl: addata.post.banners1[index].imageUrl,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.image, size: 50),
                                fit: BoxFit.fill,
                                width: screenWidth,
                                height: screenHeight * .23,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 3,
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                            ),
                            onTap: () {
                              if (addata.post.banners1[index].redirectionPage
                                  .contains("ExternalLink")) {
                                if (addata
                                        .post.banners1[index].redirectionUrl !=
                                    null) {
                                  _launchURL(addata
                                      .post.banners1[index].redirectionUrl);
                                }
                              } else if (addata
                                  .post.banners1[index].redirectionPage
                                  .contains("StorePage")) {
                                // snapshot.data[index]
                                //                           .businessName,
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StorePageProduction(
                                            addata.post.banners1[index]
                                                .redirectionId,
                                            townSelectedStore,
                                            addata.post.banners1[index].name,
                                          )),
                                );
                              } else if (addata
                                  .post.banners1[index].redirectionPage
                                  .contains("ProductPage")) {
                                // snapshot.data[index]
                                //                           .businessName,

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StoreProductPage(
                                              addata.post.banners1[index]
                                                  .redirectionId,
                                              townSelectedStore,
                                              addata.post.banners1[index].name,
                                              addata.post.banners1[index].id,
                                              addata.post.banners1[index]
                                                      .businessName ??
                                                  "",
                                            )));
                              } else if (addata
                                  .post.banners1[index].redirectionPage
                                  .contains("OfferPage")) {
                                // snapshot.data[index]
                                //                           .businessName,

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductPageTrending(
                                          addata.post.banners1[index]
                                              .redirectionId,
                                          townSelectedStore,
                                          addata.post.banners1[index].name,
                                          addata.post.banners1[index]
                                              .redirectionId,
                                          addata.post.banners1[index]
                                              .businessName)),
                                );
                              } else {
                                return Container();
                              }
                            },
                          );
                        },
                        options: CarouselOptions(
                            height: screenHeight * .23,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.9,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            //carouselController: buttonCarouselController,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) => {
                                  setState(() {
                                    current = index;
                                    //print("$_current");
                                  }),
                                }),
                      )
                    : Container(),

            SizedBox(height: 10),
            count > 1
                ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    for (int i = 0; i < count; i++)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                        ),
                        child: Container(
                            height: 9,
                            width: 10,
                            decoration: BoxDecoration(
                                color:
                                    i == current ? Colors.grey : Colors.white,
                                border: Border.all(color: Colors.amber),
                                borderRadius: BorderRadius.circular(5))),
                      )
                  ])
                : Container(),
          ],
        ),
      )),
    );
  }

  _launchURL(String urlstring) async {
    String url = urlstring;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // loadDetails() async {
  //  fetchAdvertisement(townSelectedStore, 'HomePage',
  //               'TopBanner', mobileNumber, apikey).then((res) async {
  //     //print('LoadDetails of ${res.fname}');
  //     _userController.add(res);
  //     // if (_isDisposed) {

  //     //   return res;
  //     // }
  //     return res;
  //   });
  // }
}
