import 'dart:convert';

import 'package:demo_app/Ui/Message/friends_screen.dart';
import 'package:demo_app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Title: ${message.notification?.title}");
  print("Body ${message.notification?.body}");
  print("Payload: ${message.data}");
}

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  final androidChannel = const AndroidNotificationChannel(
      "high_importance_channel", "High Importance Notification",
      description: "This channel is used for Important Notfication",
      importance: Importance.defaultImportance);

  final localNotifications = FlutterLocalNotificationsPlugin();
  void handleMessage(remoteMessage) {
    if (remoteMessage == null) return;

    navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (context) => FriendListScreen(
              messages: remoteMessage,
            )));
  }

  Future initLocalNotifications() async {
    await localNotifications.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings("@drawable/ic_launcher"),
        ), onDidReceiveNotificationResponse: (details) {
      final message = RemoteMessage.fromMap(jsonDecode(details.payload!));
      handleMessage(message);
    });

    final platform = localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
                androidChannel.id, androidChannel.name,
                channelDescription: androidChannel.description,
                icon: "@drawable/ic_launcher"),
          ),
          payload: jsonEncode(message.toMap()));
    });
  }

  Future<void> initFunction() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    print("Token : $fcmToken");
    // dFDKq5loSUyBgiQ61i9H1R:APA91bHhgRRfQmWS3eBnhI7cGgBUfACo3KXBuh2Fuq6dAvU47m-XT9NmpBQyAtB04I-6RzYPYeMc8sM7BHPXplI_3G--aCFEm-ztAOmEv0CsS8VGjF5JYaSE50S3uQMcd1E7FoV8iJxI
    initPushNotifications();
    initLocalNotifications();
  }
}
