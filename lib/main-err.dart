// // ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, avoid_print
 
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:sales_point/Cfg/sess.dart';
// import 'package:sales_point/Views/login.dart'; 
// import 'package:sales_point/Views/main-page.dart'; 

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await setupFlutterNotifications();
//   showFlutterNotification(message);
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   print ('Handling a background message ${message.messageId}');
// }

// /// Create a [AndroidNotificationChannel] for heads up notifications
// late AndroidNotificationChannel channel; 

// bool isFlutterLocalNotificationsInitialized = false;

// Future<void> setupFlutterNotifications() async {
//   if (isFlutterLocalNotificationsInitialized) {
//     return;
//   }
//   channel =     const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//      'This channel is used for important notifications.', // description
//      importance: Importance.high,
//   );
  
//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   /// Create an Android Notification Channel.
//   ///
//   /// We use this channel in the `AndroidManifest.xml` file to override the
//   /// default FCM channel to enable heads up notifications.
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   /// Update the iOS foreground notification presentation options to allow
//   /// heads up notifications.
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   isFlutterLocalNotificationsInitialized = true;
// }

// void showFlutterNotification(RemoteMessage message) {
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//   if (notification != null && android != null && !kIsWeb) {
//     flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channel.description, 
//           //      one that already exists in example app.
//           icon: 'launch_background',
//         ),
//       ),
//     );
//   }
// }

// /// Initialize the [FlutterLocalNotificationsPlugin] package.
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await Firebase.initializeApp( name: 'Firebase.init main()'  );
//   // Set the background messaging handler early on, as a named top-level function
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   if (!kIsWeb) {
//     await setupFlutterNotifications();
//   }

//   runApp(const MyApp()); 
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyApp createState()=> _MyApp();
// }

// class _MyApp extends State<MyApp> {

//   Sess sess = Sess();
//   String? email;
   
//   @override
//   void initState() { 
//     super.initState();
//     sess.getSess('email').then((value) => setState(() => email = value,));
//   }

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     // return MaterialApp(
//       return GetMaterialApp(
//       title: 'Reseller/ Sales Point',
//       theme: ThemeData( 
//         primarySwatch: Colors.yellow,
//       ),
//       home: (email == null) ? const Login() : const MyHomePage(), 
//     );
//   }

// } 