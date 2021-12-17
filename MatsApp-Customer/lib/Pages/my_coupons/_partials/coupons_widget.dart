import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Pages/my_coupons/coupons/active_coupons.dart';
import 'package:matsapp/Pages/my_coupons/coupons/expired_coupons.dart';
import 'package:matsapp/Pages/my_coupons/coupons/history_coupons.dart';
import 'package:matsapp/Pages/my_coupons/coupons/shared_coupons.dart';
import 'package:matsapp/constants/app_colors.dart';

class MyCouponsCouponsTab extends StatefulWidget {
  @override
  _MyCouponsCouponsTabState createState() => _MyCouponsCouponsTabState();
}

class _MyCouponsCouponsTabState extends State<MyCouponsCouponsTab>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<MyCouponsCouponsTab> {
  TabController couponsTabController;

  @override
  void initState() {
    super.initState();
    couponsTabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBar(
                isScrollable: false,
                controller: couponsTabController,
                unselectedLabelColor: AppColors.kAccentColor,

                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: EdgeInsets.all(3),
                labelColor: Colors.white,
                //indicatorWeight: 2,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColors.kAccentColor),

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
                    child: Text(
                      "Active",
                      textAlign: TextAlign.center,
                    ),
                  )),
                  Tab(
                      child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: AppColors.kPrimaryColor, width: 1)),
                    child: Text("Shared", textAlign: TextAlign.center),
                  )),
                  Tab(
                      child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: AppColors.kPrimaryColor, width: 1)),
                    child: Text("Expired", textAlign: TextAlign.center),
                  )),
                  Tab(
                      child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: AppColors.kPrimaryColor, width: 1)),
                    child: Text("Used", textAlign: TextAlign.center),
                  )),
                ],
              )),
          Expanded(
            child: TabBarView(
              controller: couponsTabController,
              children: [
                ActiveCouponsWidget(),
                SharedCouponsWidget(),
                ExpiredCouponsWidget(),
                HistoryCouponsWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
