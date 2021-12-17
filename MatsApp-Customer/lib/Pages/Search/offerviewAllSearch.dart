import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matsapp/Modeles/SearchOffersListModel.dart';
import 'package:matsapp/Network/SearchOfferslistRepo.dart';
import 'package:matsapp/Pages/TrendingOffers/ProductPageTrending.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/size_config.dart';

class offerviewAllSearch extends StatefulWidget {
  final String selected_state;
  final double userLatitude;
  final double userLogitude;
  final String keyword;
  offerviewAllSearch(
      this.selected_state, this.userLatitude, this.userLogitude, this.keyword);
  @override
  _offerviewAllSearchState createState() => _offerviewAllSearchState();
}

class _offerviewAllSearchState extends State<offerviewAllSearch> {
  var futurestoreDetailes123;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        futurestoreDetailes123 = fetchSearchOffers(
          widget.keyword,
          widget.selected_state,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Offers in your Area",
            style: TextStyle(fontSize: 17, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              FutureBuilder<SearchListModel>(
                  future: futurestoreDetailes123,
                  builder: (BuildContext context,
                      AsyncSnapshot<SearchListModel> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.allOffers.length > 0) {
                        return Column(
                          children: [
                            GridView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.allOffers.length,
                              physics: ClampingScrollPhysics(),
                              //primary: true,
                              //physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                //crossAxisSpacing: ,
                                childAspectRatio: 1 / 1.3,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  child: Card(
                                      elevation: 5,
                                      //clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: CachedNetworkImage(
                                                  imageUrl: snapshot
                                                      .data
                                                      .allOffers[index]
                                                      .productImage,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Icon(Icons.image,
                                                          size: 50),
                                                  fit: BoxFit.contain,
                                                  width: screenWidth * .50,
                                                  height: screenHeight * .15),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      snapshot
                                                          .data
                                                          .allOffers[index]
                                                          .offerName,
                                                      softWrap: true,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppTextStyle
                                                          .productNameFont(),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              heightFactor: .90,
                                              widthFactor: .90,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/rupee.png",
                                                          color: Colors.black,
                                                          width: SizeConfig
                                                                  .heightMultiplier *
                                                              1.55,
                                                          height: SizeConfig
                                                                  .heightMultiplier *
                                                              1.55,
                                                        ),
                                                        Text(
                                                          "${snapshot.data.allOffers[index].mrp}/-",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 12,
                                                        color:
                                                            Colors.orange[400],
                                                      ),
                                                      new Text(
                                                        '${snapshot.data.allOffers[index].distanceinKm}Kms',
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Align(
                                                alignment:
                                                    Alignment.bottomCenter,
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
                                                          " Save ${snapshot.data.allOffers[index].discount}%",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                                  snapshot.data.allOffers[index]
                                                      .offerId,
                                                  widget.selected_state,
                                                  snapshot.data.allOffers[index]
                                                      .offerName,
                                                  snapshot.data.allOffers[index]
                                                      .businessId)),
                                    );
                                  },
                                );
                              },
                            )
                          ],
                        );
                      } else {
                        return Container(
                            child: Center(
                          child: AspectRatio(
                            aspectRatio: 7 / 7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Oops!.....",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SvgPicture.asset(
                                    "assets/vectors/search_result_empty.svg"),
                              ],
                            ),
                          ),
                        ));
                      }
                    } else {
                      return Container();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
