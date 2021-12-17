import 'package:flutter/material.dart';
import 'package:matsapp/Pages/StorePage/StoreWidgets/OfferInthiStores/OfferCardStateless.dart';

class OffersViewAllpage extends StatefulWidget {
  final int businessId;
  final String mobileNumber;
  final String selectedTown;
  final String businessName;

  OffersViewAllpage(
      this.businessId, this.mobileNumber, this.selectedTown, this.businessName);
  @override
  _OffersViewAllpageState createState() => _OffersViewAllpageState();
}

class _OffersViewAllpageState extends State<OffersViewAllpage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;

    return Scaffold(
      appBar: AppBar(
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
        title: Align(
          alignment: Alignment.center,
          child: Text(widget.businessName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      body: Container(
          width: screenWidth,
          height: screenHeight,
          color: Colors.yellow[300],
          padding: EdgeInsets.all(6),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Offers In This Store ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                )),
                OfferCardStateless(widget.businessId, widget.mobileNumber,
                    widget.selectedTown),
              ],
            ),
          )),
    );
  }
}
