import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Modeles/HotSpotModel.dart';

import 'package:matsapp/Network/HotSpotRest.dart';
import 'package:matsapp/Pages/StorePage/StorePageProduction.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/widgets/HotspotsWidgets/HotspoWidget1.dart';
import 'package:matsapp/widgets/HotspotsWidgets/HotsposTopAdWidget.dart';
import 'package:matsapp/widgets/HotspotsWidgets/HotspotSecondAd.dart';
import 'package:matsapp/widgets/HotspotsWidgets/HotspotWidget2.dart';

class HotspotViewAllWidget extends StatefulWidget {
  //final String town;
  //HotspotViewAllWidget(this.town);
  @override
  HotspotViewAllWidgetState createState() => HotspotViewAllWidgetState();
}

class HotspotViewAllWidgetState extends State<HotspotViewAllWidget> {
  Future hotspot;

  String townSelectedStore;

  String mobileNumber;

  var apikey;
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
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Exclusive Stores',
            style: TextStyle(fontSize: 15, color: Colors.grey[800]),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey[800],
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HotSpotAd1(),
              HotspotWidget1(),
              HotSpotAd2(),
              HotspotWidget2(),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ));
  }
}
