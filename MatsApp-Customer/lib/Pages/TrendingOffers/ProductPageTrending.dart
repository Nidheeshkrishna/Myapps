import 'package:flutter/material.dart';
import 'package:matsapp/Pages/TrendingOffers/TrendingProduct/TrendingProductTabs.dart';
import 'package:matsapp/Pages/TrendingOffers/TrendingProduct/TrendingProductdetailes.dart';

class ProductPageTrending extends StatefulWidget {
  final int productId;
  final int businessId;
  final String selectedtown;
  final String businessName;
  //final String businessName1;
  ProductPageTrending(
      this.productId, this.selectedtown, this.businessName, this.businessId, [String name]);

  @override
  _ProductPageTrendingState createState() => _ProductPageTrendingState();
}

class _ProductPageTrendingState extends State<ProductPageTrending> {
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
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appbar.preferredSize.height -
        kToolbarHeight;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: appbar,
        body: ListView(
          shrinkWrap: true,
          //addAutomaticKeepAlives: true,
          children: <Widget>[
            TrendingProductdetailes(widget.productId, widget.selectedtown),
            TrendingProductTabs(
                widget.productId, widget.selectedtown, widget.productId)
          ],
        ),
      ),
    );
  }
}
