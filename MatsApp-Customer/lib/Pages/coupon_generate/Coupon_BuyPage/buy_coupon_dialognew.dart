import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:matsapp/Network/Payment/paymentOrderIdRepo.dart';
import 'package:matsapp/Pages/HomePages/MainHomePage.dart';
import 'package:matsapp/Pages/PaymentPage/PayMentPage.dart';
import 'package:matsapp/Pages/PaymentPage/PaymentSuccesPage.dart';
import 'package:matsapp/Pages/_partials/tc_dialog.dart';
import 'package:matsapp/Pages/my_coupons/vouchers/RedeemCouponDialogPreview.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/generate_coupon/buy_coupon_view_model.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/PaymentSuccessDialog.dart';
import 'package:matsapp/utilities/size_config.dart';

class BuyCouponDialogNew extends StatefulWidget {
  @override
  _BuyCouponDialogNewState createState() => _BuyCouponDialogNewState();
}

class _BuyCouponDialogNewState extends State<BuyCouponDialogNew> {
  int orderid1;

  String townSelectedStore;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    dbHelper.getAll().then((value) => {
          setState(() {
            townSelectedStore = value[0].selectedTown;
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    double screewidth = MediaQuery.of(context).size.width;
    double screeHeight = MediaQuery.of(context).size.height;
    return StoreConnector<AppState, BuyCouponViewModel>(
      converter: (store) => BuyCouponViewModel.fromStore(store),
      builder: (context, viewModel) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.black_shadow_color,
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          width: SizeConfig.widthMultiplier * 100,
          height: screeHeight * .70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: Colors.grey,
                    size: 25,
                  ),
                  onPressed: () => Navigator.pop(context)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Container(
                        width: screewidth,
                        height: screeHeight * .45,
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 21),
                            Text(
                              "Your Discount Coupon" ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.lightGreyWhite,
                                letterSpacing: 0.42,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 14),
                            CouponDialogBgroundReedem(
                              coupon: viewModel.coupon,
                              coupontype: viewModel.coupon.status,
                            ),
                            // Container(
                            //   child: Column(
                            //     //crossAxisAlignment: CrossAxisAlignment.center,
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceEvenly,
                            //     children: [
                            //       // Row(
                            //       //   mainAxisAlignment: MainAxisAlignment.center,
                            //       //   children: [
                            //       //     Text("Minimum Purchase Amount:",
                            //       //         style: TextStyle(
                            //       //             fontSize: 13,
                            //       //             color: Colors.grey[600])),
                            //       //     Text(
                            //       //       "Rs ${viewModel.coupon?.purchaseLimit}/-",
                            //       //       style: TextStyle(
                            //       //           fontSize:
                            //       //               2.2 * SizeConfig.textMultiplier,
                            //       //           fontWeight: FontWeight.bold,
                            //       //           color: Colors.grey[600]),
                            //       //     ),
                            //       //   ],
                            //       // ),
                            //       // Row(
                            //       //   mainAxisAlignment: MainAxisAlignment.center,
                            //       //   children: [
                            //       //     Text(
                            //       //       "You Can Save Rs: ${viewModel.coupon.yourSavings}",
                            //       //       style: TextStyle(
                            //       //           fontSize:
                            //       //               2.2 * SizeConfig.textMultiplier,
                            //       //           fontWeight: FontWeight.bold,
                            //       //           color: AppColors.freecoupon_color),
                            //       //     )
                            //       //   ],
                            //       // )
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 140,
                        left: 50,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text("Coupon Price:",
                                    style: TextStyle(
                                        fontSize: 3 * SizeConfig.textMultiplier,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[500])),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Image.asset(
                                      "assets/images/rupee.png",
                                      color: AppColors.kAccentColor,
                                      width: 15,
                                      height: 15,
                                    ),
                                    Text("${viewModel.coupon.purchaseValue}",
                                        style: TextStyle(
                                            fontSize:
                                                3 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.kAccentColor)),
                                  ],
                                ),
                              ],
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                    primary: AppColors.info_color),
                                onPressed: showTermsAndConditionsDialog(context,
                                    viewModel.coupon?.termsAndConditions),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Coupon Details',
                                        style: TextStyle(
                                            fontSize: 4.5 *
                                                SizeConfig.widthMultiplier,
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.blueAccent),
                                        textAlign: TextAlign.left,
                                      ),
                                    ])),
                          ],
                        ),
                      ),
                      // : Positioned(
                      //     bottom: 60,
                      //     left: 100,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Text("Free Coupon",
                      //             style: TextStyle(
                      //                 fontSize:
                      //                     3 * SizeConfig.textMultiplier,
                      //                 fontWeight: FontWeight.bold,
                      //                 color: AppColors.kAccentColor)),
                      //       ],
                      //     )),
                      SizedBox(
                        height: 10,
                      ),
                      Positioned(
                        bottom: 20,
                        left: 70,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.freecoupon_color,
                            onPrimary: AppColors.freecoupon_color,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(
                                    color: AppColors.freecoupon_color)),
                          ),
                          child: Row(
                            children: [
                              new Text(
                                'Buy Coupon',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 3 * SizeConfig.textMultiplier),
                              ),
                            ],
                          ),
                          onPressed: () {
                            // viewModel.onBuy();
                            //PaymentProcess().payMentInit();
                            // razorpay = new Razorpay();

                            // razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                            //     handlerPaymentSuccess);
                            // razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                            //     handlerErrorFailure);
                            // razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                            //     handlerExternalWallet);

                            fetchOrderId(
                              viewModel.coupon.couponId,
                              viewModel.coupon.purchaseValue,
                              viewModel.coupon.couponValue,
                              viewModel.coupon.purchaseLimit,
                              viewModel.coupon.couponType,
                              "1",
                            ).then((value) => {
                                  orderid1 = value.result.ucId,
                                  if (value.result.status.contains("Payment"))
                                    {
                                      if (viewModel.coupon.purchaseValue !=
                                          null)
                                        {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PayMentPage(
                                                      orderid1,
                                                      viewModel
                                                          .coupon.purchaseValue,
                                                      viewModel
                                                          .coupon.businessName,
                                                      viewModel
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

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             PayMentHomePage(viewModel.coupon)));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDialog({String id}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogResponses(
          color: Colors.green[300],
          icon: Icons.check_circle,
          message: "Transaction\nSuccessfull",
          id: id,
        );
      },
    );
  }
}
