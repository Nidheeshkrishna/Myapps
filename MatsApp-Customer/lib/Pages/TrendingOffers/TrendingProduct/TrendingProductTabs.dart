import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:matsapp/Pages/TrendingOffers/TrendingProduct/TrendingRatingBarWidget.dart';
import 'package:matsapp/Pages/TrendingOffers/TrendingProduct/Trendingspecificationtab.dart';
import 'package:matsapp/constants/app_colors.dart';

class TrendingProductTabs extends StatefulWidget {
  final int productId;
  final int businessId;
  final String selectedtown;
  TrendingProductTabs(this.productId, this.selectedtown, this.businessId);
  @override
  _TrendingProductTabsState createState() => _TrendingProductTabsState();
}

class _TrendingProductTabsState extends State<TrendingProductTabs>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .50,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: TabBar(
              indicatorColor: Colors.orange[400],
              labelColor: Colors.orange[400],
              unselectedLabelColor: Colors.grey,
              controller: tabController,
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.kAccentColor,
                    width: 3.0,
                  ),
                  // left: BorderSide(
                  //   color: Colors.grey,
                  //   width: 3.0,
                  // ), // provides to left side
                  // right: BorderSide(
                  //   color: Colors.grey,
                  //   width: 3.0,
                  // ),
                  // for right side
                ),
              ),
              tabs: [
                // Container(child: Tab(text: "Coupon")),
                Tab(text: "Specification"),
                Tab(text: "Rate")
              ],
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              child: TabBarView(
                controller: tabController,
                children: [
                  // CouponsTab(widget.productId, widget.selectedtown),
                  Trendingspecificationtab(
                      widget.productId, widget.selectedtown),
                  TrendingRatingBarWidget(widget.productId),
                ],
              ),
            ),
          ),
        ));
  }
}
