import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:matsapp/Pages/my_coupons/_partials/coupon_widgetnew.dart';

import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/generate_coupon/buy_coupon_view_model.dart';

class BuyCouponDialogNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screewidth = MediaQuery.of(context).size.width;
    double screeHeight = MediaQuery.of(context).size.height;
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
          width: screewidth,
          height: screeHeight,
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
                      Container(
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
                            Container(
                              // width: 200,
                              // height: 200,
                              child: CouponWidgetNew(
                                coupon: viewModel.coupon,
                                coupontype: viewModel.coupon.couponType,
                              ),
                            ),
                          ],
                        ),
                      ),
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
