import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:matsapp/Modeles/TrendingOfferProductsModel.dart';

import 'package:matsapp/Network/TrendingOfferProductsRepo.dart';
import 'package:matsapp/Pages/StorePage/StorePageProduction.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/size_config.dart';

class TrendingProductdetailes extends StatefulWidget {
  final int productId;
  final String selectedTown;
  TrendingProductdetailes(this.productId, this.selectedTown);
  @override
  _TrendingProductdetailesState createState() =>
      _TrendingProductdetailesState();
}

class _TrendingProductdetailesState extends State<TrendingProductdetailes> {
  Future futureProduct;
  StreamController<TrendingOfferProductsModel> _userController;

  String townSelectedStore;

  double saveRupees;
  @override
  void initState() {
    super.initState();

    DatabaseHelper dbHelper = new DatabaseHelper();
    dbHelper.getAll().then((value) => {
          setState(() {
            townSelectedStore = value[0].selectedTown;
          }),

          // prefcheck(
          //     value[0].mobilenumber, value[0].selectedTown, value[0].apitoken),
          // // GeneralTools().prefsetLoginInfo(
          // //     ),
        });
    _userController = new StreamController();
    // Timer.periodic(Duration(seconds: 1), (_) => loadDetails());
    loadDetails();
    // setState(() {
    //   futureProduct =
    //       fetchStoreTrendingDeals(widget.productId, widget.selectedTown);
    // });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        -kToolbarHeight;
    double screenWidth = MediaQuery.of(context).size.width;
    loadDetails();
    return Container(
      width: screenWidth,
      //height: screenHeight * .60,
      child: StreamBuilder<TrendingOfferProductsModel>(
          stream: _userController.stream,
          builder: (context, snapshot) {
            // snapshot.data.result.price != null &&
            //         snapshot.data.result.offerPrice != null
            //     ? saveRupees =
            //         snapshot.data.result.price - snapshot.data.result.offerPrice
            //     : Container();
            if (snapshot.hasData) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data.result.productImage,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.contain,
                            width: screenWidth,
                            height: 200,
                            //height: screenHeight * .20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              snapshot.data.result.name,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                              height: screenHeight * .04,
                              width: screenWidth * .20,
                              // ignore: deprecated_member_use
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.all(2),
                                  minimumSize: Size.zero,
                                  fixedSize: Size.fromWidth(screenWidth * .1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)),
                                  side: BorderSide(
                                    color: AppColors.kAccentColor,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    new Text(
                                      '${snapshot.data.result.rating}',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 18,
                                      color: Colors.orange[400],
                                    )
                                  ],
                                ),
                                onPressed: () {},
                              )),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        snapshot.data.result.price != "0" &&
                                snapshot.data.result.price != null &&
                                snapshot.data.result.offerPrice == "0" &&
                                snapshot.data.result.offerPrice != null
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "MRP Rs ${snapshot.data.result.price}/-",
                                        style: TextStyle(
                                            //decoration: TextDecoration.lineThrough,
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "MRP Rs ${snapshot.data.result.price}/-",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 16,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                        snapshot.data.result.discount == null ||
                                snapshot.data.result.discount == 0
                            ? Container()
                            : Text("\r${snapshot.data.result.discount}%",
                                style: TextStyle(
                                    //decoration: TextDecoration.lineThrough,
                                    fontSize: 16,
                                    color: AppColors.success_color,
                                    fontWeight: FontWeight.bold))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        snapshot.data.result.offerPrice != "0" &&
                                snapshot.data.result.offerPrice != null
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "Offer Price Rs ${snapshot.data.result.offerPrice}/-",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              )
                            : Container(),
                        snapshot.data.result.saveAmount == "0" ||
                                snapshot.data.result.saveAmount == ""
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  // width: SizeConfig.screenwidth * .38,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.cyan[50],
                                      onPrimary: Colors.cyan[50],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          side: BorderSide(
                                              color: AppColors.success_color)),
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        new Text(
                                          " ${snapshot.data.result.saveAmount}",
                                          style: TextStyle(
                                            color: AppColors.success_color,
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    3.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data.result.description),
                          Container(
                              //padding: EdgeInsets.only(left: 10),
                              width: screenWidth,
                              alignment: Alignment.topLeft,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: AppColors.linkColor,
                                ),
                                child: Text("Go to store",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        wordSpacing: .1,
                                        decoration: TextDecoration.underline)),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            StorePageProduction(
                                              snapshot.data.result.businessId,
                                              townSelectedStore,
                                              snapshot.data.result.businessName,
                                            )),
                                  );
                                },
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }

  loadDetails() async {
    fetchStoreTrendingDeals(widget.productId, widget.selectedTown)
        .then((res) async {
      //print('LoadDetails of ${res.fname}');

      _userController.add(res);
      // if (_isDisposed) {

      //   return res;
      // }
      return res;
    });
  }
}
