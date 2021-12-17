import 'package:flutter/material.dart';

import 'package:matsapp/Pages/ProfilePages/ProfileViewpage.dart';
import 'package:matsapp/Pages/explore/explore_page.dart';
import 'package:matsapp/Pages/Search/SearchMainPage.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';

import 'package:matsapp/widgets/HomeWidgets/DrawerWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePages/HomePage.dart';

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PageController _pageController;
  int _currentIndex = 0;

  String appbarTitleString;

  Text appBarTitleText;

  int selectedIndex = 0;

  SharedPreferences prefs;

  String townSelected;

  double userLatitude;

  String userType;

  double userLogitude;

  String mobile;
  @override
  void initState() {
    DatabaseHelper dbHelper = new DatabaseHelper();

    dbHelper.getAll().then((value) {
      // value[0].mobilenumber;
      // value[0].location;
      // value[0].apitoken;
      setState(() {
        userType = value[0].userType;
        mobile = value[0].mobilenumber;
      });
      // GeneralTools().prefsetLoginInfo(
      //     ),
    });

    //_getCurrentLocation();
    _pageController = new PageController(
      initialPage: _currentIndex,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    BottomNavigationBar bottamNavigationBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFFFCFCFC),
      selectedItemColor: Colors.orange[400],
      unselectedItemColor: Colors.black,
      currentIndex: _currentIndex,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(

            // ignore: deprecated_member_use
            title: Text('Home'),
            icon: ImageIcon(
              const AssetImage(
                'assets/images/home.png',
              ),
              size: 50,
              color: Colors.orange[400],
            )),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text('Search'),
            icon: ImageIcon(
              const AssetImage(
                'assets/images/search.png',
              ),
              size: 50,
              color: Colors.orange[400],
            )),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text('Shoppings'),
            //label: 'Shoppings',
            icon: ImageIcon(
              const AssetImage(
                'assets/images/compass.png',
              ),
              size: 50,
              color: Colors.orange[400],
            )),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text('Profile'),
            icon: ImageIcon(
              const AssetImage(
                'assets/images/profile-user.png',
              ),
              size: 50,
              color: Colors.orange[400],
            )),
      ],
    );

    List<Widget> tabPages = [
      HomePage(),
      SearchMainPage(),
      ExplorePage(),
      ProfileViewpage(mobile)
      //details_page(),
    ];

    return SafeArea(
      child: Scaffold(
          //key: _scaffoldKey,
          //appBar: appbar,
          drawer: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: DrawerWidget(userType,false),
          ),
          bottomNavigationBar: bottamNavigationBar,
          body: PageView(
            physics: new NeverScrollableScrollPhysics(),
            children: tabPages,
            onPageChanged: onPageChanged,
            controller: _pageController,
          )),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._currentIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
  }
}
