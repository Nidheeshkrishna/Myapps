import 'package:flutter/material.dart';
import 'package:matsapp/Pages/HomePages/MainHomePage.dart';
import 'package:matsapp/Pages/my_coupons/_partials/voucher_widget.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';

import '_partials/coupons_widget.dart';

class MyCouponsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("My Shoppings", textAlign: TextAlign.center),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainHomePage()),
                    );
                  },
                  //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.lightGreyWhite.withOpacity(.42),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.29),
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                      color: kPrimaryColor),
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.white,
                  // unselectedLabelStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.36,
                  ),
                  tabs: [
                    Tab(text: "Coupons"),
                    Tab(text: "Vouchers"),
                  ],
                ),
              ),
            ),
          ),
          body: WillPopScope(
            onWillPop: () {
              return Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainHomePage()),
              );
            },
            child: TabBarView(
              children: [
                MyCouponsCouponsTab(),
                MyCouponsVoucherTab()
                //Icon(Icons.directions_bike),
              ],
            ),
          ),
        ));
  }
}
