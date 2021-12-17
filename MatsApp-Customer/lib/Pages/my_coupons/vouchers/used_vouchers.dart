import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:matsapp/Modeles/coupon_generate/voucher_model.dart';
import 'package:matsapp/Pages/my_coupons/_partials/coupons_list_widget.dart';
import 'package:matsapp/Pages/my_coupons/_partials/voucher_item.dart';
import 'package:matsapp/redux/actions/common_actions.dart';
import 'package:matsapp/redux/models/my_coupon_model.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:matsapp/redux/viewModels/my_coupons/my_voucher_view_models.dart';

class UsedVoucherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UsedVouchersViewModel>(
        onInitialBuild: (viewModel) {
          if (viewModel.vouchers.isEmpty||viewModel.vouchers.isNotEmpty)
           viewModel.getVouchers();
        },
        converter: (store) => UsedVouchersViewModel.fromStore(store),
        onDispose: (store) =>
            store.dispatch(OnClearAction(type: VOUCHER_TYPES.EXPIRED)),
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
            onClick: null,
          );
        });
  }
}
