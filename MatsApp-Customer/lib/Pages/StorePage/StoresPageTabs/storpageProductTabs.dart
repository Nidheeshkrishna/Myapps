import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Pages/StorePage/StoresPageTabs/CouponTab.dart';

import 'package:matsapp/Pages/StorePage/StoresPageTabs/RatingBarWidget.dart';
import 'package:matsapp/Pages/StorePage/StoresPageTabs/specificationtab.dart';
import 'package:matsapp/constants/app_colors.dart';

class StorpageProductTabs extends StatefulWidget {
  final int productId;
  final int businessId;
  final String selectedtown;
  //final String itemtype;
  StorpageProductTabs(this.productId, this.selectedtown, this.businessId);
  @override
  _StorpageProductTabsState createState() => _StorpageProductTabsState();
}

class _StorpageProductTabsState extends State<StorpageProductTabs>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  bool purchaseLimitVisibility;
  @override
  void initState() {
    tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.itemtype == "Product") {
    //   setState(() {
    //     purchaseLimitVisibility = true;
    //   });
    //   setState(() {
    //     purchaseLimitVisibility = false;
    //   });
    // }
    return Container(
        padding: EdgeInsets.only(right: 4),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .5,
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
                  ), // provides to left side
                  // right: BorderSide(
                  //   color: Colors.grey,
                  //   width: 3.0,
                  // ),
                  // for right side
                ),
              ),
              tabs: [
                Container(child: Tab(text: "Coupon")),
                Tab(text: "Specification"),
                Tab(text: "Rate")
              ],
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                CouponsTab(widget.productId, widget.selectedtown),
                speciicationtab(widget.productId, widget.selectedtown),
                RatingBarWidget(widget.productId),
              ],
            ),
          ),
        ));
  }
}
