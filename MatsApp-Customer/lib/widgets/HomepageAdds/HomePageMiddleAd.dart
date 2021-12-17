import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
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
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageMiddleAd extends StatefulWidget {
  @override
  _HomePageMiddleAdState createState() => _HomePageMiddleAdState();
}

class _HomePageMiddleAdState extends State<HomePageMiddleAd> {
  Future futureTopBanner;

  String townSelectedStore;

  //int current = 0;
  int count = 0;

  Size size;

  HomeAdsBloc _homeAdsBloc;

  Size unselectedSize;

  EdgeInsets margin;

  int current = 0;

  String mobileNumber;

  var apikey;
  @override
  void initState() {
    // _homeAdsBloc = HomeAdsBloc();
    // _homeAdsBloc.eventSink.add(HomeAdsBlocAction.fetch);
    super.initState();

    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          if (mounted)
            setState(() {
              townSelectedStore = value[0].selectedTown;
              mobileNumber = value[0].mobilenumber;
              apikey = value[0].apitoken;
              // futureTopBanner = fetchAdvertisement(townSelectedStore, 'HomePage',
              //     'SecondBanner', mobileNumber, apikey);
            }),

          // prefcheck(
          //     value[0].mobilenumber, value[0].location, value[0].apitoken),
          // // GeneralTools().prefsetLoginInfo(
          // //     ),
        });
  }

  @override
  Widget build(BuildContext context) {
    final addata2 = Provider.of<HomePageDataProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    CarouselController buttonCarouselController = CarouselController();
    // final controller = PageController(viewportFraction: 0.8);
    //
    return Container(
        //width: screenWidth,
        // height: screenHeight * .31,
        child: Column(
      children: [
        addata2.post.banners2 == null
            ? Container()
            : addata2.post.banners2.length > 0
                ? CarouselSlider.builder(
                    itemCount: addata2.post.banners2.length,
                    carouselController: buttonCarouselController,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return InkWell(
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: addata2.post.banners2[index].imageUrl != null
                              ? CachedNetworkImage(
                                  imageUrl:
                                      addata2.post.banners2[index].imageUrl ??
                                          "",
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.fill,
                                  width: screenWidth,
                                  height: screenHeight * .23,
                                )
                              : Container(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.only(top: 10),
                        ),
                        onTap: () {
                          if (addata2.post.banners2[index].redirectionPage
                              .contains("ExternalLink")) {
                            _launchURL(
                                addata2.post.banners2[index].redirectionUrl);
                          } else if (addata2
                              .post.banners2[index].redirectionPage
                              .contains("StorePage")) {
                            // snapshot.data[index]
                            //                           .businessName,
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StorePageProduction(
                                        addata2
                                            .post.banners2[index].redirectionId,
                                        townSelectedStore,
                                        addata2.post.banners2[index].name,
                                      )),
                            );
                          } else if (addata2
                              .post.banners2[index].redirectionPage
                              .contains("ProductPage")) {
                            // snapshot.data[index]
                            //                           .businessName,

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StoreProductPage(
                                          addata2.post.banners2[index]
                                              .redirectionId,
                                          townSelectedStore,
                                          addata2.post.banners2[index].name,
                                          addata2.post.banners2[index]
                                              .redirectionId,
                                          addata2.post.banners2[index]
                                              .businessName,
                                        )));
                          } else if (addata2
                              .post.banners2[index].redirectionPage
                              .contains("OfferPage")) {
                            // snapshot.data[index]
                            //                           .businessName,

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductPageTrending(
                                      addata2
                                          .post.banners2[index].redirectionId,
                                      townSelectedStore,
                                      addata2.post.banners2[index].name,
                                      addata2
                                          .post.banners2[index].redirectionId,
                                      addata2
                                          .post.banners2[index].businessName)),
                            );
                          }
                        },
                      );
                    },
                    options: CarouselOptions(
                        height: screenHeight * .24,
                        aspectRatio: 10 / 9,
                        viewportFraction: 0.9,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 1000),
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
                : Container()
      ],
    ));
  }

  _launchURL(String urlstring) async {
    String url = urlstring;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
