import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firetoken/model/notification_model.dart';
import 'package:firetoken/services/database_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class FirebaseService {
  // Singleton pattern
  FirebaseService._privateConstructor();
  static final FirebaseService _instance =
      FirebaseService._privateConstructor();
  static FirebaseService get instance => _instance;

  // Initialize Firebase and request permissions
  Future<void> initializeFirebase() async {
    await _requestNotificationPermissions();
    startListeningForNotifications();
  }

  // Request notification permissions with user-friendly messages
  Future<void> _requestNotificationPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    try {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      switch (settings.authorizationStatus) {
        case AuthorizationStatus.authorized:
          // User granted permission
          break;
        case AuthorizationStatus.provisional:
          // User granted provisional permission
          break;
        default:
          _showAlert(
            "Notifications Disabled",
            "Please enable notifications in your settings to receive updates from us.",
          );
          break;
      }
    } catch (_) {
      _showAlert(
        "Permission Request Failed",
        "We encountered an issue requesting notification permissions. Please check your settings.",
      );
    }
  }

  // Generate and manage FCM token (also works for APNs)
  Future<String?> generateToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    try {
      // Retrieve the token (FCM token for Android, APNs token for iOS)
      String? token = defaultTargetPlatform == TargetPlatform.iOS
          ? await messaging.getAPNSToken()
          : await messaging.getToken();
      return token; // Return the token directly
    } catch (e) {
      _showAlert(
        "Token Retrieval Error",
        "An error occurred while fetching your notification token. Please check your internet connection and try again.",
      );
      return null; // Return null in case of an exception
    }
  }

  // Start listening for notifications
  void startListeningForNotifications() {
    // When the app is terminated and it receives a push notification
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMsg) {
      if (remoteMsg != null) {
        // Add your logic for handling the notification when the app is terminated
        _handleNotification(remoteMsg);
      }
    });

    // When the app is in the foreground and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMsg) {
      // Add your logic for handling the notification when the app is in the foreground
      _handleNotification(remoteMsg);
    });

    // When the app is in the background and it receives a push notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMsg) {
      // Add your logic for handling the notification when the app is in the background

      _handleNotification(remoteMsg);
    });
  }

  // Handle incoming notification
  Future<void> _handleNotification(RemoteMessage remoteMsg) async {
    // Here you can handle the notification data
    await DatabaseHelper.saveNotificationPost(
        NotificationModel.fromJson(remoteMsg.toMap()));
    // Implement your own logic for navigating or updating UI based on the notification
  }

  // User-friendly alert dialog for error messages
  void _showAlert(String title, String message) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      textCancel: 'Cancel',
      textConfirm: 'OK',
      onConfirm: () {
        // Action to perform when the 'OK' button is pressed
        Get.back(); // Close the dialog
      },
    );
  }
}
