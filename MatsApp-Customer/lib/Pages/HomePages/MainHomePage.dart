import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matsapp/Modeles/TownVerifiy/TownVerifiyModel.dart';
import 'package:matsapp/Network/serverDownRepo.dart';
import 'package:matsapp/Pages/HomePages/HomePage.dart';
import 'package:matsapp/Pages/ProfilePages/ProfileViewpage.dart';
import 'package:matsapp/Pages/Providers/Homeprovider.dart';
import 'package:matsapp/Pages/Providers/HomeproviderWithOffers.dart';
import 'package:matsapp/Pages/Providers/NetworkProvider.dart';
import 'package:matsapp/Pages/Search/SearchMainPage.dart';
import 'package:matsapp/Pages/my_coupons/my_coupons_page.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/CommonDialoges.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/PackageChecking.dart';
import 'package:matsapp/widgets/HomeWidgets/DrawerWidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  bool premiumUser = false;

  String apikey;

  bool loginstatus = true;

  bool isFirstLoaded = true;

  var GreetingId;

  bool firstLoading = false;

  PostDataProvider postMdl;
  HomePageDataProvider homePageDataProvider;

  Future<TownVerifiyModel> townverifiyFuture;
  SessionProvider sessionStatus;

  SessionProvider sessionProvider;

  Future getIsPremiumUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      premiumUser = prefs.getBool("PremiumUser") ?? false;
    });
  }

  @override
  void initState() {
    getIsPremiumUser();

    serverDown(mobile, apikey);

    DatabaseHelper dbHelper = new DatabaseHelper();

    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Colors.white));
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    dbHelper.getAll().then((value) => {
          value[0].mobilenumber, value[0].location, value[0].apitoken
          // GeneralTools().prefsetLoginInfo(
          //     ),
        });

    dbHelper.getAll().then((value) {
      setState(() {
        userType = value.first.userType;
        mobile = value.first.mobilenumber;
        apikey = value.first.apitoken;
      });
    });

    //_getCurrentLocation();
    _pageController = new PageController(
      initialPage: _currentIndex,
    );

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homePageDataProvider =
          Provider.of<HomePageDataProvider>(context, listen: false);
      homePageDataProvider.getPostData(context, true);
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Platform.isAndroid) {
        PackageChecking.appversion(context, "android");
      } else {
        if (Platform.isIOS) {
          PackageChecking.appversion(context, "ios");
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final sessionStatus =
          Provider.of<SessionProvider>(context, listen: false);

      sessionStatus.getSessionexpired(context, loginstatus);
    });
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   postMdl = Provider.of<SessionProvider>(context, listen: false);

    //   postMdl.getSessionexpired(context,);

    //   // if (postMdl != null) {
    //   //   if (postMdl.post.apiKeyStatus != null) {
    //   //     if (!postMdl.post.apiKeyStatus) {
    //   //       CommonDialoges().sessionTimeOutDialoge(context);
    //   //     }
    //   //   }
    //   // }
    // });

    //hotSpotsFuture = fetchHotSpot(townSelectedStore);

    //CheckGreetingStatus();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenhight = MediaQuery.of(context).size.height -
        kToolbarHeight -
        MediaQuery.of(context).padding.top;
    BottomNavigationBar bottamNavigationBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFFFCFCFC),
      selectedItemColor: AppColors.kAccentColor,
      unselectedItemColor: AppColors.mIconColor,
      currentIndex: _currentIndex,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          // ignore: deprecated_member_use
          title: Container(
              padding: EdgeInsets.only(bottom: 4), child: Text('Home')),
          icon: Container(
            padding: EdgeInsets.only(bottom: 4, top: 6),
            child: SvgPicture.asset(
              'assets/vectors/ic_home.svg',
              color: _currentIndex == 0
                  ? AppColors.kAccentColor
                  : AppColors.mIconColor,
              height: 25,
            ),
          ),
        ),
        // size: 50,
        //color: AppColors.kAccentColor)),
        BottomNavigationBarItem(
          // ignore: deprecated_member_use
          title: Container(
              padding: EdgeInsets.only(bottom: 4), child: Text('Search')),
          icon: Container(
            padding: EdgeInsets.only(bottom: 4, top: 6),
            child: SvgPicture.asset(
              'assets/vectors/ic_lense.svg',
              color: _currentIndex == 1
                  ? AppColors.kAccentColor
                  : AppColors.mIconColor,
              height: 25,
            ),
          ),
        ),
        BottomNavigationBarItem(
          // ignore: deprecated_member_use
          title: Container(
              //padding: EdgeInsets.only(bottom: 4), child: Text('Explore')),
              padding: EdgeInsets.only(bottom: 4),
              child: Text('Shoppings')),
          icon: Container(
            padding: EdgeInsets.only(bottom: 4, top: 6),
            child: SvgPicture.asset(
              'assets/vectors/basket_icon.svg',
              color: _currentIndex == 2
                  ? AppColors.kAccentColor
                  : AppColors.mIconColor,
              height: 25,
            ),
          ),
        ),
        BottomNavigationBarItem(
          // ignore: deprecated_member_use
          title: Container(
              padding: EdgeInsets.only(bottom: 4), child: Text('Profile')),
          icon: Container(
            padding: EdgeInsets.only(bottom: 4, top: 6),
            child: SvgPicture.asset(
              'assets/vectors/ic_profile.svg',
              color: _currentIndex == 3
                  ? AppColors.kAccentColor
                  : AppColors.mIconColor,
              height: 25,
            ),
          ),
        ),
      ],
    );

    List<Widget> tabPages = [
      HomePage(),
      SearchMainPage(),
      MyCouponsPage(),
      ProfileViewpage(mobile)
      //details_page(),
    ];

    return Scaffold(
        //key: _scaffoldKey,
        //appBar: appbar,
        drawer: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 0.0,
            ),
            child: DrawerWidget(userType, premiumUser),
          ),
        ),
        bottomNavigationBar: bottamNavigationBar,
        body: SafeArea(
          child: Hero(
            
            tag:"home Page",
            child: Container(
              width: screenwidth,
              height: screenhight,
              child: PageView(
                physics: new NeverScrollableScrollPhysics(),
                children: tabPages,
                onPageChanged: onPageChanged,
                controller: _pageController,
              ),
            ),
          ),
        ));
  }

  void onPageChanged(int page) {
    setState(() {
      this._currentIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 10), curve: Curves.bounceIn);
  }

  serverDown(String mobile, String apikey) {
    fetchServerInfo(mobile, apikey).then((value) => {
          if (value.result.maintenance)
            {
              CommonDialoges()
                  .serverMaintanenceDialoge(context, value.result.message)
            }
        });
  }

  Future CheckGreetingStatus() async {
    //greetingid
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFirstLoaded = prefs.getBool("keyIsFirstLoad") ?? true;
    });
  }

  Future<bool> isFirstTime(int greetingid) async {
    bool isfirstime = false;
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    SharedPreferences.getInstance().then((SharedPreferences sp) async {
      var sharedPreferences = sp;

      GreetingId = sharedPreferences.getInt('GreetingId') ?? 0;

      if (GreetingId != greetingid) {
        // sharedPreferences.remove("GreetingId");
        sharedPreferences.setInt('GreetingId', greetingid);
        return isfirstime = true;
      } else {
        return isfirstime = false;
      }
    });
    return isfirstime;
  }
}
