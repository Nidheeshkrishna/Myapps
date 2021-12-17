import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/Network/Payment/paymentOrderIdRepo.dart';
import 'package:matsapp/Pages/HomePages/MainHomePage.dart';
import 'package:matsapp/Pages/PaymentPage/PayMentPage.dart';
import 'package:matsapp/Pages/PaymentPage/PaymentSuccesPage.dart';
import 'package:matsapp/Pages/_partials/app_loading_spinner.dart';
import 'package:matsapp/Pages/_partials/tc_dialog.dart';
import 'package:matsapp/Pages/my_coupons/_partials/coupon_widgetnew.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/redux/actions/common_actions.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/generate_coupon/generate_coupon_view_model.dart';
import 'package:matsapp/utilities/app_number_formatter.dart';
import 'package:matsapp/utilities/size_config.dart';

class CouponGeneratePageNew extends StatelessWidget {
  final String type;
  final String couponId;
  final String couponType;

  CouponGeneratePageNew({
    Key key,
    this.type,
    this.couponId,
    this.couponType,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int orderid1;
    //CouponModel coupon;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blueGrey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: _buildAppBar(),
      ),
      body: Builder(
        builder: (context) => StoreConnector<AppState, GenerateCouponViewModel>(
          onInitialBuild: (viewModel) => viewModel.initialise(couponId, type),
          converter: (store) => GenerateCouponViewModel.fromStore(store),
          onDispose: (store) =>
              store.dispatch(OnClearAction(type: "generatecoupon")),
          onDidChange: (old, viewModel) {
            if (old.isLoading && viewModel.hasError) {
              final snackBar =
                  SnackBar(content: Text(viewModel.loadingError ?? ""));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, _viewModel) {
            if (_viewModel.isLoading) return AppLoadingSpinner();

            return Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 18),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 16),
                      Container(
                          height: SizeConfig.screenheight * .50,
                          width: SizeConfig.screenwidth,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(12.0),
                          //   color: Colors.white,
                          //   boxShadow: [
                          //     BoxShadow(
                          //       color: AppColors.black_shadow_color,
                          //       offset: Offset(0, 3),
                          //       blurRadius: 6,
                          //     ),
                          //   ],
                          // ),
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 8, bottom: 10),
                                    //padding: const EdgeInsets.only(top: 0.0, left: 8, bottom: 10),
                                    child: Text(
                                      "Your Discount coupon",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                              CouponWidgetNew(
                                coupon: _viewModel.coupon,
                                coupontype: couponType,
                              ),
                            ],
                          )),

                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Coupon Price : ",
                                style: TextStyle(
                                    color: AppColors.lightGreyWhite,
                                    fontSize: 20)),
                            _viewModel.coupon.purchaseValue != null ||
                                    _viewModel.coupon.purchaseValue != 0.0
                                ? Row(
                                    children: [
                                      SizedBox(width: 2),
                                      Image.asset(
                                        "assets/images/rupee.png",
                                        color: AppColors.kAccentColor,
                                        width: 17,
                                        height: 17,
                                      ),
                                      Text(
                                        "${_viewModel.coupon.purchaseValue}",
                                        style: TextStyle(
                                            color: AppColors.kAccentColor,
                                            fontSize: 20),
                                      ),
                                    ],
                                  )
                                : Container()
                          ],
                        ),
                      ),

                      // CouponPurchase(
                      //   couponType: couponType,
                      //   coupon: _viewModel.coupon,
                      //   onMultiplierChanged: _viewModel.onMultiplierChanged,
                      //   multiplier: _viewModel.multiplier,
                      // ),
                      SizedBox(
                        height: 15,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              primary: AppColors.info_color),
                          onPressed: showTermsAndConditionsDialog(
                              context, _viewModel.coupon?.termsAndConditions),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Terms & Conditions',
                                  style: TextStyle(
                                      fontSize:
                                          4.5 * SizeConfig.widthMultiplier,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                      color: Colors.blueAccent),
                                  textAlign: TextAlign.left,
                                ),
                                Icon(Icons.chevron_right,
                                    size: 17, color: Colors.blueAccent),
                                Icon(Icons.chevron_right,
                                    size: 17, color: Colors.blueAccent)
                              ])),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () {
                              fetchOrderId(
                                _viewModel.coupon.couponId,
                                _viewModel.coupon.purchaseValue,
                                _viewModel.coupon.couponValue,
                                _viewModel.coupon.purchaseLimit,
                                _viewModel.coupon.couponType,
                                "1",
                              ).then((value) => {
                                    orderid1 = value.result.ucId,
                                    if (value.result.status.contains("Payment"))
                                      {
                                        if (_viewModel.coupon.purchaseValue !=
                                            null)
                                          {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PayMentPage(
                                                        orderid1,
                                                        _viewModel.coupon
                                                            .purchaseValue,
                                                        _viewModel.coupon
                                                            .businessName,
                                                        _viewModel
                                                            .coupon.businessId,
                                                      
                                                      )),
                                            ),
                                          }

                                        //  PayMentSuccesDialog()
                                        //       .alertDialogSuccess(context)
                                        //       .then((value) =>))
                                      }
                                    else if (value.result.status
                                        .contains("Success"))
                                      {
                                        PayMentSuccesDialog()
                                            .alertDialogSuccess(context)
                                            .then((value) =>
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MainHomePage()
                                                        // StorePageProduction(
                                                        //   viewModel.coupon
                                                        //       .businessId,
                                                        //   townSelectedStore,
                                                        //   viewModel.coupon
                                                        //       .businessName,
                                                        // )
                                                        ),
                                                    (route) => false))
                                        //Navigator.pop(context))
                                      }
                                  });
                            },
                            child: Container(
                              height: 46,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.freecoupon_color,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.freecoupon_color,
                                    offset: Offset(0, 2),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Text(
                                'Buy Coupon',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  letterSpacing: 0.62,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return StoreBuilder<AppState>(builder: (context, store) {
      return Text(
          store.state.generateCouponState?.coupon?.businessName ?? "Store",
          textAlign: TextAlign.center);
    });
  }
}

