import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Modeles/ProductListModel.dart';
import 'package:matsapp/Network/ProductRepo.dart';
import 'package:matsapp/constants/app_colors.dart';

class DealsOtheDayProductdetailes extends StatefulWidget {
  final int productId;
  final String selectedTown;
  DealsOtheDayProductdetailes(this.productId, this.selectedTown);
  @override
  _DealsOtheDayProductdetailesState createState() =>
      _DealsOtheDayProductdetailesState();
}

class _DealsOtheDayProductdetailesState
    extends State<DealsOtheDayProductdetailes> {
  Future futureProduct;

  StreamController<ProductListModel> _userController;

  @override
  void initState() {
    super.initState();
    _userController = new StreamController();
    //Timer.periodic(Duration(seconds: 1), (_) => loadDetails());
    loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height -
    //MediaQuery.of(context).padding.top - -kToolbarHeight;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      //height: screenHeight * .60,
      child: StreamBuilder<ProductListModel>(
          stream: _userController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data.result.first.productImage,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width * .80,
                            height: MediaQuery.of(context).size.height * .30,
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
                              snapshot.data.result.first.name,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Theme.of(context).accentColor,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(12.0),
                                    side: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 2)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  new Text(
                                    "${snapshot.data.result.first.rating}",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.star,
                                      size: 20,
                                      color: Colors.orange[400],
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("MRP Rs ${snapshot.data.result.first.price}/-",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "Offer Price Rs ${snapshot.data.result.first.shopPrice}/-",
                              style: TextStyle(
                                  fontSize: 16,
                                  decoration:
                                      snapshot.data.result.first.offerPrice >
                                              0.0
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                  color: snapshot.data.result.first.offerPrice >
                                          0.0
                                      ? Colors.grey
                                      : Colors.black,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          snapshot.data.result.first.offerPrice > 0.0
                              ? Text(
                                  "Matsapp Price Rs ${snapshot.data.result.first.offerPrice}/-",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.mHomeGreen,
                                      fontWeight: FontWeight.bold))
                              : Container()
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(snapshot.data.result.first.description)
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
    fetchTopProduct(widget.productId, widget.selectedTown).then((res) async {
      //print('LoadDetails of ${res.fname}');
      _userController.add(res);
      // if (_isDisposed) {

      //   return res;
      // }
      return res;
    });
  }
}
