import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_vectors.dart';
import 'package:matsapp/utilities/app_number_formatter.dart';
import 'package:matsapp/utilities/size_config.dart';

class CouponWidget extends StatelessWidget {
  final CouponModel coupon;
  final Color overlayColor;

  const CouponWidget({Key key, this.coupon, this.overlayColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Center(
              child: coupon.status == "Free"
                  ? Image.asset('assets/images/freecouponBg.png')
                  : Image.asset('assets/images/paidcouponBg.png')),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 14),
            child: Row(
              children: [
                Container(
                  height: 148,
                  width: SizeConfig.widthMultiplier * 45,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      // Positioned.fill(
                      //   child: SvgPicture.string(
                      //     AppVectors.DiscountBgSvg,
                      //     color: overlayColor,
                      //     allowDrawingOutsideViewBox: true,
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      Positioned(
                          top: 0,
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: SizeConfig.heightMultiplier * 3.0,
                              left: SizeConfig.widthMultiplier * 2.5,
                            ),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${AppNumberFormat(coupon?.matsappDiscount).percent}%',
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      letterSpacing: 1.312,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    'Discount',
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      letterSpacing: 0.18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 2,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Valid till ${coupon?.couponExpiryDate ?? ''}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                          letterSpacing: 0.6,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 4.5),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: coupon.status == "Free"
                                              ? AppColors.freecoupon_color
                                              : AppColors.kAccentColor,
                                          borderRadius:
                                              BorderRadius.circular(2.94),
                                          border: Border.all(
                                              width: 0.5, color: Colors.white),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'Details',
                                            style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.white,
                                              letterSpacing: 0.72,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(16.0),
                          // color: Colors.white,
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: AppColors.black_shadow_color,
                          //     offset: Offset(0, 3),
                          //     // blurRadius: 16,
                          //   ),
                          // ],
                          ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Text(
                                        //   'Coupon Value ',
                                        //   style: TextStyle(
                                        //     fontSize: 12,
                                        //     color: Colors.black,
                                        //     letterSpacing: 0.9,
                                        //   ),
                                        //   textAlign: TextAlign.center,
                                        // ),
                                        //SizedBox(height: 8),
                                        // Text(
                                        //   'Rs.${AppNumberFormat(coupon?.couponValue ?? 0).currency}',
                                        //   style: TextStyle(
                                        //     fontSize: 16,
                                        //     color: Colors.black,
                                        //     letterSpacing: 2.1,
                                        //     fontWeight: FontWeight.w500,
                                        //   ),
                                        //   textAlign: TextAlign.center,
                                        // ),
                                        //SizedBox(height: 12),
                                        // Container(
                                        //   margin: EdgeInsets.symmetric(
                                        //       horizontal: 18),
                                        //   alignment: Alignment.center,
                                        //   decoration: BoxDecoration(
                                        //     borderRadius:
                                        //         BorderRadius.circular(2.94),
                                        //     border: Border.all(
                                        //         width: 0.5,
                                        //         color: AppColors.border_color),
                                        //   ),
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.all(4.0),
                                        //     child: Text(
                                        //       'Details',
                                        //       style: TextStyle(
                                        //         fontSize: 9,
                                        //         color: Colors.black,
                                        //         letterSpacing: 0.72,
                                        //       ),
                                        //       textAlign: TextAlign.center,
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 5),
                                          height: 65,
                                          width: 65,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(13.28),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  coupon?.logoUrl ?? ""),
                                              fit: BoxFit.cover,
                                            ),
                                            border: Border.all(
                                                width: 1.0,
                                                color: Colors.white),
                                          ),
                                          // child: Placeholder(),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 5),
                                          width:
                                              SizeConfig.widthMultiplier * 25,
                                          child: Text(
                                            'Rs.${AppNumberFormat(coupon?.couponValue ?? 0).currency}',
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              //letterSpacing: 2.1,
                                              fontWeight: FontWeight.w800,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Text(
                          //     "Valid till ${coupon?.couponExpiryDate ?? ''}",
                          //     style: TextStyle(
                          //       fontSize: 11,
                          //       color: AppColors.dar_hint_color,
                          //       letterSpacing: 0.6,
                          //     ),
                          //     textAlign: TextAlign.center,
                          //   ),
                          // ),
                        ],
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
