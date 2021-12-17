import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matsapp/Modeles/SearchOffersListModel.dart';
import 'package:matsapp/Network/SearchOfferslistRepo.dart';
import 'package:matsapp/Pages/StorePage/StorePageProduction.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';

class SearchViewAllProduct extends StatefulWidget {
  final String selected_state;
  final double userLatitude;
  final double userLogitude;
  final String keyword;
  SearchViewAllProduct(
      this.selected_state, this.userLatitude, this.userLogitude, this.keyword);
  @override
  _OfferInYourAreaSearchState createState() => _OfferInYourAreaSearchState();
}

class _OfferInYourAreaSearchState extends State<SearchViewAllProduct> {
  Future futurestoreDetailessearch;

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

    if (mounted) {
      setState(() {
        futurestoreDetailessearch = fetchSearchOffers(
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
            "Stores",
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
      body: Container(
        child: FutureBuilder<SearchListModel>(
            future: futurestoreDetailessearch,
            builder: (BuildContext context,
                AsyncSnapshot<SearchListModel> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.allStores.length > 0) {
                  return GridView.builder(
                    shrinkWrap: true,
                    //scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.allStores.length,
                    physics: ClampingScrollPhysics(),
                    primary: true,
                    //physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      //crossAxisSpacing: ,
                      childAspectRatio: 1 / 1.35,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: Column(
                          children: [
                            Card(
                              elevation: 5,
                              clipBehavior: Clip.hardEdge,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data.allStores[index].coverImageUrl,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => Icon(
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
                                  snapshot.data.allStores[index].businessName,
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
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 14,
                                            color: Colors.orange[400],
                                          ),
                                          new Text(
                                            '${snapshot.data.allStores[index].distanceinKm}\rKms',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StorePageProduction(
                                      snapshot
                                          .data.allStores[index].pkBusinessId,
                                      townSelectedStore,
                                      snapshot
                                          .data.allStores[index].businessName,
                                    )),
                          );
                        },
                      );
                    },
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
                                  fontSize: 18, fontWeight: FontWeight.bold)),
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
      ),
    );
  }
}
