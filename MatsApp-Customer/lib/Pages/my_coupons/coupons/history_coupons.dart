import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';

import 'package:matsapp/Pages/my_coupons/_partials/coupons_list_widget.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';
import 'package:matsapp/redux/actions/common_actions.dart';
import 'package:matsapp/redux/models/my_coupon_model.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/my_coupons/my_coupons_view_model.dart';
import 'package:matsapp/utilities/size_config.dart';

class HistoryCouponsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HistoryCouponsViewModel>(
        onInitialBuild: (viewModel) {
           if (viewModel.historyCoupons.isEmpty||viewModel.historyCoupons.isNotEmpty)
          viewModel.getCoupons();
        },
        converter: (store) => HistoryCouponsViewModel.fromStore(store),
        onDispose: (store) =>
            store.dispatch(OnClearAction(type: COUPON_TYPES.HISTORY)),
        onDidChange: (old, viewModel) {
          if (old.isLoading && viewModel.hasError) {
            final snackBar =
                SnackBar(content: Text(viewModel.loadingError ?? ""));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, viewModel) {
          // if (viewModel.isLoading) return AppLoadingSpinner();
          return CouponsListWidget<CouponModel>(
            onRefresh: viewModel.getCoupons,
            isLoading: viewModel.isLoading,
            coupons: viewModel.historyCoupons,
            itemBuilder: (item, position) =>
                HistoryCouponItem(coupon: item, position: position),
            onClick: (coupon) {},
          );
        });
  }
}

class HistoryCouponItem extends StatelessWidget {
  final int position;
  final CouponModel coupon;

  const HistoryCouponItem({Key key, this.position, this.coupon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String status = coupon?.status ?? 'Expired';
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black_shadow_color,
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      height: SizeConfig.blockSizeVertical * 35,
      width: SizeConfig.blockSizeHorizontal * 90,
      child: ClipRect(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(31.0),
                  image: DecorationImage(
                    image: NetworkImage(coupon?.logoUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coupon?.couponType == "Product"
                            ? coupon.productName ?? ""
                            : coupon.businessName ?? "",
                        //'${coupon?.couponTitle ?? ""}',
                        style: TextStyle(
                          //fontSize: SizeConfig.safeBlockHorizontal * 10,,
                          color: Colors.black,
                          letterSpacing: 0.57,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Upto ${coupon?.matsappDiscount}% off',
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 5,
                                color: AppColors.kAccentColor,
                                letterSpacing: 0.6,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Level",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          10,
                                  color: AppColors.kSecondaryDarkColor,
                                ),
                              ),
                              coupon?.levelImage != null
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          .15,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              25,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              NetworkImage(coupon?.levelImage),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    )
                                  : Container(),
                              Text(
                                coupon?.levelName ?? "",
                                style: TextStyle(
                                  fontSize: 10 *
                                      MediaQuery.textScaleFactorOf(context),
                                  color: AppColors.kSecondaryDarkColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                      // SizedBox(height: 8),
                      // Text(
                      //   'You saved Rs ${coupon?.couponValue ?? 0}/-',
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: AppColors.kAccentColor,
                      //     letterSpacing: 0.533,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      //   textAlign: TextAlign.left,
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          coupon?.giftName ?? "",
                          style: TextStyle(
                            fontSize:
                                12 * MediaQuery.textScaleFactorOf(context),
                            color: AppColors.kSecondaryDarkColor,
                          ),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenwidth,
                        //height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'CODE : ',
                              style: TextStyle(
                                fontSize: 14,
                                color: const Color(0xff565656),
                                letterSpacing: 1.71,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              coupon?.userCouponId,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.kAccentColor,
                                letterSpacing: 1.71,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    //return Container();
  }
}
