import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/constants/app_vectors.dart';
import 'package:matsapp/utilities/size_config.dart';

class Couponbackground extends StatefulWidget {
  final String couponType;
  final String couponLeft;
  Couponbackground(this.couponType, [this.couponLeft]);

  @override
  _CouponbackgroundState createState() => _CouponbackgroundState();
}

class _CouponbackgroundState extends State<Couponbackground> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidth = MediaQuery.of(context).size.width;
    if (widget.couponType.contains("Free")) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Free Coupon",
                  style:
                      AppTextStyle.homeCatsFont(color: AppColors.success_color),
                ),
                Text(
                  widget.couponLeft,
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2.2,
                      color: AppColors.lightGreyWhite),
                )
              ],
            ),
          ),
          Image.asset(
            'assets/images/freecouponBg.png',
            //  alignment: Alignment.center,
            // allowDrawingOutsideViewBox: true,
//paidcouponBg
            //colorBlendMode: BlendMode.srcIn,
            width: MediaQuery.of(context).size.width * .95,
            height: MediaQuery.of(context).size.height * .24,
            fit: BoxFit.fill,
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/paidcouponBg.png',
              //  alignment: Alignment.center,
              // allowDrawingOutsideViewBox: true,

              //colorBlendMode: BlendMode.srcIn,
              width: MediaQuery.of(context).size.width * .95,

              height: MediaQuery.of(context).size.height * .24,
              fit: BoxFit.fill,
            ),
          ],
        ),
      );
    }
  }
}
