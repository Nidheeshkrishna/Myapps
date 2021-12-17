import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:matsapp/Modeles/TrendingOfferProductsModel.dart';

import 'package:matsapp/Network/TrendingOfferProductsRepo.dart';
import 'package:matsapp/Pages/coupon_generate/coupon_generateNew.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/size_config.dart';

// ignore: camel_case_types
class Trendingspecificationtab extends StatefulWidget {
  final int productId;

  final String selectedtown;
  Trendingspecificationtab(this.productId, this.selectedtown);
  @override
  _TrendingspecificationtabState createState() =>
      _TrendingspecificationtabState();
}

// ignore: camel_case_types
class _TrendingspecificationtabState extends State<Trendingspecificationtab> {
  Future futureProduct;
  @override
  void initState() {
    super.initState();
    setState(() {
      futureProduct =
          fetchStoreTrendingDeals(widget.productId, widget.selectedtown);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<TrendingOfferProductsModel>(
            future: futureProduct,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String content = snapshot.data.result.specification.toString();
                String cleanText = content.replaceAll('&nbsp;', ' ');
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SingleChildScrollView(child: Html(data: content)),
                      snapshot.data.result.couponId != "False"
                          ? Container(
                              width: SizeConfig.screenwidth * .40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.kAccentColor,
                                  onPrimary: AppColors.kAccentColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side: BorderSide(color: Colors.white)),
                                ),
                                onPressed: () {
                                  if (snapshot
                                          .data.result.couponAvailableFlag ==
                                      "true") {
                                    return Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CouponGeneratePageNew(
                                                    couponId: snapshot
                                                        .data.result.couponId,
                                                    type: "Store",
                                                    couponType: snapshot.data
                                                        .result.couponType)));
                                  } else {
                                    return GeneralTools().createSnackBarCommon(
                                        "Allready Purachased", context);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Text(
                                      'Get Coupon',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              3 * SizeConfig.textMultiplier),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
