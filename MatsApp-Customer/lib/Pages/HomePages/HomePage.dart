import 'dart:async';

import 'package:badges/badges.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matsapp/Modeles/Login/LoginExistCheckModel.dart';
import 'package:matsapp/Modeles/notificationCountModel.dart';
import 'package:matsapp/Network/GreetingsRepo.dart';
import 'package:matsapp/Network/LoginExistCheckRepo.dart';
import 'package:matsapp/Network/NotificationCountRepo.dart';
import 'package:matsapp/Network/TownVerifiyRepo/TownVerifiyRepo.dart';
import 'package:matsapp/Pages/HomePageOfferCategory/OfferCategory_1/OfferCategoryPage.dart';
import 'package:matsapp/Pages/Login/LoginPage.dart';
import 'package:matsapp/Pages/Providers/ConnectivityServices.dart';
import 'package:matsapp/Pages/Providers/Homeprovider.dart';
import 'package:matsapp/Pages/Providers/HomeproviderWithOffers.dart';
import 'package:matsapp/Pages/Providers/NetworkProvider.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/utilities/CommonDialoges.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/GerneralTools.dart';
import 'package:matsapp/utilities/firebaseBackgrounNotification.dart';
import 'package:matsapp/utilities/size_config.dart';
import 'package:matsapp/widgets/Categorywidgets/HomepagCatogoryWidget.dart';
import 'package:matsapp/widgets/HomeWidgets/HomeBrowsePopularWidget.dart';
import 'package:matsapp/widgets/HomeWidgets/HomePageLocation.dart';
import 'package:matsapp/widgets/HomepageAdds/HomePageMiddleAd.dart';
import 'package:matsapp/widgets/HomepageAdds/HomePageTopAddWidget.dart';
import 'package:matsapp/widgets/HomepageAdds/HomepageAdWidget3.dart';
import 'package:matsapp/widgets/HomepageAdds/HomepageAdWidget4.dart';
import 'package:matsapp/widgets/HotspotsWidgets/HotspotViewAllWidget.dart';
import 'package:matsapp/widgets/HotspotsWidgets/HotspotsHomeWidget.dart';
import 'package:matsapp/widgets/LoadingWidgets/HomePageLoader.dart';
import 'package:matsapp/widgets/Top9Stores/HomeTopStoresWidget.dart';
import 'package:matsapp/widgets/TrendingOffersWidget/TrendingOffersHomePage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    '120143', // id
    'Matsapp', // title
    'Notifications', // description
    importance: Importance.high,
  );
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Position _currentPosition;

  double userLatitude;

  double userLogitude;

  bool isOffline = false;

  SharedPreferences prefs;

  String townSelected;
  String user_dist, user_town;

  String townSelectedStore;

  String mobileNumber;

  int user_id;

  String userMobile;

  String apiKey;
  String userType;

  StreamController<NotificationCountModel> _userController;

  SessionProvider sessionProvider;

  int GreetingId;

  String subtown;

  // RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);

  Future<void> _onRefresh() async {
    loadDetails();
    checkLoginExist();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homePageDataProvider =
          Provider.of<HomePageDataProvider>(context, listen: false);
      homePageDataProvider.getPostData(context, true);

      // if (loginstatus != null) {
      //   if (loginstatus) { dialogesnew(context);}

      // }
    });
  }

  var location;

  bool networkStatus = true;

  //Str _connectionStatus
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  //var connectionStatus;
  String subTown;

  PostDataProvider postMdl;
  HomePageDataProvider homePageDataProvider;

  bool loginstatus = true;
  bool ar = true;

  ConnectivityStatus connectionStatus;
  LoginExistCheckModel sessionStatus;
  AppBar appbar;
  @override
  void initState() {
    super.initState();

    firebaseServices(context).initsetup();

    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    DatabaseHelper dbHelper = new DatabaseHelper();
    // dbHelper.getAll();
    _userController = new StreamController();
    dbHelper.getAll().then((value) => {
          setState(() {
            townSelectedStore = value[0].location;
            user_id = value[0].userid;

            userMobile = value[0].mobilenumber;
            user_dist = value[0].district;
            user_town = value[0].selectedTown;
            subtown = value[0].subtown;
            apiKey = value[0].apitoken;
            userType = value[0].userType;
            loadDetails();
          }),
        });

    SharedPreferences sharedPreferences;
    networkStatus
        ? fetchGreetings().then((value) async => {
              if (value.result != null)
                {
                  if (value.apiKeyStatus)
                    {
                      sharedPreferences = await SharedPreferences.getInstance(),
                      GreetingId =
                          sharedPreferences.getInt('GreetingId' ?? 0) ?? 0,
                      if (GreetingId == null)
                        {
                          if (value.result.grNotifId != 0)
                            {
                              await sharedPreferences.setInt(
                                  'GreetingId', value.result.grNotifId),
                              CommonDialoges().greetingsDialoge(
                                  context, value.result.greetingImage),
                            }
                        }
                      else
                        {
                          if (GreetingId != null)
                            {
                              if (value.result.grNotifId != 0)
                                {
                                  if (GreetingId == value.result.grNotifId ?? 0)
                                    {
                                      // sharedPreferences.remove("GreetingId");
                                    }
                                  else
                                    {
                                      if (value.result.grNotifId != 0)
                                        {
                                          await sharedPreferences.setInt(
                                              'GreetingId',
                                              value.result.grNotifId),
                                          value.result.greetingImage != null ||
                                                  value.result.greetingImage !=
                                                      ""
                                              ? CommonDialoges()
                                                  .greetingsDialoge(
                                                      context,
                                                      value
                                                          .result.greetingImage)
                                              : Container()
                                        }
                                    }
                                }
                            }
                        }
                    }
                  else
                    {Container()}
                }
// ignore: invalid_use_of_visible_for_testing_member
              //SharedPreferences.setMockInitialValues({}),
            })
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    checkLoginExist();
    connectionStatus = Provider.of<ConnectivityStatus>(context);
    checkNetwork();

    appbar = new AppBar(
      centerTitle: true,

      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Container(
                padding:
                    EdgeInsets.only(left: 8.0, right: 10, top: 6, bottom: 6),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.orange[400],
                      size: 16.0,
                    ),
                    SizedBox(width: 2),
                    Text(
                      townSelectedStore ?? "",
                      style: TextStyle(
                        color: Colors.grey[700],
                        letterSpacing: 0.9,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ],
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePageLocation()));
            },
          ),
        ],
      ),
      //titleSpacing: 5,
      iconTheme: IconThemeData(color: AppColors.kAccentColor),
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/images/ic_drawer.svg',
          height: 18,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/notification");
            loadDetails();
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: StreamBuilder<NotificationCountModel>(
                stream: _userController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Badge(
                        showBadge: snapshot.data.result > 0 ? true : false,
                        badgeColor: Colors.orange[400],
                        badgeContent: Text(
                          '${snapshot.data.result}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                        child: ImageIcon(
                            AssetImage('assets/images/ic_notifications.png'),
                            color: Colors.grey));
                  } else {
                    return Container(
                        child: ImageIcon(
                            AssetImage('assets/images/ic_notifications.png'),
                            color: Colors.grey));
                  }
                }),
          ),
        )
      ],
    );
    double screenwidth = MediaQuery.of(context).size.width;
    double screenhight = MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      //key: _scaffoldKey,

      appBar: appbar,
      backgroundColor: Colors.white,
      // drawer: DrawerWidget(userType),
      body: SafeArea(
        child: RefreshIndicator(
          // header: WaterDropHeader(),
          // enablePullDown: true,
          onRefresh: _onRefresh,
          // controller: _refreshController,
          child: WillPopScope(
            onWillPop: () {
              return GeneralTools().exitApp(context);
            },
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return OrientationBuilder(builder: (context, orientation) {
                SizeConfig().init(constraints, orientation, context);
                if (!networkStatus) {
                  return Center(
                    child: Container(
                      width: screenwidth,
                      height: screenhight * .50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/vectors/NoNetwork.svg",
                              width: screenwidth * .20,
                              height: screenhight * .20),
                          Text("You Are Offline",
                              style: TextStyle(
                                  color: AppColors.kAccentColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  );
                } else {
                  checkLocationExist();
                  return homePageWidgets(context);

                  // return FutureBuilder<TownVerifiyModel>(
                  //     future: townverifiyservice(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         if (snapshot.data.result.districtStatus == false) {
                  //           if (snapshot.data.result.townStatus == false) {
                  //             return changeLocationDialog(context);
                  //           } else {
                  //             return homePageWidgets(context);
                  //           }
                  //         } else {
                  //           return homePageWidgets(context);
                  //         }
                  //       } else {
                  //         return Container();
                  //       }
                  //     });
                }
              });
            }),
          ),
        ),
      ),
    );
  }

  Widget homePageWidgets(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenhight = MediaQuery.of(context).size.height - kToolbarHeight;
    final homedata = Provider.of<HomePageDataProvider>(context);
    final sessionStatus = Provider.of<SessionProvider>(context, listen: false);
    // sessionStatus.loginExistCheckModel.

    // Connection check provider
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (homedata != null) {
    //     if (homedata.post.apiKeyStatus == false ?? true) {
    //       CommonDialoges().sessionTimeOutDialoge(context);
    //     }
    //   }
    // });
    //
    return Center(
      child: Container(
          width: screenwidth,
          height: screenhight,
          child: SingleChildScrollView(
              child: Stack(
            children: <Widget>[
              networkStatus
                  ? !homedata.loading
                      ? homedata.post != null
                          ? homedata.post.apiKeyStatus ?? true
                              ? Column(
                                  children: <Widget>[
                                    SizedBox(height: screenhight * 0.02),
                                    SizedBox(child: HomePageTopAddWidget()),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                    ),

                                    homedata.post.hotspot != null
                                        ? homedata.post.hotspot.length == 0
                                            ? Container()
                                            : exclusiveStoresWidget(context)
                                        : Container(),
                                    HomepagCatogoryWidget(),
                                    HomeTopStores(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 20.0, top: 10),
                                      child: HomePageMiddleAd(),
                                    ),

                                    //ExclusiveDealsWidgets(),

                                    TrendingOfferers(),

                                    HotspotsHomeWidgets(),

                                    OfferCategoryPage(homedata.post.offer1,
                                        homedata.post.apiKeyStatus),
                                    HomepageAdwidget3(),

                                    OfferCategoryPage(homedata.post.offer2,
                                        homedata.post.apiKeyStatus),
                                    homedata.post.offer2 != null ?? []
                                        ? homedata.post.offer2.length == 0
                                            ? Container()
                                            : HomepageAdwidget4()
                                        : Container(),

                                    OfferCategoryPage(homedata.post.offer3,
                                        homedata.post.apiKeyStatus),
                                    homedata.post.offer2 != null ?? []
                                        ? homedata.post.offer3.length > 0 &&
                                                homedata.post.offer2.length < 0
                                            ? HomepageAdwidget4()
                                            : Container()
                                        : Container(),

                                    // CategoryPage2(),
                                    // CategoryPage3(),
                                    //HomepageAdwidget3(),
                                    //ExclusiveDealsWidget2(),
                                    //HomepageAdwidget4(),
                                    //HomePageDiscountswidgets(),
                                    HomeBrowsePopularWidget(),
                                  ],
                                )
                              : Container()
                          : Container(
                              child: Center(
                                  child: SpinKitHourGlass(
                                      color: Color(0xffFFB517))),
                              width: screenwidth,
                              height: screenhight,
                            )
                      : HomePageLoader()
                  : Center(
                      child: Container(
                        width: screenwidth,
                        height: screenhight * .50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/vectors/NoNetwork.svg",
                                width: screenwidth * .20,
                                height: screenhight * .20),
                            Text("You Are Offline",
                                style: TextStyle(
                                    color: AppColors.kAccentColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    )
            ],
          ))),
    );
  }

  checkNetwork() {
    connectionStatus == ConnectivityStatus.Cellular ||
            connectionStatus == ConnectivityStatus.WiFi
        ? networkStatus = true
        : networkStatus = false;
  }

  loadDetails() async {
    fetchNotificationsCount(
      userMobile,
      apiKey,
    ).then((res) async {
      _userController.add(res);
      // if (_isDisposed) {

      //   return res;
      // }
      return res;
    });
  }

  Widget exclusiveStoresWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HotspotViewAllWidget()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.lime[100],
            border: Border.all(
                color: AppColors.kAccentColor, // Set border color
                width: 1.0), // Set border width
            borderRadius: BorderRadius.all(
                Radius.circular(15.0)), // Set rounded corner radius
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  color: Colors.amberAccent,
                  offset: Offset(1, 3))
            ] // Make rounded corner of border
            ),
        child: Text("Exclusive Deals of The Day",
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 4,
                color: Colors.brown,
                wordSpacing: 1.5,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              title: Text('Session Expired'),
              actions: <Widget>[
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ],
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      'Your Session Is Expired...!',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkLoginExist() async {
    loginExistCheck().then((value) => {
          if (value.result == "false")
            {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => CommonDialoges().sessionDialog(context))
            }
        });
  }

  void checkLocationExist() async {
    townverifiyservice().then((value) => {
          if (value.result.districtStatus == false)
            {
              if (value.result.townStatus == false)
                {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => changeLocationDialog(context))
                }
            }
        });
  }
}

class LogoutOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LogoutOverlayState();
}

class LogoutOverlayState extends State<LogoutOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(15.0),
              height: 180.0,
              decoration: ShapeDecoration(
                  color: Color.fromRGBO(41, 167, 77, 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 20.0, right: 20.0),
                    child: Text(
                      "Are you sure, you want to logout?",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  )),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ButtonTheme(
                            height: 35.0,
                            minWidth: 110.0,
                            child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              splashColor: Colors.white.withAlpha(40),
                              child: Text(
                                'Logout',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0),
                              ),
                              onPressed: () {
                                // setState(() {
                                //   Route route = MaterialPageRoute(
                                //       builder: (context) => LoginScreen());
                                //   Navigator.pushReplacement(context, route);
                                // });
                              },
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
                          child: ButtonTheme(
                              height: 35.0,
                              minWidth: 110.0,
                              child: RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                splashColor: Colors.white.withAlpha(40),
                                child: Text(
                                  'Cancel',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.0),
                                ),
                                onPressed: () {
                                  setState(() {
                                    /* Route route = MaterialPageRoute(
                                          builder: (context) => LoginScreen());
                                      Navigator.pushReplacement(context, route);
                                   */
                                  });
                                },
                              ))),
                    ],
                  ))
                ],
              )),
        ),
      ),
    );
  }
}
