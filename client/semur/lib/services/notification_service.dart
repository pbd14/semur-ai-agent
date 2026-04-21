import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/helpers/platform/platform_info.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:semur/services/push_notification_message_model.dart';

class NotificationService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    Log.d("Initializing Notification Service");
    try {
      if (kIsWeb) {
      } else {
        await firebaseMessaging.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );

        final fcmToken = await firebaseMessaging.getToken();
        if (fcmToken != null) {
          if (PlatformInfo.isAndroid &&
              !AppUser.user.fcmAndroidTokens.contains(fcmToken)) {
            await Application.firestore
                .collection('users')
                .doc(AppUser.user.id)
                .update({
                  'fcmAndroidTokens': [fcmToken],
                });
          }
          if (PlatformInfo.isIOS &&
              !AppUser.user.fcmIosTokens.contains(fcmToken)) {
            await Application.firestore
                .collection('users')
                .doc(AppUser.user.id)
                .update({
                  'fcmIosTokens': [fcmToken],
                });
          }
        } else {
          Log.e("Notification Service Error: Token null");
        }

        // Token Stream
        FirebaseMessaging.instance.onTokenRefresh
            .listen((fcmToken) async {
              if (PlatformInfo.isAndroid &&
                  !AppUser.user.fcmAndroidTokens.contains(fcmToken)) {
                await Application.firestore
                    .collection('users')
                    .doc(AppUser.user.id)
                    .update({
                      'fcmAndroidTokens': [fcmToken],
                    });
              }
              if (PlatformInfo.isIOS &&
                  !AppUser.user.fcmIosTokens.contains(fcmToken)) {
                await Application.firestore
                    .collection('users')
                    .doc(AppUser.user.id)
                    .update({
                      'fcmIosTokens': [fcmToken],
                    });
              }
            })
            .onError((err) {
              Log.e("Notification Service Error", err);
            });

        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          if (message.notification != null) {
            // Message Stream
            String messageBody = "";
            try {
              switch (Application.language) {
                case "en":
                  messageBody =
                      json.decode(message.data["descriptionJSON"])["en"] ??
                      message.notification!.body!;
                  break;
                case "ru":
                  messageBody =
                      json.decode(message.data["descriptionJSON"])["ru"] ??
                      message.notification!.body!;
                  break;
                case "uz":
                  messageBody =
                      json.decode(message.data["descriptionJSON"])["uz"] ??
                      message.notification!.body!;
                  break;
                default:
                  messageBody = message.notification!.body!;
              }
            } catch (e) {
              messageBody = message.notification!.body!;
            }
            showNotification(messageBody, NotificationType.info);
          }
        });
      }
      Log.i("Notification Service Initialized");
    } catch (e) {
      Log.e("Notification Service Error", e);
    }
  }
}

void showNotification(String text, NotificationType type) {
  PushNotificationMessage notification = PushNotificationMessage(
    title: titleFromNotificationType(type),
    body: text,
  );
  showSimpleNotification(
    Text(
      notification.body,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    ),
    slideDismissDirection: DismissDirection.up,
    subtitle: Text(
      notification.title,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
    position: NotificationPosition.top,
    background: colorFromNotificationType(type),
  );
}

String titleFromNotificationType(NotificationType type) {
  switch (type) {
    case NotificationType.info:
      return Application.appLocalizations!.info;
    case NotificationType.warning:
      return Application.appLocalizations!.warning;
    case NotificationType.error:
      return Application.appLocalizations!.error;
    case NotificationType.success:
      return Application.appLocalizations!.success;
  }
}

Color colorFromNotificationType(NotificationType type) {
  switch (type) {
    case NotificationType.info:
      return Colors.blue;
    case NotificationType.warning:
      return Colors.orange;
    case NotificationType.error:
      return Colors.red;
    case NotificationType.success:
      return AppColors.greenColor;
  }
}

enum NotificationType { info, warning, error, success }
