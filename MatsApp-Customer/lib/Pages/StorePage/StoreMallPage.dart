import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matsapp/Modeles/Mallpage/MallPageModel.dart';
import 'package:matsapp/Network/MallPageRepo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Network/RatingModelRest.dart';
import '../../utilities/GerneralTools.dart';
import '../../widgets/Top9Stores/MallPageWidget.dart';

class MallPage extends StatefulWidget {
  final int businessId;

  //final String mobilenumber;

  final String mallName;

  MallPage(
    this.businessId,
    this.mallName,
    //this.mobilenumber,
  );
  @override
  _MallPageState createState() => _MallPageState();
}

class _MallPageState extends State<MallPage> {
  Future futureMallInfo;

  Position _currentPosition;

  double userLatitude;

  double userLogitude;

  var mobileNumber;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    setState(() {
      futureMallInfo = fetchMallInfo(
        widget.businessId,
      );
    });
  }

  @required
  //MallPage({this.descrrate, this.time, this.mallName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Container(
          child: Text(
            widget.mallName,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ProductPage()),
            // );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(4),
                child: FutureBuilder<MallPageModel>(
                    future: futureMallInfo,
                    builder: (BuildContext context,
                        AsyncSnapshot<MallPageModel> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.mallInfo.length,
                            physics: ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 5,
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data.mallInfo[index].coverImage,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data.mallInfo[index]
                                                .businessName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16),
                                          ),
                                          Container(
                                            height: 20,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: Colors.yellow[700]),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(3),
                                                  child: Text(
                                                    "${snapshot.data.mallInfo[index].rating}",
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(3),
                                                  child: Icon(
                                                    Icons.star,
                                                    size: 10,
                                                    color: Colors.orange,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${snapshot.data.mallInfo[index].openingTime}- ${snapshot.data.mallInfo[index].closingTime}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                color: Colors.yellow[600]),
                                            child: Container(
                                              padding: EdgeInsets.all(3),
                                              width: 118,
                                              height: 25,
                                              child: Center(
                                                child: Container(
                                                  padding: EdgeInsets.all(3),
                                                  child: Container(
                                                    child: Text(
                                                      'Free Home Delivery',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            child: Icon(
                                              Icons.location_on_sharp,
                                              color: Colors.yellow[600],
                                              size: 30,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                              width: 200,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      snapshot
                                                          .data
                                                          .mallInfo[index]
                                                          .address,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(6),
                                      child: Text(
                                        snapshot
                                            .data.mallInfo[index].description,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                mobileNumber = snapshot.data
                                                    .mallInfo[index].mobile;
                                              });
                                              launch("tel://mobileNumber");
                                            },
                                            child: Text('Call'),
                                            style: TextButton.styleFrom(
                                              primary: Colors.white,
                                              backgroundColor:
                                                  Colors.yellow[600],
                                              onSurface: Colors.grey,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: Text('Visit'),
                                            style: TextButton.styleFrom(
                                              primary: Colors.white,
                                              backgroundColor:
                                                  Colors.yellow[600],
                                              onSurface: Colors.grey,
                                            ),
                                          ),
                                          Container(
                                            child: TextButton(
                                              onPressed: () {
                                                showRating(context);
                                              },
                                              child: Text('Rating'),
                                              style: TextButton.styleFrom(
                                                primary: Colors.white,
                                                backgroundColor:
                                                    Colors.yellow[600],
                                                onSurface: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      } else {
                        return Container();
                      }
                    })),
            MallPageWidget(widget.businessId),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    //fetchdata();
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        userLatitude = position.latitude;
        userLogitude = position.longitude;
      });

      print('${position.latitude}');
      print('${position.longitude}');
      // print(' ${position.}');
    }).catchError((e) {
      print(e);
    });
  }

  showRating(BuildContext context) {
    int starCount;
    // Create button
    Widget okButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Theme.of(context).accentColor,
          elevation: 10,
          onPrimary: Colors.blue,
          shadowColor: Colors.red,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
              side: BorderSide(
                color: Theme.of(context).accentColor,
              ))),
      child: Text("OK"),
      onPressed: () {
        setRating("store", widget.businessId, mobileNumber, starCount).then(
            (value) => value.result == 1
                ? GeneralTools()
                    .createSnackBarCommon("Thanks Your Rating", context)
                : GeneralTools().createSnackBarCommon("Try Again", context));

        Navigator.of(context).pop(true);
      },
    );
    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Theme.of(context).accentColor,
          elevation: 10,
          onPrimary: Colors.blue,
          shadowColor: Colors.red,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
              side: BorderSide(
                color: Theme.of(context).accentColor,
              ))),
      child: Center(child: Text("Cancel")),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 30),
      title: Text("Store Rating"),
      content: RatingBar.builder(
        initialRating: 1,
        minRating: 1,

        allowHalfRating: false,
        itemCount: 5,

        //maxRating: ,
        //itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          print(rating);
          setState(() {
            starCount = rating.toInt();
          });
        },
      ),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
