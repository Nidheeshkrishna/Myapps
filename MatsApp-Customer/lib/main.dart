import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matsapp/app.dart';
import 'package:matsapp/redux/store.dart';
import 'package:matsapp/utilities/firebase_util.dart';

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.white,
      // status bar color
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness: Brightness.dark));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  var store = await createStore();
  await setupFirebase();
  // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  runApp(new App(store));
}
