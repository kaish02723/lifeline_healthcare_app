// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationService {
//   static final FlutterLocalNotificationsPlugin
//   _flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   /// INIT
//   static Future<void> init() async {
//     const AndroidInitializationSettings androidSettings =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     const InitializationSettings settings =
//     InitializationSettings(android: androidSettings);
//
//     await _flutterLocalNotificationsPlugin.initialize(settings);
//   }
//
//   /// SIMPLE NOTIFICATION
//   static Future<void> showNotification() async {
//     const AndroidNotificationDetails androidDetails =
//     AndroidNotificationDetails(
//       'test_channel_id',
//       'Test Notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     const NotificationDetails notificationDetails =
//     NotificationDetails(android: androidDetails);
//
//     await _flutterLocalNotificationsPlugin.show(
//       0,
//       'Hello Dost 👋',
//       'Flutter Local Notification Test 🚀',
//       notificationDetails,
//     );
//   }
// }
