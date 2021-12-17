import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
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

class HomepageAdwidget4 extends StatefulWidget {
  @override
  _HomepageAdwidget4State createState() => _HomepageAdwidget4State();
}

class _HomepageAdwidget4State extends State<HomepageAdwidget4> {
  Future futureTopBanner;

  String townSelectedStore;

  HomeAdsBloc _homeAdsBloc;

  //int current = 0;
  int count = 0;

  Size size;

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
    dbHelper.getAll().then((value) => {
          if (mounted)
            {
              setState(() {
                townSelectedStore = value[0].selectedTown;
                mobileNumber = value[0].mobilenumber;
                apikey = value[0].apitoken;
                // futureTopBanner = fetchAdvertisement(townSelectedStore,
                //     'HomePage', 'FourthBanner', mobileNumber, apikey);
              }),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    final addata4 = Provider.of<HomePageDataProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    CarouselController buttonCarouselController = CarouselController();

    return Container(
        // width: screenWidth,
        // height: screenHeight * .31,
        child: Column(
      children: [
        addata4.post.banners4 == null
            ? Container()
            : addata4.post.banners4.length > 0
                ? CarouselSlider.builder(
                    itemCount: addata4.post.banners4.length,
                    carouselController: buttonCarouselController,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return InkWell(
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: CachedNetworkImage(
                            imageUrl: addata4.post.banners4[index].imageUrl,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.fill,
                            width: screenWidth,
                            height: screenHeight * .23,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                        ),
                        onTap: () {
                          if (addata4.post.banners4[index].redirectionPage
                              .contains("ExternalLink")) {
                            _launchURL(
                                addata4.post.banners4[index].redirectionUrl);
                          } else if (addata4
                              .post.banners4[index].redirectionPage
                              .contains("StorePage")) {
                            // snapshot.data[index]
                            //                           .businessName,
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StorePageProduction(
                                        addata4
                                            .post.banners4[index].redirectionId,
                                        townSelectedStore,
                                        addata4.post.banners4[index].name,
                                      )),
                            );
                          } else if (addata4
                              .post.banners4[index].redirectionPage
                              .contains("ProductPage")) {
                            // snapshot.data[index]
                            //                           .businessName,

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StoreProductPage(
                                          addata4.post.banners4[index]
                                              .redirectionId,
                                          townSelectedStore,
                                          addata4.post.banners4[index].name,
                                          addata4.post.banners4[index]
                                              .redirectionId,
                                          addata4.post.banners4[index]
                                              .businessName,
                                        )));
                          } else if (addata4
                              .post.banners4[index].redirectionPage
                              .contains("OfferPage")) {
                            // snapshot.data[index]
                            //                           .businessName,

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductPageTrending(
                                      addata4
                                          .post.banners4[index].redirectionId,
                                      townSelectedStore,
                                      addata4.post.banners4[index].name,
                                      addata4
                                          .post.banners4[index].redirectionId,
                                      addata4
                                          .post.banners4[index].businessName)),
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
