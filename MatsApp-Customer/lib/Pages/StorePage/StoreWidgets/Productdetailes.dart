import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Modeles/ProductListModel.dart';
import 'package:matsapp/Network/ProductListRepo.dart';
import 'package:matsapp/Pages/Providers/Homeprovider.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/size_config.dart';

import '../StorePageProduction.dart';

class Productdetailes extends StatefulWidget {
  final int productId;
  final String selectedTown;

  Productdetailes(this.productId, this.selectedTown);
  @override
  _ProductdetailesState createState() => _ProductdetailesState();
}

class _ProductdetailesState extends State<Productdetailes> {
  Future futureProduct;
  StreamController<ProductListModel> _userController;
  String townSelectedStore;

  Future<int> userId;

  PostDataProvider postMdl;
  @override
  void initState() {
    DatabaseHelper dbHelper = new DatabaseHelper();
    dbHelper.getAll().then((value) => {
          setState(() {
            townSelectedStore = value[0].selectedTown;
          }),

          // prefcheck(
          //     value[0].mobilenumber, value[0].location, value[0].apitoken),
          // // GeneralTools().prefsetLoginInfo(
          // //     ),
        });
    super.initState();
//getPostDataExclusiveDeals(context)
    _userController = new StreamController();
    //Timer.periodic(Duration(seconds: 1), (_) => loadDetails());
    loadDetails();
    // setState(() {
    //   futureProduct = fetchTopProduct(widget.productId, widget.selectedTown);
    // });
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   postMdl = Provider.of<PostDataProvider>(context, listen: false);
    //   postMdl.getPostDataExclusiveDeals(context);

    //   // if (loginstatus != null) {
    //   //   if (loginstatus) { dialogesnew(context);}

    //   // }
    // });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        -kToolbarHeight;
    double screenWidth = MediaQuery.of(context).size.width;
    // loadDetails();
    return Container(
      width: screenWidth,
      //height: screenHeight * .60,
      child: StreamBuilder<ProductListModel>(
          stream: _userController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //var item = snapshot.data.result.first;
              // return ListView.builder(
              //     itemCount: snapshot.data.result.length,
              //     itemBuilder: (BuildContext context, int index) {
              return Container(
                width: screenWidth,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data.result.first.productImage,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: screenWidth * .80,
                            //height: screenHeight * .10,
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              snapshot.data.result.first.name,
                              softWrap: true,
                              // overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                              height: screenHeight * .04,
                              width: screenWidth * .15,
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
                                      '${snapshot.data.result.first.rating}',
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
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          snapshot.data.result.first.price != 0 &&
                                  snapshot.data.result.first.shopPrice == 0
                              ? Text(
                                  "MRP Rs ${snapshot.data.result.first.price}/-",
                                  style: TextStyle(
                                      //decoration: TextDecoration.lineThrough,
                                      fontSize:
                                          2.75 * SizeConfig.textMultiplier,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                              : Text(
                                  "MRP Rs ${snapshot.data.result.first.price}/-",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 2 * SizeConfig.textMultiplier,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          snapshot.data.result.first.shopPrice != 0 &&
                                  snapshot.data.result.first.offerPrice == 0
                              ? Text(
                                  "Offer Price Rs ${snapshot.data.result.first.shopPrice}/-",
                                  style: TextStyle(
                                      fontSize:
                                          2.75 * SizeConfig.textMultiplier,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                              : Text(
                                  "Offer Price Rs ${snapshot.data.result.first.shopPrice}/-",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 2 * SizeConfig.textMultiplier,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          snapshot.data.result.first.offerPrice == 0
                              ? Container()
                              : Text(
                                  "Matsapp price ${snapshot.data.result.first.offerPrice}/-",
                                  style: TextStyle(
                                      fontSize:
                                          2.75 * SizeConfig.textMultiplier,
                                      color: AppColors.mHomeGreen,
                                      fontWeight: FontWeight.bold))
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
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10),
                        width: screenWidth,
                        alignment: Alignment.centerLeft,
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
                                  builder: (context) => StorePageProduction(
                                        snapshot.data.result.first.businessId,
                                        townSelectedStore,
                                        snapshot.data.result.first.businessName,
                                      )),
                            );
                          },
                        )),
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
    userId = userData().getUserId();
    fetchTopProductList(widget.productId, townSelectedStore).then((res) async {
      //print('LoadDetails of ${res.fname}');

      _userController.add(res);
      // if (_isDisposed) {

      //   return res;
      // }
      return res;
    });
  }
}
