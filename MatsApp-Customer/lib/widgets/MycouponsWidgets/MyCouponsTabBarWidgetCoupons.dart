import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/widgets/HomepageAdds/HomepageAdWidget3.dart';

class MyCouponsTabbarwidgetCoupons extends StatefulWidget {
  @override
  _MyCouponsTabbarwidgetCouponsState createState() =>
      _MyCouponsTabbarwidgetCouponsState();
}

class _MyCouponsTabbarwidgetCouponsState
    extends State<MyCouponsTabbarwidgetCoupons> {
  TabController tabController;

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            //height: ,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonsTabBar(
                controller: tabController,
                backgroundColor: Colors.purple,
                borderWidth: 0,
                borderColor: Colors.transparent,
                unselectedBorderColor: Colors.black,
                radius: 10,
                unselectedBackgroundColor: Colors.grey[50],
                unselectedLabelStyle: TextStyle(color: Colors.amberAccent),
                labelStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    text: "Active ", //text: "Visited",
                    // child: Text("Visited"),
                  ),
                  Tab(
                    text: "Shared ",
                  ),
                  Tab(
                    text: "Expired",
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                HomepageAdwidget3(),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
