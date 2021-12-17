import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/utilities/app_number_formatter.dart';

class ActiveCouponItem extends StatelessWidget {
  final int position;
  final CouponModel coupon;
  final String action;

  const ActiveCouponItem({
    Key key,
    @required this.position,
    @required this.coupon,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    double screenHight = MediaQuery.of(context).size.height;

    return Container(
      width: screenwidth,
      height: screenHight * .23,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: AppColors.black_shadow_color,
                offset: Offset(0, 3),
                blurRadius: 6)
          ]),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: screenHight * .10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              color: _getColor(position),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, top: 12, bottom: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  coupon?.logoUrl != null
                      ? Container(
                          width: screenwidth / 9,
                          height: screenHight * .1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              image: DecorationImage(
                                  image: NetworkImage(coupon?.logoUrl ?? ""))),
                        )
                      : Container(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: _getColor(position),
                          offset: Offset(0, 7),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: Text(
                      action ?? 'Redeem',
                      style: TextStyle(
                        fontSize: 12,
                        color: const Color(0xff4d4d4d),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 18.0, right: 10, top: 5, bottom: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Text(
                      coupon?.couponType == "Product"
                          ? coupon.productName ?? ""
                          : '${coupon?.businessName ?? ""}',
                      // '${coupon?.businessName ?? ""}',
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColors.kSecondaryDarkColor,
                        letterSpacing: 0.57,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 18.0, right: 10, top: 5, bottom: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Valid till ${coupon?.couponExpiryDate ?? ""}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.kSecondaryDarkColor,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      coupon?.couponFrom ?? "",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                Text(
                  '${AppNumberFormat(coupon?.matsappDiscount).percent}%',
                  style: TextStyle(
                    fontSize: 30,
                    color: _getColor(position),
                    letterSpacing: 1,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Color _getColor(int position) {
    int current = position % 4;
    switch (current) {
      case 0:
        return Color(0xffDF3138);
      case 1:
        return Color(0xff31B5DF);
      case 2:
        return Color(0xff0F1EA4);
      case 3:
        return Color(0xff0E9429);
      default:
        return kPrimaryColor;
    }
  }
}
