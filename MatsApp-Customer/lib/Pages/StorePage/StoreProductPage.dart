import 'package:flutter/material.dart';
import 'package:matsapp/Pages/StorePage/StoreWidgets/Productdetailes.dart';
import 'package:matsapp/Pages/StorePage/StoresPageTabs/storpageProductTabs.dart';

class StoreProductPage extends StatefulWidget {
  final int productId;
  final int businessId;
  final String productname;
  final String selectedtown;
  final String businessName;

  //final String itemtype;
  StoreProductPage(this.productId, this.selectedtown, this.productname,
      this.businessId, this.businessName);

  @override
  _StoreProductPageState createState() => _StoreProductPageState();
}

class _StoreProductPageState extends State<StoreProductPage> {
  bool purchaseLimitVisibility;
  @override
  Widget build(BuildContext context) {
    // var isSelected = false;
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
            Productdetailes(widget.productId, widget.selectedtown),
            StorpageProductTabs(
                widget.productId, widget.selectedtown, widget.businessId)
          ],
        ),
      ),
    );
  }
}
