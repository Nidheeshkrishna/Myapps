import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:matsapp/Modeles/coupon_generate/coupon_model.dart';
import 'package:matsapp/Pages/my_coupons/_partials/coupons_items.dart';
import 'package:matsapp/Pages/my_coupons/_partials/coupons_list_widget.dart';
import 'package:matsapp/Pages/my_coupons/redeem_coupon_dialog.dart';
import 'package:matsapp/redux/actions/common_actions.dart';
import 'package:matsapp/redux/models/my_coupon_model.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/my_coupons/my_coupons_view_model.dart';

class ActiveCouponsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ActiveCouponsViewModel>(
        onInitialBuild: (viewModel) {
          if (viewModel.activeCoupons.isEmpty ||
              viewModel.activeCoupons.isNotEmpty) viewModel.getCoupons();
        },
        converter: (store) => ActiveCouponsViewModel.fromStore(store),
        onDispose: (store) =>
            store.dispatch(OnClearAction(type: COUPON_TYPES.ACTIVE)),
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
            isLoading: viewModel.isLoading,
            onRefresh: viewModel.getCoupons,
            coupons: viewModel.activeCoupons,
            itemBuilder: (item, position) => ActiveCouponItem(
              coupon: item,
              position: position,
              action: "Redeem",
            ),
            onClick: (coupon) async {
              viewModel.onCouponSelect(coupon);
              var result = await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      insetPadding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      child: RedeemDialog(),
                    );
                  });

              if (result ?? true) {
                Future.delayed(
                  kThemeAnimationDuration,
                  () => viewModel.clearSelected(),
                );
              }
            },
          );
        });
  }
}
