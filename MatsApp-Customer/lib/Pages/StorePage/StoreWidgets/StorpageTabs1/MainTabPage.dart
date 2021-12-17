import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matsapp/Modeles/GetStoredetailesModel.dart';
import 'package:matsapp/Network/GetStoreDetailesRest.dart';
import 'package:matsapp/Pages/StorePage/StoreWidgets/OfferInthiStores/StorePageProductListWidget.dart';
import 'package:matsapp/Pages/StorePage/StoreWidgets/StorpageTabs1/BusinessProfile.dart';
import 'package:matsapp/Pages/StorePage/StoreWidgets/StorpageTabs1/StoreCouponTab.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/DetailesDialog.dart';

import '../../StoreInfoAlert.dart';

class StorpageProductMainTabs extends StatefulWidget {
  //final int productId;
  final int businessId;
  final String selectedtown;

  final String businessDiscription;
  final String businessName;
  final List<AllOffer> offerdata;

  StorpageProductMainTabs(
    this.selectedtown,
    this.businessId,
    this.businessDiscription,
    this.businessName,
    this.offerdata,
  );
  @override
  _StorpageProductTabsState createState() => _StorpageProductTabsState();
}

class _StorpageProductTabsState extends State<StorpageProductMainTabs>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  double screenwidth;
  double screenHight;
  bool purchaseLimitVisibility;

  Future<GetStoredetailesModel> futurestoreDetailes;

  bool Offerstatus;
  @override
  void initState() {
    tabController = TabController(vsync: this, length: 2);
    //getOfferStatus();

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

    if (widget.offerdata != null) {
      if (widget.offerdata.length > 0) {
        Offerstatus = true;
      } else {
        Offerstatus = false;
      }
    } else {
      Offerstatus = false;
    }
    if (widget.offerdata != null) {
      if (widget.offerdata.length > 2) {
        screenHight = MediaQuery.of(context).size.height * .88;
        screenwidth = MediaQuery.of(context).size.width;
      } else if (widget.offerdata.length < 2) {
        screenHight = MediaQuery.of(context).size.height * .58;
        screenwidth = MediaQuery.of(context).size.width;
      } else {
        screenHight = MediaQuery.of(context).size.height * .50;
        screenwidth = MediaQuery.of(context).size.width;
      }
    } else {
      screenHight = MediaQuery.of(context).size.height * .40;
      screenwidth = MediaQuery.of(context).size.width;
    }

    if (tabController.indexIsChanging) {
      getSize(context, tabController.index);
    } else {
      getSize(context, tabController.index);
    }
    AppBar ar = AppBar(
        backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: new Icon(
              Icons.info,
              size: 25,
            ),
            onPressed: () {
              AppDialoges().storeInfoAlert(context);
            },
          ),
        ],
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .8,
              height: 40,
              child: TabBar(
                  onTap: (_) {
                    if (tabController.index == 0) {
                      if (widget.offerdata.length > 2) {
                        setState(() {
                          screenHight =
                              MediaQuery.of(context).size.height * .88;
                          screenwidth = MediaQuery.of(context).size.width;
                        });
                      } else {
                        setState(() {
                          screenHight =
                              MediaQuery.of(context).size.height * .50;
                          screenwidth = MediaQuery.of(context).size.width;
                        });
                      }
                      if (widget.offerdata.length > 2) {
                        setState(() {
                          screenHight =
                              MediaQuery.of(context).size.height * .88;
                          screenwidth = MediaQuery.of(context).size.width;
                        });
                      } else {
                        setState(() {
                          screenHight =
                              MediaQuery.of(context).size.height * .58;
                          screenwidth = MediaQuery.of(context).size.width;
                        });
                      }
                    } else if (tabController.index == 1) {
                      setState(() {
                        screenwidth = MediaQuery.of(context).size.width;
                        screenHight = MediaQuery.of(context).size.height * .40;
                      });
                    }
                  },
                  // indicatorPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  indicatorColor: Colors.orange[400],
                  labelColor: Colors.orange[400],
                  unselectedLabelColor: Colors.grey,
                  controller: tabController,
                  indicator: UnderlineTabIndicator(
                      borderSide:
                          BorderSide(width: 3.0, color: AppColors.kAccentColor),
                      insets: EdgeInsets.symmetric(horizontal: 15.0)),
                  tabs: [
                    Container(
                        child: Tab(text: Offerstatus ? "Offers" : "Coupon")),

                    Container(child: Tab(text: "Store Profile")),

                    //Tab(text: "Rate")
                  ]),
            ),
          ],
        ));

    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(2),
          width: screenwidth,
          height: screenHight,
          child: Scaffold(
            appBar: ar,
            body: Column(
              children: [
                Flexible(
                    // fit: FlexFit.loose,
                    flex: 1,
                    // Offerstatus
                    //     ?
                    child: Offerstatus
                        ? TabBarView(
                            controller: tabController,
                            children: [
                              //StorePageProductListWidget()

                              ListView(
                                primary: true,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  StorePageProductListWidget(
                                      widget.businessId,
                                      widget.selectedtown,
                                      widget.businessName,
                                      widget.offerdata),
                                ],
                              ),

                              //StorecouponWidgetNew(widget.businessId, widget.selectedtown),
                              ListView(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  BusinessProfile(
                                    widget.businessDiscription.toString() ?? "",
                                  ),
                                ],
                              ),
                              //RatingBarWidget(widget.productId),
                            ],
                          )
                        : TabBarView(
                            controller: tabController,
                            children: [
                              //StorePageProductListWidget()

                              ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  Container(
                                    child: StorecouponWidgetNew(
                                        widget.businessId, widget.selectedtown),
                                  ),
                                ],
                              ),

                              //StorecouponWidgetNew(widget.businessId, widget.selectedtown),
                              ListView(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 25),
                                    child: BusinessProfile(
                                      widget.businessDiscription.toString() ??
                                          "",
                                    ),
                                  ),
                                ],
                              ),
                              //RatingBarWidget(widget.productId),
                            ],
                          )),
              ],
            ),
          )),
    );
  }

  void getSize(BuildContext context, int index) {
    print("Indexxxxxxxxxxxx $index");
    if (index == 0) {
      if (Offerstatus) {
        if (widget.offerdata.length > 2) {
          setState(() {
            screenHight = MediaQuery.of(context).size.height * .88;
            screenwidth = MediaQuery.of(context).size.width;
          });
        } else {
          setState(() {
            screenHight = MediaQuery.of(context).size.height * .62;
            screenwidth = MediaQuery.of(context).size.width;
          });
        }
      } else {
        screenHight = MediaQuery.of(context).size.height * .60;
        screenwidth = MediaQuery.of(context).size.width;
      }
    } else if (index == 1) {
      setState(() {
        screenwidth = MediaQuery.of(context).size.width;
        screenHight = MediaQuery.of(context).size.height * .35;
      });
    }
  }

  fetchdata() {
    futurestoreDetailes = fetchStordetailes(widget.businessId);
  }
}
