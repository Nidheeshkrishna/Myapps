import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matsapp/Modeles/HotSpotModel.dart';
import 'package:matsapp/Network/HotSpotRest.dart';
import 'package:matsapp/Pages/StorePage/StorePageProduction.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/size_config.dart';

class HotspotWidget1 extends StatefulWidget {
  const HotspotWidget1({Key key}) : super(key: key);

  @override
  _HotspotWidget1State createState() => _HotspotWidget1State();
}

Future hotspot;
String townSelectedStore;

String mobileNumber;

class _HotspotWidget1State extends State<HotspotWidget1> {
  String apikey;

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
            hotspot = fetchHotSpot(townSelectedStore, mobileNumber, apikey);
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HotspotModel>(
        future: hotspot,
        builder: (BuildContext context, AsyncSnapshot<HotspotModel> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.result.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          child: Card(
                            elevation: 10,
                            child: Container(
                              width: SizeConfig.screenwidth,
                              height: SizeConfig.screenheight * .28,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Card(
                                    clipBehavior: Clip.hardEdge,
                                    child: Container(
                                      //padding: EdgeInsets.all(6),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data.result[index].coverImageUrl,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.fill,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .25,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .65,
                                        child: Wrap(
                                          children: [
                                            Text(
                                                snapshot.data.result[index]
                                                    .businessName,
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .safeBlockHorizontal *
                                                        4,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(snapshot.data.result[index]
                                                  .openingTime ??
                                              ''),
                                          Text('-'),
                                          Text(snapshot.data.result[index]
                                                  .closingTime ??
                                              ''),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_pin,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .55,
                                            // height: 20,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      snapshot
                                                          .data
                                                          .result[index]
                                                          .businessAddress,
                                                      softWrap: true,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: SizeConfig
                                                                  .safeBlockHorizontal *
                                                              4)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .50,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                20,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                style: BorderStyle.solid,
                                                width: 1.0,
                                              ),
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Center(
                                                  child: Text(
                                                    "Purchase Coupons",
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StorePageProduction(
                                        snapshot.data.result[index].businessId,
                                        townSelectedStore,
                                        snapshot
                                            .data.result[index].businessName,
                                      )),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(child: Text('Something went wrong...'));
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
