import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:red_flag/data/services/user_data.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();

}
class NotificationManager {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static const String _authServerKey = ''; 

    static Future initialize() async {
      if (Platform.isIOS) {
      _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      ); 
      }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message data: ${message.data}');

      if (message.notification != null) {
        // print('Message also contained a notification: ${message.notification}');
      }
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data.isNotEmpty) {
        // _serializeAndNavigate(message.data);
      }
    });

     _fcm.onTokenRefresh.listen((newToken) {
      if (FirebaseAuth.instance.currentUser != null) {
        // final userID = FirebaseAuth.instance.currentUser?.uid;
        FirebaseFirestore.instance
            .collection('users')
            .doc(UserData.getUserId())
            .update({'notificationtoken': newToken});
      }
    });
  }

    );
    }
}