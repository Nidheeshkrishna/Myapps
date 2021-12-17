import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matsapp/Pages/StorePage/StoreInfoAlert.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_vectors.dart';

class CouponbackgroundGenerated extends StatefulWidget {
  final String couponType;
  final String couponContent;
  CouponbackgroundGenerated([this.couponType, this.couponContent]);

  @override
  _CouponbackgroundState createState() => _CouponbackgroundState();
}

class _CouponbackgroundState extends State<CouponbackgroundGenerated> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidth = MediaQuery.of(context).size.width;
    if (widget.couponType != null) if (widget.couponType.contains("Paid")) {
      return Column(
        children: [
          Image.asset(
            'assets/images/paidcouponBg.png',
            //  alignment: Alignment.center,
            // allowDrawingOutsideViewBox: true,

            //colorBlendMode: BlendMode.srcIn,
            // width: MediaQuery.of(context).size.width * .95,

            // height: MediaQuery.of(context).size.height * .22,
            fit: BoxFit.fill,
          ),
        ],
      );
    } else if (widget.couponType.contains("Free")) {
      return Column(
        children: [
            Image.asset(
            'assets/images/freecouponBg.png',
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
            
          //     IconButton(
          //       onPressed: () {
          //         Dialoges().couponInfoAlert(context, 'Content');
          //       },
          //       icon: Icon(Icons.info_rounded),
          //       alignment: Alignment.centerRight,
          //     )
          //   ],
          // ),
        
            //  alignment: Alignment.center,
            // allowDrawingOutsideViewBox: true,

            //colorBlendMode: BlendMode.srcIn,
            // width: MediaQuery.of(context).size.width * .95,
            // height: MediaQuery.of(context).size.height * .22,
            fit: BoxFit.fill,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Image.asset(
            'assets/images/paidcouponBg.png',
            fit: BoxFit.fill,
          ),
        ],
      );
    }
  }
}
