import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hotlinecafee/Notification/notification.dart';
import 'package:hotlinecafee/Screen/splash.dart';
import 'package:hotlinecafee/ViewModel/home_view_model.dart';
import 'package:hotlinecafee/ViewModel/notification_view_model.dart';
import 'package:hotlinecafee/ViewModel/random_match_view_model.dart';
import 'package:hotlinecafee/screen/earning_screen.dart';
import 'package:hotlinecafee/screen/go_live.dart';

import 'Preference/preference.dart';
import 'ViewModel/Auth_view_model.dart';

Future getFcmToken() async {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  try {
    String? token = await firebaseMessaging.getToken();
    log("=========fcm-token===$token");
    await PreferenceManager.setDeviceId(token!);
    print('**********${PreferenceManager.getDeviceId()}');
    return token;
  } catch (e) {
    log("=========fcm- Error :$e");
    return null;
  }
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await getFcmToken();
  cameras = await availableCameras();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(
      AppNotificationHandler.firebaseMessagingBackgroundHandler);
  IOSInitializationSettings initializationSettings = IOSInitializationSettings(
    requestAlertPermission: true,
    requestSoundPermission: true,
    requestBadgePermission: true,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(AppNotificationHandler.channel);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.initialize(initializationSettings);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(alert: true, badge: true, sound: true);
  AppNotificationHandler.getInitialMsg();
  AppNotificationHandler.onMsgOpen();
  AppNotificationHandler.handleCallNotificationEvent();

  // Update the iOS foreground notification presentation options to allow heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  AppNotificationHandler.showMsgHandler();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: BaseBindings(),
          title: 'Hotline Cafe',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: Splash1(),
        );
      },
    );
  }
}

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel(), fenix: true);
    Get.lazyPut(() => SelectBankController(), fenix: true);
    Get.lazyPut(() => HomeViewModel(), fenix: true);
    Get.lazyPut(() => NotificationViewModel(), fenix: true);
    Get.lazyPut(() => RandomMatchViewModel(), fenix: true);
  }
}
