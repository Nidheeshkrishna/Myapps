import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:matsapp/Modeles/coupon_generate/voucher_model.dart';
import 'package:matsapp/Pages/my_coupons/_partials/coupons_list_widget.dart';
import 'package:matsapp/Pages/my_coupons/_partials/voucher_item.dart';
import 'package:matsapp/Pages/my_coupons/redeem_coupon_dialog.dart';
import 'package:matsapp/Pages/my_coupons/vouchers/redeem_voucher_dialog.dart';
import 'package:matsapp/redux/actions/common_actions.dart';
import 'package:matsapp/redux/models/my_coupon_model.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/my_coupons/my_voucher_view_models.dart';

class GiftedVoucherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GiftedVouchersViewModel>(
        onInitialBuild: (viewModel) {
          if (viewModel.vouchers.isEmpty||viewModel.vouchers.isNotEmpty) viewModel.getVouchers();
        },
        converter: (store) => GiftedVouchersViewModel.fromStore(store),
        onDispose: (store) =>
            store.dispatch(OnClearAction(type: VOUCHER_TYPES.GIFTED)),
        onDidChange: (old, viewModel) {
          if (old.isLoading && viewModel.hasError) {
            final snackBar =
                SnackBar(content: Text(viewModel.loadingError ?? ""));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        

        
     
        builder: (context, viewModel) {
          return VouchersListWidget<VoucherModel>(
            isLoading: viewModel.isLoading,
            onRefresh: viewModel.getVouchers,
            vouchers: viewModel.vouchers,
            
            itemBuilder: (item, position) => VoucherListItem(
              hasRightBorder: false,
              voucher: item,
            ),
            onClick: (voucher) async {
              viewModel.onVoucherSelect(voucher);
              var result = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      insetPadding: EdgeInsets.all(20),
                      child: RedeemDialogVoucher(
                        isCoupon: false,
                      ),
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
