import 'package:flutter/material.dart';

import 'package:matsapp/Pages/DiscountsForYou/DiscountsForYouProduct/DiscoutForYouProductTabs.dart';
import 'package:matsapp/Pages/DiscountsForYou/DiscountsForYouProduct/DiscoutForYouProductdetailes.dart';

class DiscoutForYouProductPage extends StatefulWidget {
  final int productId;
  final int businessId;
  final String selectedtown;
  final String businessName;
  DiscoutForYouProductPage(
      this.productId, this.selectedtown, this.businessName, this.businessId);

  @override
  _DiscoutForYouProductPageState createState() =>
      _DiscoutForYouProductPageState();
}

class _DiscoutForYouProductPageState extends State<DiscoutForYouProductPage> {
  @override
  Widget build(BuildContext context) {
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

    return SafeArea(
      child: Scaffold(
        appBar: appbar,
        body: ListView(
          shrinkWrap: true,
          //addAutomaticKeepAlives: true,
          children: <Widget>[
            DiscoutForYouProductdetailes(widget.productId, widget.selectedtown),
            DiscoutForYouProductTabs(
                widget.productId, widget.selectedtown, widget.businessId)
          ],
        ),
      ),
    );
  }
}
