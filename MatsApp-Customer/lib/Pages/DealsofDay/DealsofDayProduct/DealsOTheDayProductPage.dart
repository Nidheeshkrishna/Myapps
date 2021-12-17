import 'package:flutter/material.dart';
import 'package:matsapp/Pages/DealsofDay/DealsofDayProduct/DealsOtheDayProductdetailes.dart';
import 'package:matsapp/Pages/DealsofDay/DealsofDayProduct/DelsofTheDayProductTabs.dart';

class DealsOTheDayProductPage extends StatefulWidget {
  final int productId;
  final int businessId;
  final String selectedtown;
  final String businessName;
  DealsOTheDayProductPage(
      this.productId, this.selectedtown, this.businessName, this.businessId);

  @override
  _DealsOTheDayProductPageState createState() =>
      _DealsOTheDayProductPageState();
}

class _DealsOTheDayProductPageState extends State<DealsOTheDayProductPage> {
  @override
  Widget build(BuildContext context) {
    //var isSelected = false;
    AppBar appbar = AppBar(
      backgroundColor: Colors.white,
      title: Text(
        widget.businessName,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.black,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    // double screenHeight = MediaQuery.of(context).size.height -
    //     MediaQuery.of(context).padding.top -
    //     appbar.preferredSize.height -
    //     kToolbarHeight;
    // double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: appbar,
        body: ListView(
          shrinkWrap: true,
          //addAutomaticKeepAlives: true,
          children: <Widget>[
            DealsOtheDayProductdetailes(widget.productId, widget.selectedtown),
            DelsofTheDayProductTabs(
                widget.productId, widget.selectedtown, widget.businessId),
          ],
        ),
      ),
    );
  }
}
