import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matsapp/Pages/find/partials/enquiry_list.dart';
import 'package:matsapp/Pages/find/partials/new_enquiry_view.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_style.dart';

class FindPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Find", textAlign: TextAlign.center),
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
                    Tab(text: "Find"),
                    Tab(text: "Enquiries"),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              NewFindWidget(),
              PreviousEnquiriesWidget()
              //Icon(Icons.directions_bike),
            ],
          ),
        ));
  }
}
