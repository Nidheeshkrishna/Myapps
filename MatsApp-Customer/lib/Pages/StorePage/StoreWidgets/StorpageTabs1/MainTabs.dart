// import 'package:flutter/material.dart';
// import 'package:matsapp/Pages/HomePages/HomePage.dart';

// import 'package:matsapp/Pages/ProfilePages/ProfileViewpage.dart';
// import 'package:matsapp/Pages/StorePage/StoreWidgets/OfferInthiStores/StorePageProductListWidget.dart';
// import 'package:matsapp/Pages/StorePage/StoreWidgets/StorpageTabs1/BusinessProfile.dart';
// import 'package:matsapp/Pages/explore/explore_page.dart';
// import 'package:matsapp/Pages/Search/SearchMainPage.dart';
// import 'package:matsapp/constants/app_colors.dart';
// import 'package:matsapp/utilities/DatabaseHelper.dart';

// import 'package:matsapp/widgets/HomeWidgets/DrawerWidget.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MainTabs extends StatefulWidget {
//   final int businessId;
//   final String selectedtown;

//   final String businessDiscription;
//   final String businessName;

//   MainTabs(this.selectedtown, this.businessId, this.businessDiscription,
//       this.businessName);
//   @override
//   _MainHomePageState createState() => _MainHomePageState();
// }

// class _MainHomePageState extends State<MainTabs>
//     with SingleTickerProviderStateMixin {
//   // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   PageController _pageController;
//   int _currentIndex = 0;

//   String appbarTitleString;

//   Text appBarTitleText;

//   int selectedIndex = 0;

//   SharedPreferences prefs;

//   String townSelected;

//   double userLatitude;

//   String userType;

//   double userLogitude;

//   String mobile;

//   TabController tabController;
//   @override
//   void initState() {
//     DatabaseHelper dbHelper = new DatabaseHelper();

//     dbHelper.getAll().then((value) {
//       // value[0].mobilenumber;
//       // value[0].location;
//       // value[0].apitoken;
//       setState(() {
//         userType = value[0].userType;
//         mobile = value[0].mobilenumber;
//       });
//       // GeneralTools().prefsetLoginInfo(
//       //     ),
//     });

//     //_getCurrentLocation();
//     tabController = TabController(vsync: this, length: 2);
//     _pageController = new PageController(
//       initialPage: _currentIndex,
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     WidgetsFlutterBinding.ensureInitialized();
//     AppBar ar = AppBar(
//         backgroundColor: Colors.grey[300],
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//             icon: new Icon(
//               Icons.info,
//               size: 25,
//             ),
//             onPressed: () {},
//           ),
//         ],
//         flexibleSpace: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width * .8,
//               height: 40,
//               child: TabBar(
//                 // indicatorPadding: EdgeInsets.symmetric(horizontal: 15.0),
//                 indicatorColor: Colors.orange[400],
//                 labelColor: Colors.orange[400],
//                 unselectedLabelColor: Colors.grey,
//                 controller: tabController,
//                 indicator: UnderlineTabIndicator(
//                     borderSide:
//                         BorderSide(width: 3.0, color: AppColors.kAccentColor),
//                     insets: EdgeInsets.symmetric(horizontal: 15.0)),
//                 tabs: [
//                   Container(child: Tab(text: "Offers")),
//                   Container(child: Tab(text: "Store Profile")),

//                   //Tab(text: "Rate")
//                 ],
//               ),
//             ),
//           ],
//         ));

//     List<Widget> tabPages = [
//       // ListView(
//       //   shrinkWrap: true,
//       //   children: [
//       //     StorePageProductListWidget(
//       //         widget.businessId, widget.selectedtown, widget.businessName),
//       //   ],
//       // ),
//       //StorecouponWidgetNew(widget.businessId, widget.selectedtown),
//       Column(
//         children: [
//           Flexible(
//             flex: 1,
//             child: BusinessProfile(
//               widget.businessDiscription.toString() ?? "",
//             ),
//           ),
//         ],
//       ),
//     ];

//     return Scaffold(

//         //key: _scaffoldKey,

//         appBar: ar,
//         body: ListView(
//           shrinkWrap: true,
//           scrollDirection: Axis.horizontal,
//           children: [
//             PageView(
//               physics: new NeverScrollableScrollPhysics(),
//               children: tabPages,
//               onPageChanged: onPageChanged,
//               controller: _pageController,
//             ),
//           ],
//         ));
//   }

//   void onPageChanged(int page) {
//     setState(() {
//       this._currentIndex = page;
//     });
//   }

//   void onTabTapped(int index) {
//     this._pageController.animateToPage(index,
//         duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
//   }
// }
