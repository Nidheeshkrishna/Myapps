import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matsapp/Modeles/LuckyDrawModels/luckyDrawModel.dart';
import 'package:matsapp/Network/LuckyDrawRest/luckyDrawRepo.dart';
import 'package:matsapp/Pages/_views/empty_view.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/DetailesDialog.dart';
import 'package:matsapp/utilities/dotted_Line.dart';
import 'package:matsapp/utilities/size_config.dart';

class LuckyDrawPage extends StatefulWidget {
  const LuckyDrawPage({Key key}) : super(key: key);

  @override
  State<LuckyDrawPage> createState() => _LuckyDrawPageState();
}

class _LuckyDrawPageState extends State<LuckyDrawPage> {
  Future getLuckyDrowTickets;
  @override
  void initState() {
    fetchTickets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey[800],
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Lucky Draw Tickets',
            style: TextStyle(color: Colors.grey[800], fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: fetchTickets,
          child: FutureBuilder<LuckyDrawModel>(
              future: fetchLuckyDrawTickets(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      width: SizeConfig.screenwidth,
                      height: SizeConfig.screenheight * 100,
                      child: ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: [
                          Container(
                            color: AppColors.kAccentColor,
                            width: SizeConfig.screenwidth,
                            height: SizeConfig.screenheight / 13,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Received Tickets:\r\r" +
                                            snapshot.data.result2.ticketCount,
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    3.5,
                                            letterSpacing: .75,
                                            color: Colors.purple[600],
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                          "Won Tickets:\r\r" +
                                              snapshot
                                                  .data.result2.wonTicketCount,
                                          style: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.5,
                                              letterSpacing: .75,
                                              color: Colors.purple[600],
                                              fontWeight: FontWeight.w800)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          snapshot.data.result1.length != 0
                              ? ListView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.result1.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 15),
                                      width: SizeConfig.screenwidth * .80,
                                      height: SizeConfig.screenheight * .30,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: <Widget>[
                                              Container(
                                                child: Image.asset(
                                                    "assets/images/luckydrawticket.png"),
                                                decoration: new BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(.5),
                                                      blurRadius:
                                                          20.0, // soften the shadow
                                                      spreadRadius:
                                                          0.0, //extend the shadow
                                                      offset: Offset(
                                                        5.0, // Move to right 10  horizontally
                                                        5.0, // Move to bottom 10 Vertically
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                width: SizeConfig.screenwidth *
                                                    .90,
                                                height:
                                                    SizeConfig.screenheight *
                                                        .30,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            CachedNetworkImage(
                                                              imageUrl: snapshot
                                                                  .data
                                                                  .result1[
                                                                      index]
                                                                  .logoUrl,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  Container(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          new CircularProgressIndicator()),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  new Icon(Icons
                                                                      .image_sharp),
                                                              width: SizeConfig
                                                                      .screenwidth /
                                                                  4,
                                                              height: SizeConfig
                                                                      .screenheight *
                                                                  .18,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width: SizeConfig
                                                                      .screenwidth *
                                                                  .50,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    snapshot
                                                                            .data
                                                                            .result1[index]
                                                                            .title ??
                                                                        "",
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            SizeConfig.blockSizeVertical *
                                                                                2.8,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: SizeConfig
                                                                        .screenheight /
                                                                    58),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          17.0),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      snapshot
                                                                          .data
                                                                          .result1[
                                                                              index]
                                                                          .userMobile,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            SizeConfig.blockSizeVertical *
                                                                                2.5,
                                                                      )),
                                                                  SizedBox(
                                                                      width: SizeConfig
                                                                              .screenwidth /
                                                                          15),
                                                                  Text(
                                                                      snapshot
                                                                          .data
                                                                          .result1[
                                                                              index]
                                                                          .assignedDate,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            SizeConfig.blockSizeVertical *
                                                                                2.5,
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: SizeConfig
                                                                        .screenheight /
                                                                    55),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10),
                                                              child: Container(
                                                                  width: SizeConfig
                                                                          .screenwidth *
                                                                      .45,
                                                                  child: MySeparator(
                                                                      color: Colors
                                                                          .black)),
                                                            ),
                                                            SizedBox(
                                                                height: SizeConfig
                                                                        .screenheight /
                                                                    55),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  snapshot
                                                                      .data
                                                                      .result1[
                                                                          index]
                                                                      .ticketNo,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          SizeConfig.blockSizeVertical *
                                                                              2.8,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                // width: SizeConfig.screenwidth,
                                                // height:
                                                //     SizeConfig.screenheight * .18,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    snapshot.data.result1[index]
                                                                .status ==
                                                            "WON"
                                                        ? ClipRect(
                                                            child: Container(
                                                              height: 150,
                                                              width: 200,
                                                              child: Banner(
                                                                textStyle: TextStyle(
                                                                    shadows: [
                                                                      Shadow(
                                                                        color: Colors
                                                                            .blue,
                                                                        blurRadius:
                                                                            10.0,
                                                                        offset: Offset(
                                                                            5.0,
                                                                            5.0),
                                                                      ),
                                                                      Shadow(
                                                                        color: Colors
                                                                            .red,
                                                                        blurRadius:
                                                                            10.0,
                                                                        offset: Offset(
                                                                            -5.0,
                                                                            5.0),
                                                                      ),
                                                                    ],
                                                                    wordSpacing:
                                                                        .75,
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .yellow),
                                                                message:
                                                                    "Yₒᵤ Wₒₙ",
                                                                location:
                                                                    BannerLocation
                                                                        .topEnd,
                                                                color: Colors
                                                                    .purple,
                                                              ),
                                                            ),
                                                          )
                                                        : Container()
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                left: SizeConfig.screenwidth *
                                                    .80,
                                                bottom:
                                                    SizeConfig.screenheight /
                                                        25,
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.info,
                                                    color:
                                                        AppColors.kAccentColor,
                                                    size: 30,
                                                  ),
                                                  onPressed: () {
                                                    print(snapshot
                                                        .data
                                                        .result1[index]
                                                        .description);
                                                    Dialoges()
                                                        .detaiesDialogSuccess(
                                                            context,
                                                            snapshot
                                                                .data
                                                                .result1[index]
                                                                .description);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                              : Center(
                                  child: Container(
                                  width: SizeConfig.screenwidth,
                                  height: SizeConfig.screenheight,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      EmptyView(
                                          title: "No Tickets to show",
                                          message: ""),
                                    ],
                                  ),
                                )),
                        ],
                      ));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                      child: SpinKitHourGlass(color: Color(0xffFFB517)));
                } else if (snapshot.hasError) {
                  return Container();
                } else {
                  return EmptyView(title: "No Tickets to show", message: "");
                }
              }),
        ));
  }

  Future fetchTickets() async {
    getLuckyDrowTickets = fetchLuckyDrawTickets();
  }
}