class CouponPurchase extends StatelessWidget {
  final String couponType;
  final CouponModel coupon;

  final ValueChanged<int> onMultiplierChanged;

  final int multiplier;

  const CouponPurchase({
    this.couponType,
    Key key,
    @required this.coupon,
    this.multiplier = 1,
    @required this.onMultiplierChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 230.0,
          child: Stack(
            children: [
              Positioned.fill(
                bottom: 23,
                child: Container(
                  height: 230.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black_shadow_color,
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 12),
                      Text(
                        coupon.couponType == "Product"
                            ? 'Coupon Value'
                            : 'Create Your coupon',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.lightGreyWhite,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      // Text.rich(
                      //   TextSpan(
                      //     style: TextStyle(
                      //       fontSize: 14,
                      //       color: AppColors.kAccentColor,
                      //     ),
                      //     children: [
                      //       TextSpan(
                      //         text: 'Purchase Limit : \n',
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //       TextSpan(
                      //         text:
                      //             'Rs ${AppNumberFormat(coupon?.purchaseLimit ?? 0).currency} /-',
                      //         style: TextStyle(
                      //           fontSize: 22,
                      //           fontWeight: FontWeight.w700,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     coupon?.couponType == "Business" &&
                      //             couponType == "Paid"
                      //         ? IconButton(
                      //             onPressed: () => multiplier > 1
                      //                 ? onMultiplierChanged(multiplier - 1)
                      //                 : null,
                      //             icon: Icon(
                      //               Icons.remove,
                      //               size: 24,
                      //             ),
                      //             disabledColor: Colors.grey.shade500,
                      //             color: AppColors.dar_hint_color,
                      //           )
                      //         : Container(),
                      //     Container(
                      //       width: 200,
                      //       margin: EdgeInsets.symmetric(horizontal: 12),
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(4.0),
                      //         color: Colors.white,
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color: AppColors.black_shadow_color,
                      //             offset: Offset(0, 3),
                      //             blurRadius: 6,
                      //           ),
                      //         ],
                      //       ),
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Text(
                      //           "Rs\r${AppNumberFormat(coupon?.couponValue ?? 0).currency} ",
                      //           style: TextStyle(
                      //             fontSize: 20,
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //           textAlign: TextAlign.center,
                      //         ),
                      //       ),
                      //     ),
                      //     coupon?.couponType == "Business" &&
                      //             couponType == "Paid"
                      //         ? IconButton(
                      //             onPressed: (coupon?.maximumDenomination ??
                      //                         0) >=
                      //                     ((coupon?.couponValue ?? 0) /
                      //                             multiplier) *
                      //                         (1 + multiplier)
                      //                 ? () =>
                      //                     onMultiplierChanged(multiplier + 1)
                      //                 : null,
                      //             color: AppColors.dar_hint_color,
                      //             disabledColor: Colors.grey.shade500,
                      //             icon: Icon(Icons.add, size: 24),
                      //           )
                      //         : Container(),
                      //   ],
                      // ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Coupon Price : ",
                                style: TextStyle(
                                    color: AppColors.lightGreyWhite,
                                    fontSize: 20)),
                            Text(
                              '${AppNumberFormat(coupon?.purchaseValue ?? 0).currency} /-',
                              style: TextStyle(
                                  color: AppColors.kAccentColor, fontSize: 20),
                            )
                          ],
                        ),
                      ),

                      // Text.rich(
                      //   TextSpan(
                      //     style: TextStyle(
                      //       fontSize: 14,
                      //       color: AppColors.kAccentColor,
                      //     ),
                      //     children: [
                      //       TextSpan(
                      //         text: 'Purchase Limit : \n',
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //       TextSpan(
                      //         text:
                      //             'Rs ${AppNumberFormat(coupon?.purchaseLimit ?? 0).currency} /-',
                      //         style: TextStyle(
                      //           fontSize: 22,
                      //           fontWeight: FontWeight.w700,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //     bottom: 0,
              //     right: 28,
              //     left: 28,
              //     top: 0,
              //     child: Container(
              //       height: 46,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(5.0),
              //         gradient: LinearGradient(
              //           begin: Alignment(-0.98, 0.0),
              //           end: Alignment(0.8, 0.0),
              //           colors: [const Color(0xfffd8e34), const Color(0xffffb11a)],
              //           stops: [0.0, 1.0],
              //         ),
              //         boxShadow: [
              //           BoxShadow(
              //             color: const Color(0x57ffac1e),
              //             offset: Offset(0, 3),
              //             blurRadius: 6,
              //           ),
              //         ],
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Text(
              //             'Purchase Value : ',
              //             style: TextStyle(
              //               fontSize: 14,
              //               color: Colors.white,
              //               fontWeight: FontWeight.w600,
              //             ),
              //             textAlign: TextAlign.center,
              //           ),
              //           Text(
              //             '${AppNumberFormat(coupon?.purchaseValue ?? 0).currency} /-',
              //             style: TextStyle(
              //               fontSize: 20,
              //               color: Colors.white,
              //               fontWeight: FontWeight.w700,
              //             ),
              //             textAlign: TextAlign.left,
              //           ),
              //         ],
              //       ),
              //
              //    )),
            ],
          ),
        ),
        SizedBox(height: 10),
        // Center(
        //   child: Container(
        //     width: SizeConfig.screenwidth,
        //     height: 50,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text("Minimum Purchase Amount ",
        //             style: TextStyle(
        //                 fontSize: 4 * SizeConfig.widthMultiplier,
        //                 color: Colors.grey[600])),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Text(
        //               "Coupon:",
        //               style: TextStyle(
        //                   fontSize: 4 * SizeConfig.widthMultiplier,
        //                   color: Colors.grey[600]),
        //             ),
        //             Text(
        //               "Rs ${coupon?.purchaseLimit}/-",
        //               style: TextStyle(
        //                   fontSize: 4 * SizeConfig.widthMultiplier,
        //                   fontWeight: FontWeight.bold,
        //                   color: Colors.grey[600]),
        //             )
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class HoleClipper extends CustomClipper<Path> {
  final double holeRadius;

  HoleClipper({
    this.holeRadius = 20,
  });

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, holeRadius)
      ..arcToPoint(
        Offset(holeRadius, 0),
        clockwise: false,
        radius: Radius.circular(holeRadius),
      )
      ..lineTo(size.width - holeRadius, 0.0)
      ..arcToPoint(
        Offset(
          size.width,
          holeRadius,
        ),
        clockwise: false,
        radius: Radius.circular(holeRadius),
      );

    var curXPos = size.width;
    var curYPos = holeRadius;
    var increment = size.height / 40;
    while (curYPos < size.height - holeRadius) {
      curYPos += increment / 2;
      path.lineTo(size.width, curYPos);
      curYPos += increment;
      path.arcToPoint(
        Offset(curXPos, curYPos),
        radius: Radius.circular(1),
        clockwise: false,
      );
      curYPos += increment / 2;
      path.lineTo(size.width, curYPos);
    }

    path.arcToPoint(
      Offset(size.width - holeRadius, size.height),
      clockwise: false,
      radius: Radius.circular(holeRadius),
    );
    path.lineTo(holeRadius, size.height);

    path.arcToPoint(
      Offset(0, size.height - holeRadius),
      clockwise: false,
      radius: Radius.circular(holeRadius),
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(HoleClipper oldClipper) => true;
}

class PurchaseCoupon extends StatelessWidget {
  final String couponType;
  final CouponModel coupon;

  final ValueChanged<int> onMultiplierChanged;

  final int multiplier;

  const PurchaseCoupon({
    this.couponType,
    Key key,
    @required this.coupon,
    this.multiplier = 1,
    @required this.onMultiplierChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 230.0,
          child: Stack(
            children: [
              Positioned.fill(
                bottom: 23,
                child: Container(
                  height: 230.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black_shadow_color,
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 12),
                      Text(
                        coupon.couponType == "Product"
                            ? 'Coupon Value'
                            : 'Create Your coupon',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.lightGreyWhite,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      // Text.rich(
                      //   TextSpan(
                      //     style: TextStyle(
                      //       fontSize: 14,
                      //       color: AppColors.kAccentColor,
                      //     ),
                      //     children: [
                      //       TextSpan(
                      //         text: 'Purchase Limit : \n',
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //       TextSpan(
                      //         text:
                      //             'Rs ${AppNumberFormat(coupon?.purchaseLimit ?? 0).currency} /-',
                      //         style: TextStyle(
                      //           fontSize: 22,
                      //           fontWeight: FontWeight.w700,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     coupon?.couponType == "Business" &&
                      //             couponType == "Paid"
                      //         ? IconButton(
                      //             onPressed: () => multiplier > 1
                      //                 ? onMultiplierChanged(multiplier - 1)
                      //                 : null,
                      //             icon: Icon(
                      //               Icons.remove,
                      //               size: 24,
                      //             ),
                      //             disabledColor: Colors.grey.shade500,
                      //             color: AppColors.dar_hint_color,
                      //           )
                      //         : Container(),
                      //     Container(
                      //       width: 200,
                      //       margin: EdgeInsets.symmetric(horizontal: 12),
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(4.0),
                      //         color: Colors.white,
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color: AppColors.black_shadow_color,
                      //             offset: Offset(0, 3),
                      //             blurRadius: 6,
                      //           ),
                      //         ],
                      //       ),
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Text(
                      //           "Rs\r${AppNumberFormat(coupon?.couponValue ?? 0).currency} ",
                      //           style: TextStyle(
                      //             fontSize: 20,
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //           textAlign: TextAlign.center,
                      //         ),
                      //       ),
                      //     ),
                      //     coupon?.couponType == "Business" &&
                      //             couponType == "Paid"
                      //         ? IconButton(
                      //             onPressed: (coupon?.maximumDenomination ??
                      //                         0) >=
                      //                     ((coupon?.couponValue ?? 0) /
                      //                             multiplier) *
                      //                         (1 + multiplier)
                      //                 ? () =>
                      //                     onMultiplierChanged(multiplier + 1)
                      //                 : null,
                      //             color: AppColors.dar_hint_color,
                      //             disabledColor: Colors.grey.shade500,
                      //             icon: Icon(Icons.add, size: 24),
                      //           )
                      //         : Container(),
                      //   ],
                      // ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Coupon Price : ",
                                style: TextStyle(
                                    color: AppColors.lightGreyWhite,
                                    fontSize: 20)),
                            Text(
                              "Rs ${AppNumberFormat(coupon?.purchaseValue ?? 0).currency} /-",
                              style: TextStyle(
                                  color: AppColors.kAccentColor, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      // Text.rich(
                      //   TextSpan(
                      //     style: TextStyle(
                      //       fontSize: 14,
                      //       color: AppColors.kAccentColor,
                      //     ),
                      //     children: [
                      //       TextSpan(
                      //         text: 'Purchase Limit : \n',
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //       TextSpan(
                      //         text:
                      //             'Rs ${AppNumberFormat(coupon?.purchaseLimit ?? 0).currency} /-',
                      //         style: TextStyle(
                      //           fontSize: 22,
                      //           fontWeight: FontWeight.w700,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //     bottom: 0,
              //     right: 28,
              //     left: 28,
              //     top: 0,
              //     child: Container(
              //       height: 46,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(5.0),
              //         gradient: LinearGradient(
              //           begin: Alignment(-0.98, 0.0),
              //           end: Alignment(0.8, 0.0),
              //           colors: [const Color(0xfffd8e34), const Color(0xffffb11a)],
              //           stops: [0.0, 1.0],
              //         ),
              //         boxShadow: [
              //           BoxShadow(
              //             color: const Color(0x57ffac1e),
              //             offset: Offset(0, 3),
              //             blurRadius: 6,
              //           ),
              //         ],
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Text(
              //             'Purchase Value : ',
              //             style: TextStyle(
              //               fontSize: 14,
              //               color: Colors.white,
              //               fontWeight: FontWeight.w600,
              //             ),
              //             textAlign: TextAlign.center,
              //           ),
              //           Text(
              //             '${AppNumberFormat(coupon?.purchaseValue ?? 0).currency} /-',
              //             style: TextStyle(
              //               fontSize: 20,
              //               color: Colors.white,
              //               fontWeight: FontWeight.w700,
              //             ),
              //             textAlign: TextAlign.left,
              //           ),
              //         ],
              //       ),
              //
              //    )),
            ],
          ),
        ),
        SizedBox(height: 10),
        // Center(
        //   child: Container(
        //     width: SizeConfig.screenwidth,
        //     height: 50,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text("Minimum Purchase Amount ",
        //             style: TextStyle(
        //                 fontSize: 4 * SizeConfig.widthMultiplier,
        //                 color: Colors.grey[600])),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Text(
        //               "Coupon:",
        //               style: TextStyle(
        //                   fontSize: 4 * SizeConfig.widthMultiplier,
        //                   color: Colors.grey[600]),
        //             ),
        //             Text(
        //               "Rs ${coupon?.purchaseLimit}/-",
        //               style: TextStyle(
        //                   fontSize: 4 * SizeConfig.widthMultiplier,
        //                   fontWeight: FontWeight.bold,
        //                   color: Colors.grey[600]),
        //             )
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
