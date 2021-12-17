import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:matsapp/Pages/_partials/tc_dialog.dart';
import 'package:matsapp/Pages/_views/success_dialog.dart';
import 'package:matsapp/Pages/coupon_generate/Coupon_BuyPage/coupon_dialogBground.dart';
import 'package:matsapp/Pages/my_coupons/_partials/voucher_item.dart';
import 'package:matsapp/Pages/my_coupons/shareCoupon.dart';
import 'package:matsapp/Pages/my_coupons/vouchers/RedeemCouponDialogPreview.dart';
import 'package:matsapp/Pages/qr_scanner/qr_code_scanner.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/redux/actions/my_coupons/my_coupons_action.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/my_coupons/redeem_coupon_view_model.dart';
import 'package:matsapp/services/base_service.dart';
import 'package:matsapp/utilities/size_config.dart';

import 'bill_amount_page.dart';

class RedeemDialog extends StatelessWidget {
  final bool isCoupon;

  const RedeemDialog({Key key, this.isCoupon = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int id;
    return StoreConnector<AppState, RedeemCouponViewModel>(
        converter: (store) => RedeemCouponViewModel.fromStore(store),
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
        // onDispose: (store) => store.dispatch(RedeemClearAction()),
        builder: (context, viewModel) {
          return Container(
              width: SizeConfig.screenwidth * .98,
              height: SizeConfig.screenheight * .95,
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: <
                      Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      isCoupon
                          ? viewModel.coupon.shareFlag.isNotEmpty
                              ? viewModel.coupon.shareFlag
                                      .contains("true" ?? false)
                                  ? InkWell(
                                      child: ImageIcon(
                                        AssetImage("assets/images/share.png"),
                                        color: Colors.grey,
                                        size: 25,
                                      ),
                                      onTap: () => {
                                            if (viewModel.coupon.type
                                                .contains("Purchased"))
                                              {id = 1}
                                            else if (viewModel.coupon.type
                                                .contains("Downloaded"))
                                              {id = 1},
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ShareCoupon(
                                                            viewModel.coupon
                                                                ?.userCouponId,
                                                            viewModel.coupon
                                                                ?.couponType,
                                                            id)))
                                          })
                                  : Container()
                              : Container()
                          : Container(),

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
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: 15),
                            Text(
                              isCoupon
                                  ? viewModel.coupon?.businessName ?? ''
                                  : viewModel.voucher?.businessName ?? '',
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 6,
                                color: AppColors.danger_color,
                                letterSpacing: 0.42,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 18),
                            isCoupon
                                ? Column(
                                    children: [
                                      Container(
                                          width: SizeConfig.screenwidth,
                                          height: SizeConfig.screenheight * .50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
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
                                          child: Container(
                                            width: SizeConfig.screenwidth * .90,
                                            height:
                                                SizeConfig.screenheight * .50,
                                            child: Column(children: [
                                              if (isCoupon ?? true)
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CouponDialogBground(
                                                      coupon: viewModel.coupon,
                                                      coupontype: viewModel
                                                          .coupon.status,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              VoucherCodeWidget(
                                                  couponCode: isCoupon
                                                      ? viewModel
                                                          .coupon?.userCouponId
                                                      : viewModel.voucher
                                                          ?.userVoucherId),
                                              //  CouponWidgetNew(coupon: viewModel.coupon)
                                              // else
                                              //   Padding(
                                              //     padding: const EdgeInsets.only(
                                              //         left: 8.0),
                                              //     child: VoucherListItem(
                                              //         voucher: viewModel.voucher),
                                              //   ),

                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment
                                              //           .spaceAround,
                                              //   children: [
                                              //     OutlinedButton(
                                              //       style: OutlinedButton
                                              //           .styleFrom(
                                              //         minimumSize:
                                              //             Size.square(50),
                                              //         shape:
                                              //             RoundedRectangleBorder(
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(
                                              //                       10.0),
                                              //         ),
                                              //         side: BorderSide(
                                              //             width: 2,
                                              //             color: AppColors
                                              //                 .kAccentColor),
                                              //       ),
                                              //       onPressed: () {},
                                              //       child: Column(
                                              //         children: [
                                              //           Text(
                                              //             'Minimum Purchase Amount',
                                              //             style: TextStyle(
                                              //                 fontSize:
                                              //                     SizeConfig.textMultiplier *
                                              //                         1.95),
                                              //           ),
                                              //           Row(
                                              //             mainAxisAlignment:
                                              //                 MainAxisAlignment
                                              //                     .center,
                                              //             children: [
                                              //               Image.asset(
                                              //                   "assets/images/rupee.png",
                                              //                   color: AppColors
                                              //                       .kAccentColor,
                                              //                   width: 11,
                                              //                   height:
                                              //                       11),
                                              //               new Text(
                                              //                 '${viewModel.coupon.purchaseLimit}',
                                              //                 style: TextStyle(
                                              //                     fontSize:
                                              //                         SizeConfig.textMultiplier *
                                              //                             1.95),
                                              //               )
                                              //             ],
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //     OutlinedButton(
                                              //       style: OutlinedButton
                                              //           .styleFrom(
                                              //         minimumSize:
                                              //             Size.square(50),
                                              //         shape:
                                              //             RoundedRectangleBorder(
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(
                                              //                       8.0),
                                              //         ),
                                              //         side: BorderSide(
                                              //             width: 2,
                                              //             color: AppColors
                                              //                 .freecoupon_color),
                                              //       ),
                                              //       onPressed: () {},
                                              //       child: Column(
                                              //         children: [
                                              //           Text(
                                              //             'You save',
                                              //             style: TextStyle(
                                              //                 fontSize:
                                              //                     SizeConfig.textMultiplier *
                                              //                         1.95),
                                              //           ),
                                              //           Row(
                                              //             mainAxisAlignment:
                                              //                 MainAxisAlignment
                                              //                     .center,
                                              //             children: [
                                              //               Image.asset(
                                              //                   "assets/images/rupee.png",
                                              //                   color: AppColors
                                              //                       .kAccentColor,
                                              //                   width: 11,
                                              //                   height:
                                              //                       11),
                                              //               new Text(
                                              //                 '${viewModel.coupon.yourSavings}',
                                              //                 style: TextStyle(
                                              //                     fontSize:
                                              //                         SizeConfig.textMultiplier *
                                              //                             1.95),
                                              //               )
                                              //             ],
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //   ],
                                              // )

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
                                            ]),
                                          )),
                                    ],
                                  )
                                : Center(
                                    child: Container(
                                      width: SizeConfig.screenwidth,
                                      height: SizeConfig.screenheight * .60,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: VoucherListItem(
                                                voucher: viewModel.voucher),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                          onTap: () {
                            // MaterialPageRoute(
                            //       builder: (context) =>
                            //
                            //
                            //         BillAmountPage(viewModel.coupon.couponType,)),

                            scanQR(context, viewModel);
                            // isCoupon

                            //     ? Navigator.popAndPushNamed(
                            //         context, '/mycouponspage/redeem',
                            //         result: false,
                            //         arguments: BillAmountPage())
                            //     : Navigator.popAndPushNamed(context,
                            //         '/mycouponspage/redeem/Voucher',
                            //         result: false,
                            //         arguments: BillAmountPage());
                          },
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                height: SizeConfig.safeBlockHorizontal * 10,
                                width: SizeConfig.safeBlockVertical * 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
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
                                    ))),
                          ))
                    ]))
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
