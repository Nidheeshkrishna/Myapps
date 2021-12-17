import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:matsapp/Pages/_partials/tc_dialog.dart';
import 'package:matsapp/Pages/my_coupons/_partials/coupon_widget.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/generate_coupon/buy_coupon_view_model.dart';

class BuyCouponDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BuyCouponViewModel>(
      converter: (store) => BuyCouponViewModel.fromStore(store),
      builder: (context, viewModel) {
        return Container(
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
          width: 400,
          height: 500.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  onPressed: () => Navigator.pop(context)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        bottom: 17,
                        child: DottedBorder(
                          strokeWidth: 2,
                          color: kPrimaryColor,
                          radius: Radius.circular(10.0),
                          borderType: BorderType.RRect,
                          dashPattern: [6, 6, 6, 6],
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 21),
                                Text(
                                  viewModel.coupon?.businessName ?? '',
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: AppColors.danger_color,
                                    letterSpacing: 0.42,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 14),
                                CouponWidget(coupon: viewModel.coupon),
                                viewModel.coupon.purchaseValue != null
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                            Text(
                                              'Purchase Value : ',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            viewModel.coupon.purchaseValue.isNaN
                                                ? Container()
                                                : Text(
                                                    'Rs ${viewModel.coupon.purchaseValue} /-' ??
                                                        0,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: kAccentColor,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  )
                                          ])
                                    : Container(),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      primary: AppColors.info_color),
                                  onPressed: showTermsAndConditionsDialog(
                                      context,
                                      viewModel.coupon?.termsAndConditions),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Coupon Details',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Icon(Icons.chevron_right, size: 17),
                                      Icon(Icons.chevron_right, size: 17),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 14,
                          left: 14,
                          child: InkWell(
                            onTap: () {
                              viewModel.onBuy();
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 46,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                gradient: LinearGradient(
                                  begin: Alignment(-0.98, 0.0),
                                  end: Alignment(0.8, 0.0),
                                  colors: [
                                    const Color(0xfffd8e34),
                                    const Color(0xffffb11a)
                                  ],
                                  stops: [0.0, 1.0],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x57ffac1e),
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Text(
                                'Buy Coupon',
                                style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 1.25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
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
}
