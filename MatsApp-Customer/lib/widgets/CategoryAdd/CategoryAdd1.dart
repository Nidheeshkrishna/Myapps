import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Modeles/homeTopBannerModel.dart';
import 'package:matsapp/Network/CategoryaddRepo.dart';
import 'package:matsapp/Pages/StorePage/StorePageProduction.dart';
import 'package:matsapp/Pages/StorePage/StoreProductPage.dart';
import 'package:matsapp/Pages/TrendingOffers/ProductPageTrending.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryAdd1 extends StatefulWidget {
  final int catgoryId;
  CategoryAdd1(this.catgoryId);
  @override
  _DealsoftheDayAdd1State createState() => _DealsoftheDayAdd1State();
}

class _DealsoftheDayAdd1State extends State<CategoryAdd1> {
  Future futureTopBanner;

  String townSelectedStore;

  //int current = 0;
  int count = 0;

  Size size;

  Size unselectedSize;

  EdgeInsets margin;

  int current = 0;

  String mobileNumber;

  var apikey;

  Future<TopBannerModel> futureTopBannerCatergory;
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
            futureTopBannerCatergory = fetchAdvertisementCatregory(
                townSelectedStore,
                'CategoryPage',
                'TopBanner',
                mobileNumber,
                apikey,
                widget.catgoryId);
          }),

          // prefcheck(
          //     value[0].mobilenumber, value[0].location, value[0].apitoken),
          // // GeneralTools().prefsetLoginInfo(
          // //     ),
        });

    // SharedPreferences.getInstance().then((prefs) {
    //   SharedPreferences sharedPrefs;
    //   setState(() => sharedPrefs = prefs);
    //   setState(() {
    //     townSelectedStore = sharedPrefs.getString('SELECTED_TOWN');
    //     String apikey = sharedPrefs.getString('USER_API_KEY');
    //     mobileNumber = sharedPrefs.getString('USER_MOBILE');
    //     futureTopBanner =
    //         fetchAdvertisement(townSelectedStore, 'DealOfTheDay', 'TopBanner',mobileNumber,apikey);
    //   });

    //   //hotSpotsFuture = fetchHotSpot(townSelectedStore);
    // });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    CarouselController buttonCarouselController = CarouselController();

    return Container(
        //width: screenWidth,
        //height: screenHeight * .26,
        child: Column(
      children: [
        FutureBuilder<TopBannerModel>(
          future: futureTopBannerCatergory,
          builder:
              (BuildContext context, AsyncSnapshot<TopBannerModel> snapshot) {
            if (snapshot.hasData) {
              count = snapshot.data.result.length;
              if (snapshot.data.result.length > 0) {
                return CarouselSlider.builder(
                  itemCount: snapshot.data.result.length,
                  carouselController: buttonCarouselController,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    return InkWell(
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data.result[index].imageUrl,
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
                        if (snapshot.data.result[index].redirectionPage
                            .contains("ExternalLink")) {
                          _launchURL(
                              snapshot.data.result[index].redirectionUrl);
                        } else if (snapshot.data.result[index].redirectionPage
                            .contains("StorePage")) {
                          // snapshot.data.result[index]
                          //                           .businessName,
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StorePageProduction(
                                      snapshot.data.result[index].redirectionId,
                                      townSelectedStore,
                                      snapshot.data.result[index].name,
                                    )),
                          );
                        } else if (snapshot.data.result[index].redirectionPage
                            .contains("ProductPage")) {
                          // snapshot.data.result[index]
                          //                           .businessName,

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StoreProductPage(
                                        snapshot
                                            .data.result[index].redirectionId,
                                        townSelectedStore,
                                        snapshot.data.result[index].name,
                                        snapshot
                                            .data.result[index].redirectionId,
                                        snapshot.data.result[index].name,
                                      )));
                        } else if (snapshot.data.result[index].redirectionPage
                            .contains("OfferPage")) {
                          // snapshot.data.result[index]
                          //                           .businessName,

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductPageTrending(
                                    snapshot.data.result[index].redirectionId,
                                    townSelectedStore,
                                    snapshot.data.result[index].name,
                                    snapshot.data.result[index].redirectionId)),
                          );
                        }
                      },
                    );
                  },
                  options: CarouselOptions(
                      height: screenHeight * .25,
                      aspectRatio: 10 / 9,
                      viewportFraction: 0.9,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
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
                );
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          },
        ),
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
