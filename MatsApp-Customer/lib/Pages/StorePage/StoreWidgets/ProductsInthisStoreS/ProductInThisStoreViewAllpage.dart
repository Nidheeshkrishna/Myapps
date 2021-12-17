import 'package:flutter/material.dart';
import 'package:matsapp/Pages/StorePage/StoreWidgets/ProductsInthisStoreS/ProductCardViewAll.dart';

class ProductInThisStoreViewAllpage extends StatefulWidget {
  final int businessId;
  final String mobileNumber;
  final String selectedTown;
  final String businessname;

  ProductInThisStoreViewAllpage(
      this.businessId, this.mobileNumber, this.selectedTown, this.businessname);
  @override
  _ProductInThisStoreViewAllpageState createState() =>
      _ProductInThisStoreViewAllpageState();
}

class _ProductInThisStoreViewAllpageState
    extends State<ProductInThisStoreViewAllpage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.businessname,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        // actions: [
        //   Container(
        //     margin: EdgeInsets.all(15),
        //     child: Row(
        //       children: [
        //         Icon(
        //           Icons.share,
        //           color: Colors.black,
        //         ),
        //       ],
        //     ),
        //   ),
        // ],
      ),
      body: Container(
          width: screenWidth,
          height: screenHeight,
          color: Colors.yellow[300],
          padding: EdgeInsets.all(6),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Products in This Store",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
                ProductCardViewAll(widget.businessId, widget.mobileNumber,
                    widget.selectedTown, widget.businessname),
              ],
            ),
          )),
    );
  }
}
