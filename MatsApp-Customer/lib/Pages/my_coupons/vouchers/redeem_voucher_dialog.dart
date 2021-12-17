import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:matsapp/Pages/_partials/tc_dialog.dart';
import 'package:matsapp/Pages/_views/success_dialog.dart';
import 'package:matsapp/Pages/coupon_generate/Coupon_BuyPage/coupon_dialogBground.dart';
import 'package:matsapp/Pages/my_coupons/_partials/voucher_item.dart';
import 'package:matsapp/Pages/my_coupons/bill_amount_page.dart';
import 'package:matsapp/Pages/my_coupons/shareCoupon.dart';
import 'package:matsapp/Pages/my_coupons/vouchers/bill_amount_page_Voucher.dart';
import 'package:matsapp/Pages/my_coupons/vouchers/shareVoucher.dart';
import 'package:matsapp/Pages/qr_scanner/qr_code_scanner.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/redux/actions/my_coupons/my_coupons_action.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/my_coupons/redeem_coupon_view_model.dart';
import 'package:matsapp/utilities/size_config.dart';

class RedeemDialogVoucher extends StatelessWidget {
  final bool isCoupon;

  const RedeemDialogVoucher({Key key, this.isCoupon = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int id;

    return StoreConnector<AppState, RedeemCouponViewModel>(
        converter: (store) => RedeemCouponViewModel.fromStore(store),
        // onDispose: (store) => store.dispatch(RedeemClearAction()),
        onWillChange: (old, viewModel) async {
          if (old.isLoading && viewModel.hasError) {
            final snackBar =
                SnackBar(content: Text(viewModel.loadingError ?? ""));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (!old.isRedeemed && viewModel.isRedeemed) {
            await showSuccessDialog(context);
            viewModel.onClear();
            Navigator.pop(context);
          }
        },
        builder: (context, viewModel) {
          return Container(
              width: SizeConfig.screenwidth * .98,
              height: SizeConfig.screenheight * .80,
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: <
                      Widget>[
                viewModel.voucher.shareFlag.isNotEmpty
                    ? viewModel.voucher.shareFlag.contains("true" ?? false)
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                    child: ImageIcon(
                                      AssetImage("assets/images/share.png"),
                                      color: Colors.grey,
                                      size: 25,
                                    ),
                                    onTap: () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShareVoucher(
                                                        viewModel.voucher
                                                            ?.userVoucherId,
                                                      )))
                                        }),

                                //  InkWell(
                                //     child: ImageIcon(
                                //       AssetImage("assets/images/share.png"),
                                //       color: Colors.grey,
                                //       size: 25,
                                //     ),
                                //     onTap: () => {
                                //           if (viewModel.coupon.type
                                //               .contains("Purchased"))
                                //             {id = 1}
                                //           else if (viewModel.coupon.type
                                //               .contains("Downloaded"))
                                //             {id = 1},
                                //           Navigator.push(
                                //               context,
                                //               MaterialPageRoute(
                                //                   builder: (context) => ShareCoupon(
                                //                       viewModel
                                //                           .voucher?.userVoucherId,
                                //                       viewModel
                                //                           .voucher?.userVoucherId,
                                //                       id)))
                                //         }),
                                IconButton(
                                    icon: Icon(
                                      Icons.cancel_outlined,
                                      color: AppColors.lightGreyWhite,
                                      size: 30,
                                    ),
                                    onPressed: () => Navigator.pop(context)),
                              ],
                            ),
                          )
                        : Container()
                    : Container(),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(children: [
                          Positioned.fill(
                              bottom: 10,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      isCoupon
                                          ? viewModel.coupon?.businessName ?? ''
                                          : viewModel.voucher?.businessName ??
                                              '',
                                      style: TextStyle(
                                        fontSize: 21,
                                        color: AppColors.danger_color,
                                        letterSpacing: 0.42,
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.underline,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 2),
                                    isCoupon
                                        ? Column(
                                            children: [
                                              Container(
                                                  width: SizeConfig.screenwidth,
                                                  height:
                                                      SizeConfig.screenheight *
                                                          .40,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: AppColors
                                                            .black_shadow_color,
                                                        offset: Offset(0, 3),
                                                        blurRadius: 6,
                                                      ),
                                                    ],
                                                  ),
                                                  // color: Colors.blueGrey,
                                                  child: Column(children: [
                                                    if (isCoupon)
                                                      CouponDialogBground(
                                                        coupon:
                                                            viewModel.coupon,
                                                        coupontype: viewModel
                                                            .coupon.status,
                                                      ),
                                                    //  CouponWidgetNew(coupon: viewModel.coupon)
                                                    // else
                                                    //   Padding(
                                                    //     padding: const EdgeInsets.only(
                                                    //         left: 8.0),
                                                    //     child: VoucherListItem(
                                                    //         voucher: viewModel.voucher),
                                                    //   ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        OutlinedButton(
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            minimumSize:
                                                                Size.square(50),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            side: BorderSide(
                                                                width: 2,
                                                                color: AppColors
                                                                    .kAccentColor),
                                                          ),
                                                          onPressed: () {},
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                'Minimum Purchase Amount',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        SizeConfig.textMultiplier *
                                                                            1.95),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Image.asset(
                                                                      "assets/images/rupee.png",
                                                                      color: AppColors
                                                                          .kAccentColor,
                                                                      width: 11,
                                                                      height:
                                                                          11),
                                                                  new Text(
                                                                    '${viewModel.coupon.purchaseLimit}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            SizeConfig.textMultiplier *
                                                                                1.95),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        OutlinedButton(
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            minimumSize:
                                                                Size.square(50),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            side: BorderSide(
                                                                width: 2,
                                                                color: AppColors
                                                                    .freecoupon_color),
                                                          ),
                                                          onPressed: () {},
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                'You save',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        SizeConfig.textMultiplier *
                                                                            1.95),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Image.asset(
                                                                      "assets/images/rupee.png",
                                                                      color: AppColors
                                                                          .kAccentColor,
                                                                      width: 11,
                                                                      height:
                                                                          11),
                                                                  new Text(
                                                                    '${viewModel.coupon.yourSavings}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            SizeConfig.textMultiplier *
                                                                                1.95),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )

                                                    // VoucherCodeWidget(
                                                    //     couponCode: isCoupon
                                                    //         ? viewModel.coupon?.couponId
                                                    //         : viewModel.voucher?.id),
                                                    // TextButton(
                                                    //     style: TextButton.styleFrom(
                                                    //         primary: AppColors
                                                    //             .info_color),
                                                    //     onPressed:
                                                    //         showTermsAndConditionsDialog(
                                                    //             context,
                                                    //             isCoupon
                                                    //                 ? viewModel.coupon
                                                    //                     ?.termsAndConditions
                                                    //                 : viewModel
                                                    //                     .voucher?.tc,
                                                    //             onCancel: isCoupon
                                                    //                 ? () {
                                                    //                     viewModel
                                                    //                         .onCancelCoupon();
                                                    //                   }
                                                    //                 : null),
                                                    //     child: Row(
                                                    //       mainAxisAlignment:
                                                    //           MainAxisAlignment.center,
                                                    //       children: <Widget>[
                                                    //         Text(
                                                    //             ' ${isCoupon ? 'Coupon' : 'Voucher'} Details',
                                                    //             style: TextStyle(
                                                    //                 fontSize: 17,
                                                    //                 fontWeight:
                                                    //                     FontWeight.w600,
                                                    //                 decoration:
                                                    //                     TextDecoration
                                                    //                         .underline),
                                                    //             textAlign:
                                                    //                 TextAlign.left),
                                                    //         Icon(Icons.chevron_right,
                                                    //             size: 17),
                                                    //         Icon(Icons.chevron_right,
                                                    //             size: 17),
                                                    //       ],
                                                    //     ))
                                                  ])),
                                            ],
                                          )
                                        : Center(
                                            child: Container(
                                              width: SizeConfig.screenwidth,
                                              height:
                                                  SizeConfig.screenheight * .40,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: VoucherListItem(
                                                        voucher:
                                                            viewModel.voucher),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              )),
                          Positioned(
                            bottom: 60,
                            right: 10,
                            left: 10,
                            child: VoucherCodeWidget(
                                couponCode: isCoupon
                                    ? viewModel.coupon?.userCouponId
                                    : viewModel.voucher?.userVoucherId),
                          ),
                          Positioned(
                              bottom: 10,
                              right: 90,
                              left: 90,
                              child: InkWell(
                                  onTap: () {
                                    scanQR(context, viewModel);
                                    // MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           BillAmountPage(viewModel.coupon.couponType,)),
                                    // isCoupon
                                    //     ? Navigator.popAndPushNamed(
                                    //         context, '/mycouponspage/redeem',
                                    //         result: false,
                                    //         arguments: BillAmountPage())
                                    //     : Navigator.popAndPushNamed(context,
                                    //         '/mycouponspage/redeem/Voucher',
                                    //         result: false,
                                    //         arguments: BillAmountPageVoucher());
                                  },
                                  child: Container(
                                      height: 46,
                                      width: 30,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          gradient: LinearGradient(
                                              begin: Alignment(-0.98, 0.0),
                                              end: Alignment(0.8, 0.0),
                                              colors: [
                                                const Color(0xfffd8e34),
                                                const Color(0xffffb11a)
                                              ],
                                              stops: [
                                                0.0,
                                                1.0
                                              ]),
                                          boxShadow: [
                                            BoxShadow(
                                                color: const Color(0x57ffac1e),
                                                offset: Offset(0, 3),
                                                blurRadius: 6)
                                          ]),
                                      child: Text('Redeem',
                                          //'Redeem ${isCoupon ? 'Coupon' : "Voucher"}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18,
                                            letterSpacing: 1.25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          )))))
                        ])))
              ]));
        });
  }

  void scanQR(BuildContext context, RedeemCouponViewModel viewModel) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return QRCodeScanner(
              onResult: (code) async {
                Navigator.pop(context);
                viewModel.onRedeem(code);
              },
            );
          },
          fullscreenDialog: true,
        ));
  }
}

class VoucherCodeWidget extends StatelessWidget {
  final String couponCode;

  const VoucherCodeWidget({Key key, this.couponCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 28),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CODE : ',
                style: TextStyle(
                  fontSize: 18,
                  color: const Color(0xff565656),
                  letterSpacing: 1.71,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '$couponCode',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.kAccentColor,
                  letterSpacing: 1.71,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
