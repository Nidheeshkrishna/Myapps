import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Modeles/SqlLiteTableDataModel.dart';
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

class HomepageAdwidget3 extends StatefulWidget {
  @override
  _HomepageAdwidget3State createState() => _HomepageAdwidget3State();
}

class _HomepageAdwidget3State extends State<HomepageAdwidget3> {
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

  String apikey;
  @override
  void initState() {
    // _homeAdsBloc = HomeAdsBloc();
    // _homeAdsBloc.eventSink.add(HomeAdsBlocAction.fetch);

    super.initState();
    getdata().then((value) => {
          if (mounted)
            {
              setState(() {
                // futureTopBanner = fetchAdvertisement(townSelectedStore, 'HomePage',
                //     'ThirdBanner', mobileNumber, apikey);
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    final addata3 = Provider.of<HomePageDataProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    CarouselController buttonCarouselController = CarouselController();

    return Container(
        // width: screenWidth,
        // height: screenHeight * .31,
        child: Column(
      children: [
        //count = snapshot.data.length;

        addata3.post.banners3 == null
            ? Container()
            : addata3.post.banners3.length > 0
                ? CarouselSlider.builder(
                    itemCount: addata3.post.banners3.length,
                    carouselController: buttonCarouselController,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return InkWell(
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: CachedNetworkImage(
                            imageUrl: addata3.post.banners3[index].imageUrl,
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
                          if (addata3.post.banners3[index].redirectionPage
                              .contains("ExternalLink")) {
                            _launchURL(
                                addata3.post.banners3[index].redirectionUrl);
                          } else if (addata3
                              .post.banners3[index].redirectionPage
                              .contains("StorePage")) {
                            // snapshot.data[index]
                            //                           .businessName,
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StorePageProduction(
                                        addata3
                                            .post.banners3[index].redirectionId,
                                        townSelectedStore,
                                        addata3.post.banners3[index].name,
                                      )),
                            );
                          } else if (addata3
                              .post.banners3[index].redirectionPage
                              .contains("ProductPage")) {
                            // snapshot.data[index]
                            //                           .businessName,

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StoreProductPage(
                                          addata3.post.banners3[index]
                                              .redirectionId,
                                          townSelectedStore,
                                          addata3.post.banners3[index].name,
                                          addata3.post.banners3[index]
                                              .redirectionId,
                                          addata3.post.banners3[index]
                                              .businessName,
                                        )));
                          } else if (addata3
                              .post.banners3[index].redirectionPage
                              .contains("OfferPage")) {
                            // snapshot.data[index]
                            //                           .businessName,

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductPageTrending(
                                      addata3
                                          .post.banners3[index].redirectionId,
                                      townSelectedStore,
                                      addata3.post.banners3[index].name,
                                      addata3
                                          .post.banners3[index].redirectionId,
                                      addata3
                                          .post.banners3[index].businessName)),
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

  Future getdata() async {
    DatabaseHelper dbHelper = new DatabaseHelper();
    List<UserInfo> user = await dbHelper.getAll();
    if (mounted) {
      setState(() {
        townSelectedStore = user.first.selectedTown;
        mobileNumber = user.first.mobilenumber;
        apikey = user.first.apitoken;
      });
    }
  }
}
