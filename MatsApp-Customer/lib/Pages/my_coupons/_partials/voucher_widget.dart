import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Pages/_views/empty_view.dart';
import 'package:matsapp/Pages/my_coupons/vouchers/expired_vouchers.dart';
import 'package:matsapp/Pages/my_coupons/vouchers/gifted_vouchers.dart';
import 'package:matsapp/Pages/my_coupons/vouchers/recycle_vouchers.dart';
import 'package:matsapp/Pages/my_coupons/vouchers/used_vouchers.dart';
import 'package:matsapp/constants/app_colors.dart';

class MyCouponsVoucherTab extends StatefulWidget {
  @override
  _MyCouponsVoucherTabState createState() => _MyCouponsVoucherTabState();
}

class _MyCouponsVoucherTabState extends State<MyCouponsVoucherTab>
    with SingleTickerProviderStateMixin {
  TabController voucherTabController;

  @override
  void initState() {
    super.initState();
    voucherTabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBar(
                isScrollable: false,
                controller: voucherTabController,
                unselectedLabelColor: AppColors.kAccentColor,
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: EdgeInsets.all(3),
                labelColor: Colors.white,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColors.kPrimaryColor),
                unselectedLabelStyle:
                    TextStyle(fontSize: 15, letterSpacing: 0.32),
                labelStyle: TextStyle(
                    fontSize: 15,
                    letterSpacing: 0.32,
                    fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColors.kPrimaryColor, width: 1)),
                          child: Text("Gifted", textAlign: TextAlign.center))),
                  Tab(
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColors.kPrimaryColor, width: 1)),
                          child:
                              Text("Expired ", textAlign: TextAlign.center))),
                  Tab(
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColors.kPrimaryColor, width: 1)),
                          child: Text("Used", textAlign: TextAlign.center))),
                  Tab(
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColors.kPrimaryColor, width: 1)),
                          child: Text("Shared", textAlign: TextAlign.center))),
                ],
              )),
          Expanded(
            child: TabBarView(
              controller: voucherTabController,
              children: [
                GiftedVoucherWidget(),
                ExpiredVoucherWidget(),
                UsedVoucherWidget(),
                RecycleVoucherWidget(),
                // EmptyView(
                //   title: "No Voucher",
                //   message: "You don't have any vouchers",
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
