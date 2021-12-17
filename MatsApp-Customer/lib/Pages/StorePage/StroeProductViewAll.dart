import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Modeles/GetStoredetailesModel.dart';

class StorePageProductListWidget extends StatefulWidget {
  final GetStoredetailesModel getStoredetailesModel;
  StorePageProductListWidget(this.getStoredetailesModel);
  @override
  _StorePageProductListWidgetState createState() =>
      _StorePageProductListWidgetState();
}

class _StorePageProductListWidgetState
    extends State<StorePageProductListWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
          //width: screenWidth,
          //height: screenHeight,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/theme.png"),
            fit: BoxFit.cover,
          )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("Offers In This Store ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 10,
                            onPrimary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            )),
                        child: Text(
                          "View All",
                          style: TextStyle(color: Colors.indigo[700]),
                        ),
                        onPressed: () {},
                        //color: Colors.white,
                      ),
                    )
                  ],
                ),
                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      //height: screenHeight * .90,
                      //width: screenWidth,
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount:
                            widget.getStoredetailesModel.productoffers.length,
                        physics: ClampingScrollPhysics(),
                        //primary: true,
                        //physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          //crossAxisSpacing: ,
                          childAspectRatio:
                              MediaQuery.of(context).size.height / 800,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            child: Card(
                                elevation: 5,
                                //clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CachedNetworkImage(
                                        imageUrl: widget.getStoredetailesModel
                                            .productoffers[index].productImage,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            widget
                                                .getStoredetailesModel
                                                .productoffers[index]
                                                .productName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Container(
                                            width: 60,
                                            height: 20,
                                            child: OutlineButton(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    new Text(
                                                      '${widget.getStoredetailesModel.productoffers[index].rating}',
                                                      style: TextStyle(
                                                          fontSize: 11),
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      size: 12,
                                                      color: Colors.orange[400],
                                                    )
                                                  ],
                                                ),
                                                onPressed: () {},
                                                borderSide: BorderSide(
                                                    color: Colors.orange[400]),
                                                shape:
                                                    new RoundedRectangleBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                    .circular(
                                                                8.0))),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Price:${widget.getStoredetailesModel.productoffers[index].productPrice}/-',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/storeproductpage');
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  final List<Map<String, Object>> dummyData = [
    {
      'id': '1',
      'Name': 'JBL Box Media',
      'image_url': 'assets/images/jblsp.png',
    },
    {
      'id': '2',
      'Name': 'Watch',
      'image_url': 'assets/images/applewatch.jpg',
    },
    {
      'id': '3',
      'Name': 'Combo Offer',
      'image_url': 'assets/PRODUCT/BluetoothSpeaker.jpeg'
    },
    {
      'id': '4',
      'Name': 'Sony Cybershot',
      'image_url': 'assets/images/sonycybershot.jpeg'
    },
    {'id': '5', 'Name': 'Watch', 'image_url': 'assets/images/mangobake.jpg'},
    {'id': '6', 'Name': 'Watch', 'image_url': 'assets/images/R-c.jpg'},
    {
      'id': '7',
      'Name': 'Headset',
      'image_url': 'assets/PRODUCT/headphones.jpeg'
    },
    {
      'id': '8',
      'Name': 'Oven',
      'image_url': 'assets/images/microvWaveOven.jpg'
    },
    {'id': '9', 'Name': 'Watch', 'image_url': 'assets/PRODUCT/watch.jpeg'},
  ];
}
