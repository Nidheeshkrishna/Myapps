import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_vectors.dart';

class ProductCouponBground extends StatefulWidget {
  final String couponType;
  ProductCouponBground(this.couponType);
  @override
  _ProductCouponBgroundState createState() => _ProductCouponBgroundState();
}

class _ProductCouponBgroundState extends State<ProductCouponBground> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidth = MediaQuery.of(context).size.width;
    print("coupontype" + widget.couponType);
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8, bottom: 10),
              child: Text(
                widget.couponType.contains("Free")
                    ? "Free Coupon"
                    : "Flat Discount Coupon",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ],
        ),
        Image.asset(
          widget.couponType.contains("Free")
              ? "assets/images/freecouponBg.png"
              : 'assets/images/paidcouponBg.png',
          width: MediaQuery.of(context).size.width * .95,
          height: MediaQuery.of(context).size.height * .22,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
