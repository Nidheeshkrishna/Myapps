import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:matsapp/Pages/Providers/ConnectivityServices.dart';
import 'package:matsapp/Pages/Providers/HomeproviderWithOffers.dart';
import 'package:matsapp/Pages/Providers/NetworkProvider.dart';
import 'package:matsapp/constants/app_colors.dart';
import 'package:matsapp/constants/app_routes.dart';
import 'package:matsapp/redux/states/appState.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
// ignore: implementation_imports
import 'package:redux/src/store.dart' show Store;

import 'Pages/Providers/firbaseTokenProvider.dart';
import 'constants/app_constants.dart';
import 'constants/app_style.dart';

class App extends StatefulWidget {
  final Store<AppState> store;

  App(this.store) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     systemNavigationBarColor: Colors.grey, // navigation bar color
    //     statusBarColor: Colors.white10,
    //     // status bar color
    //     statusBarBrightness: Brightness.dark,
    //     statusBarIconBrightness: Brightness.dark, // status bar icons' color
    //     systemNavigationBarIconBrightness: Brightness.dark));
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     systemNavigationBarColor: Colors.grey, // navigation bar color
    //     statusBarColor: Colors.white70,
    //     // status bar color
    //     statusBarBrightness: Brightness.dark,
    //     statusBarIconBrightness: Brightness.dark, // status bar icons' color
    //     systemNavigationBarIconBrightness: Brightness.dark));
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return MultiProvider(
      providers: providers,
      child: new StoreProvider<AppState>(
          store: widget.store,
          child: MaterialApp(
            themeMode: ThemeMode.light,
            darkTheme: ThemeData(
                primarySwatch: AppColors.primarySwatch,
                primaryColor: AppColors.kPrimaryColor,
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  secondary: AppColors.kAccentColor, // Your accent color
                ),
                brightness: Brightness.light,
                // primaryColorDark: Colors.black,
                indicatorColor: Colors.white,
                // canvasColor: Colors.black,

                // next line is important!
                appBarTheme:
                    AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark)),
            debugShowCheckedModeBanner: false,
            title: AppConstants.AppName,
            color: Colors.blueGrey,
            theme: AppTheme().getAppTheme(),
            initialRoute: '/',
            routes: AppRoutes().route,
          )),
    );
  }

  List<SingleChildWidget> providers = [
    ChangeNotifierProvider<HomePageDataProvider>(
        create: (_) => HomePageDataProvider()),
    ChangeNotifierProvider<SessionProvider>(create: (_) => SessionProvider()),
    StreamProvider<ConnectivityStatus>(
        initialData: ConnectivityStatus.Cellular,
        create: (context) =>
            ConnectivityService().connectionStatusController.stream),
    ChangeNotifierProvider<FirbaseTokenProvider>(
        create: (_) => FirbaseTokenProvider()),
  ];
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
