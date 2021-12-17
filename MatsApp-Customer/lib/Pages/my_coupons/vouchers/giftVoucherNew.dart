import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Pages/_views/empty_view.dart';
import 'package:matsapp/Pages/_views/loading_mask.dart';
import 'package:matsapp/Pages/my_coupons/_partials/coupons_items.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';

class VouchersListWidget<T> extends StatelessWidget {
  final List<T> vouchers;
  final Widget Function(T, int) itemBuilder;
  final Function(T) onClick;
  final VoidCallback onRefresh;
  final bool isLoading;

  const VouchersListWidget({
    Key key,
    @required this.itemBuilder,
    @required this.vouchers,
    this.onClick,
    this.onRefresh,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading)
      return AppLoadingMask(
        isLoading: true,
        loadingChild: ListView.builder(
          padding: EdgeInsets.all(4),
          itemBuilder: (con, pos) {
            return TextButton(
              onPressed: () {},
              child: ActiveCouponItem(
                coupon: null,
                position: pos,
              ),
            );
          },
          itemCount: 6,
        ),
      );

    if (vouchers.isEmpty)
      return EmptyView(
        title: "No Vouchers to show",
        message: "",
      );
    // if (vouchers.isNotEmpty) {
    //   if (vouchers.length > 0) {
    //     onRefresh();
    //   }
    // }
    return Container(
      padding: EdgeInsets.all(2),
      child: RefreshIndicator(
        onRefresh: () {
          onRefresh();
          return Future.delayed(kThemeAnimationDuration);
        },
        child: CupertinoScrollbar(
          radius: Radius.circular(4),
          child: ListView.builder(
              padding: EdgeInsets.all(4),
              itemCount: vouchers?.length ?? 0,
              itemBuilder: (context, position) {
                T selected = vouchers.elementAt(position);
                return TextButton(
                  onPressed: () => onClick != null ? onClick(selected) : () {},
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                        right:
                            BorderSide(color: _getColor(position), width: .4),
                        left: BorderSide(color: _getColor(position), width: .4),
                        bottom:
                            BorderSide(color: _getColor(position), width: 4),
                      )),
                      child: itemBuilder(selected, position)),
                );
              }),
        ),
      ),
    );
  }

  Color _getColor(int position) {
    int current = position % 4;
    switch (current) {
      case 0:
        return AppColors.kPrimaryColor;
      case 1:
        return AppColors.success_color;
      case 2:
        return AppColors.black_shadow_color;
      case 3:
        return AppColors.lightGreyWhite;
      default:
        return kPrimaryColor;
    }
  }
}