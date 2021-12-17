import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:matsapp/Pages/HomePages/HomePage.dart';

class firebaseServices {
  final BuildContext context;

  firebaseServices(this.context);

  AndroidNotificationChannel channel = AndroidNotificationChannel(
    '120143', // id
    'Matsapp', // title
    'Notifications', // description
    importance: Importance.high,
  );

  initsetup() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    var androidSettings = AndroidInitializationSettings("ic_launcher");
    var iOSSettings = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    Future onClickNotification(String payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
      BuildContext context;
      await Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (context) => HomePage()),
      );
    }

    var initSetttings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onClickNotification);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: "ic_launcher",
              ),
            ));
      }
    });
  }
}
