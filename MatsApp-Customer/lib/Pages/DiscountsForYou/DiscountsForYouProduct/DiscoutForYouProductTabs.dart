import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:matsapp/Pages/DiscountsForYou/DiscountsForYouProduct/DiscoutForYouCouponTab.dart';
import 'package:matsapp/Pages/DiscountsForYou/DiscountsForYouProduct/DiscoutForYouRatingBar.dart';
import 'package:matsapp/Pages/DiscountsForYou/DiscountsForYouProduct/DiscoutForYouspecificationtab.dart';
import 'package:matsapp/constants/app_colors.dart';

class DiscoutForYouProductTabs extends StatefulWidget {
  final int productId;
  final int businessId;
  final String selectedtown;
  DiscoutForYouProductTabs(this.productId, this.selectedtown, this.businessId);
  @override
  _DelsofTheDayProductTabsState createState() =>
      _DelsofTheDayProductTabsState();
}

class _DelsofTheDayProductTabsState extends State<DiscoutForYouProductTabs>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .45,
        child: DefaultTabController(
          length: 3,
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
                  //   width: 2.0,
                  // ), // provides to left side
                  // right: BorderSide(
                  //   color: Colors.grey,
                  //   width: 2.0,
                  // ),
                  // for right side
                ),
              ),
              tabs: [
                Tab(text: "Coupon"),
                Tab(text: "Specification"),
                Tab(text: "Rate")
              ],
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                DiscoutForYouCouponTab(widget.productId, widget.selectedtown),
                DiscoutForYouspecificationtab(
                    widget.productId, widget.selectedtown),
                DiscoutForYouRatingBar(widget.productId),
              ],
            ),
          ),
        ));
  }
}
