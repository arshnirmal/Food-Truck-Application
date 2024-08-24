import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_truck/utils/secure_storage.dart';

class NotificationService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> requestNotificationPermissions() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> initLocalNotification() async {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: (details) {
        log("onDidReceiveNotificationResponse: $details");
      },
      onDidReceiveBackgroundNotificationResponse: (details) {
        log("onDidReceiveBackgroundNotificationResponse: $details");
      },
    );
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(
          const AndroidNotificationChannel(
            'high_importance_channel',
            'High Importance Notifications',
            description: 'This channel is used for important notifications.',
            enableVibration: true,
            showBadge: true,
            playSound: true,
            importance: Importance.high,
          ),
        );
  }

  Future<void> initFirebaseMessaging() async {
    await messaging.setAutoInitEnabled(true);
    final fcmToken = await messaging.getToken();
    await SecureStorage().saveFCMToken(fcmToken ?? '');
    log("FCMToken $fcmToken");

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        showNotification(message);
      }
    });
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    log('Handling a background message ${message.messageId}');
  }

  Future<void> showNotification(RemoteMessage message) async {
    final notification = message.notification;
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      notification?.android?.channelId.toString() ?? 'high_importance_channel',
      notification?.android?.channelId.toString() ?? 'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      enableVibration: true,
      showBadge: true,
      playSound: true,
      importance: Importance.high,
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      importance: channel.importance,
      playSound: channel.playSound,
      enableVibration: channel.enableVibration,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
      showProgress: false,
      priority: Priority.high,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      notification?.title ?? 'Title',
      notification?.body ?? 'Body',
      platformChannelSpecifics,
      payload: message.data.toString(),
    );
  }

  void tokenRefresh() {
    messaging.onTokenRefresh.listen((String? token) {
      log("onTokenRefresh: $token");
    });
  }

  Future<void> killNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    await messaging.deleteToken();
  }
}
