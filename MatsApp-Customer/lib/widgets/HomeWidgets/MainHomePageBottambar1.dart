import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matsapp/Pages/explore/explore_page.dart';

import '../../Pages/ProductINAreaPage.dart';

class MainHomePageBottambar1 extends StatefulWidget {
  @override
  _MainHomePageBottambar1State createState() => _MainHomePageBottambar1State();
}

class _MainHomePageBottambar1State extends State<MainHomePageBottambar1> {
  PageController _pageController;
  int _currentIndex = 0;

  String appbarTitleString;

  Text appBarTitleText;

  int selectedIndex = 0;
  @override
  void initState() {
    _pageController = new PageController(
      initialPage: _currentIndex,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
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
            title: Text('Explore'),
            icon: ImageIcon(
              const AssetImage(
                'assets/images/compass.png',
              ),
              size: 50,
              color: Colors.orange[400],
            )),
        BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text('Categories'),
            icon: ImageIcon(
              const AssetImage(
                'assets/images/category.png',
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
      ProductINAreaPage(),
      ExplorePage(),

      //details_page(),
    ];

    return MaterialApp(
      // debugShowCheckedModeBanner: false,

      home: Scaffold(
          bottomNavigationBar: bottamNavigationBar,
          body: PageView(
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
        duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
  }
}
