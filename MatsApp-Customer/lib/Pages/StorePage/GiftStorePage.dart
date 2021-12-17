import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Modeles/Mallpage/MallPageModel.dart';
import 'package:matsapp/Network/MallPageRepo.dart';
import 'package:matsapp/Network/surpriceGift/SurpriceGiftRepo.dart';
import 'package:matsapp/Network/surpriceGift/SurpriseGiftModel.dart';
import 'package:matsapp/Pages/HomePages/MainHomePage.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/size_config.dart';

class GiftStorePage extends StatefulWidget {
  final businessName;
  final businessId;
  const GiftStorePage(this.businessName, this.businessId, {Key key})
      : super(key: key);

  @override
  _GiftStorePageState createState() => _GiftStorePageState();
}

class _GiftStorePageState extends State<GiftStorePage> {
  MaterialColor _color = Colors.green;
  MaterialColor _color2 = Colors.cyan;

  Future<SurpriseGiftModel> futureGetGift;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureGetGift = fetchSurpriceGift(
      widget.businessId,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: screenHeight,
      child: Dialog(
        clipBehavior: Clip.hardEdge,
        insetPadding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        elevation: 5,
        //backgroundColor: Colors.transparent,
        child: contentBox(context),
      ),
    );
  }

  contentBox(context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.black_shadow_color,
                offset: Offset(0, 4),
                blurRadius: 6,
              ),
            ],
          ),
          width: screenWidth,
          height: screenHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.cancel_rounded,
                        color: Colors.red,
                        size: 28,
                      ),
                      onPressed: () => Navigator.pop(context)),
                ],
              ),
              Container(
                width: screenWidth,
                height: screenHeight / 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      "Special Gift",
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockVertical * 3.5,
                          fontWeight: FontWeight.bold),
                    ))
                  ],
                ),
              ),
              FutureBuilder<SurpriseGiftModel>(
                  future: futureGetGift,
                  builder: (BuildContext context,
                      AsyncSnapshot<SurpriseGiftModel> snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Container(
                            //color: Colors.blueGrey,
                            width: screenWidth * .98,
                            height: screenHeight * .55,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  bottom: 12,
                                  left: 10,
                                  right: 10,
                                  child: Center(
                                    child: Container(
                                      width: screenWidth * .88,
                                      height: screenHeight * .33,
                                      //margin: EdgeInsets.only(top: 20),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blueGrey,
                                            blurRadius: 5.0,
                                            spreadRadius: 3.0,
                                            // offset: Offset(2.0,
                                            //     2.0), // shadow direction: bottom right
                                          )
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Text(
                                              snapshot.data.businessGiftData
                                                  .giftDescription,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal *
                                                      4),
                                            ),
                                            // SizedBox(
                                            //   height: 10,
                                            // ),
                                            SizedBox(
                                                height: screenHeight * .12,
                                                width: screenWidth * .75,
                                                child: giftList(context,
                                                    snapshot.data.levelData)),

                                            // giftList(
                                            //     context, snapshot.data.levelData)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: DottedBorder(
                                      child: Container(
                                        width: screenWidth * .50,
                                        height: screenHeight * .25,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: Colors.white,
                                        ),
                                        //margin: EdgeInsets.all(2),
                                        child: Column(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: snapshot.data
                                                  .businessGiftData.giftImage,
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Icon(Icons.image, size: 30),
                                              fit: BoxFit.fill,
                                              width: screenWidth * .20,
                                              height: screenHeight * .20,
                                            ),
                                            Text(snapshot
                                                .data.businessGiftData.giftName)
                                          ],
                                        ),
                                      ),
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(20),
                                      color: AppColors.kAccentColor,
                                      dashPattern: [10, 5, 10, 5, 10, 5],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              children: [
                                Container(
                                  width: screenWidth,
                                  // height: screenHeight * .30,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("T&C"),
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          // width: screenWidth,
                                          // height: screenHeight,
                                          // color: Colors.blue,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                snapshot.data.businessGiftData
                                                    .termsCondition,
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }),
            ],
          )),
    );
  }

  Widget giftList(BuildContext context, List<LevelDatum> levelData) {
    double screenHeightGift = MediaQuery.of(context).size.height;
    double screenWidthGift = MediaQuery.of(context).size.width;
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        //shrinkWrap: true,
        itemExtent: 86,
        scrollDirection: Axis.horizontal,
        itemCount: levelData.length,
        itemBuilder: (context, i) {
          return Container(
            width: screenWidthGift * .40,
            height: screenHeightGift * .20,
            //padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              //mainAxisSize: MainAxisSize.min,
              //mainAxisAlignment: MainAxisAlignment.end,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                levelData[i].levelName.contains("Silver")
                    ? silverWidget(context, levelData[i].levelImage,
                        levelData[i].levelName)
                    : Container(),
                levelData[i].levelName.contains("Gold")
                    ? goldWidget(context, levelData[i].levelImage,
                        levelData[i].levelName)
                    : Container(),
                levelData[i].levelName.contains("Diamond")
                    ? diamontWidget(context, levelData[i].levelImage,
                        levelData[i].levelName)
                    : Container(),
              ],
            ),
          );
        });
  }

  Widget silverWidget(
      BuildContext context, String levelImage, String levelName) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                  offset: Offset(1.0, 1.0), // shadow direction: bottom right
                )
              ],
            ),
            child: Container(
                margin: EdgeInsets.all(10),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(8.0),
                //   color: Colors.grey,
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.blueGrey,
                //       blurRadius: 2.0,
                //       spreadRadius: 0.0,
                //       offset: Offset(2.0, 2.0), // shadow direction: bottom right
                //     )
                //   ],
                // ),
                width: 50,
                height: 20,
                child: Image.network(levelImage)
                // child widget, replace with your own
                )),
        Text(levelName)
      ],
    );
  }

  Widget goldWidget(BuildContext context, String levelImage, String levelName) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.kAccentColor,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(1.0, 1.0), // shadow direction: bottom right
                )
              ],
            ),
            child: Container(
                margin: EdgeInsets.all(10),
                width: 50,
                height: 20,
                child: Image.network(levelImage)

                // child widget, replace with your own
                )),
        Text(levelName)
      ],
    );
  }

  Widget diamontWidget(
      BuildContext context, String levelImage, String levelName) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(1.0, 1.0), // shadow direction: bottom right
                )
              ],
            ),
            child: Container(
                margin: EdgeInsets.all(10),
                width: 50,
                height: 20,
                child: Image.network(levelImage)

                // child widget, replace with your own
                )),
        Text(
          levelName,
        )
      ],
    );
  }
}
