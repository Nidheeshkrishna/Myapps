import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:matsapp/utilities/GerneralTools.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Messages $message.notification");
  //demoNotification(message);
  //_showNotificationWithDefaultSound("Hello", "Mats App");
  await Firebase.initializeApp();
}

Future _showNotificationWithDefaultSound(String title, String message) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'mats_app_channel_general_id', 'Mats App', 'Matsapp notifications',
      importance: Importance.max, priority: Priority.high);

  var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
  var IOS = new IOSInitializationSettings();
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    1,
    '$title',
    '$message',
    platformChannelSpecifics,
    payload: 'Default_Sound',
  );
}

Future<void> demoNotification(RemoteMessage message) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'mats_app_channel_general_id', 'Mats App', 'Matsapp notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'test ticker');

  var iOSChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
      0, message.notification.title, message.from, platformChannelSpecifics,
      payload: 'test oayload');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'mats_app_channel_general_id', // id
  'Mats App', // title
  'Matsapp notifications', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

setupFirebase() async {
  await Firebase.initializeApp();

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  _firebaseMessaging.getToken().then((token) {
    print("FirebaseToken : $token");

    GeneralTools().apiTokenPreferance(token);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}
