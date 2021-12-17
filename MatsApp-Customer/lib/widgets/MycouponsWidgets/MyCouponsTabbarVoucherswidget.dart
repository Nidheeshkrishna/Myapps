import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/widgets/HomepageAdds/HomepageAdWidget3.dart';
import 'package:matsapp/widgets/HomepageAdds/HomepageAdWidget4.dart';


class MyCouponsTabbarVoucherswidget extends StatefulWidget {
  @override
  _MyCouponsTabbarVoucherswidgetState createState() =>
      _MyCouponsTabbarVoucherswidgetState();
}

class _MyCouponsTabbarVoucherswidgetState
    extends State<MyCouponsTabbarVoucherswidget> {
  TabController tabController;

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            //height: ,
            child: ButtonsTabBar(
              controller: tabController,
              backgroundColor: Colors.purple,
              borderWidth: 0,
              borderColor: Colors.transparent,
              unselectedBorderColor: Colors.black,
              radius: 10,
              unselectedBackgroundColor: Colors.grey[50],
              unselectedLabelStyle: TextStyle(
                  color: Colors.amberAccent, fontWeight: FontWeight.bold),
              labelStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              tabs: [
                Tab(
                  text: "Active", //text: "Visited",
                  // child: Text("Visited"),
                ),
                Tab(
                  text: "Recycle ",
                ),
                Tab(
                  text: "Expired  ",
                ),
                Tab(
                  text: "Used ",
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                HomepageAdwidget3(),
                HomepageAdwidget4(),
                HomepageAdwidget3(),
                HomepageAdwidget4(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
