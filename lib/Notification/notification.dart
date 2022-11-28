import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/ViewModel/delete_controller.dart';
import 'package:hotlinecafee/screen/Live/join_live_screen.dart';
import 'package:hotlinecafee/screen/call_user_screen.dart';
import 'package:http/http.dart' as http;

import '../Preference/preference.dart';
import '../custom_package/lib/flutter_callkit_incoming.dart';

Future<void> showCallkitIncoming({required String name, String? image}) async {
  var params = <String, dynamic>{
    'id': '',
    'nameCaller': '$name',
    'appName': 'Hotline',
    'avatar': '${image}',
    'handle': '',
    'type': 0,
    'duration': 30000,
    'textAccept': 'Accept',
    'textDecline': 'Reject',
    'textMissedCall': 'Missed call',
    'textCallback': 'Call back',
    'extra': <String, dynamic>{'userId': '1a2b3c4d'},
    'headers': <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
    'android': <String, dynamic>{
      'isCustomNotification': true,
      'isShowLogo': false,
      'isShowCallback': false,
      'ringtonePath': 'system_ringtone_default',
      'backgroundColor': '#1E1E1E',
      'background': '#1E1E1E',
      'actionColor': ''
    },
  };
  await FlutterCallkitIncoming.showCallkitIncoming(params);
}

class AppNotificationHandler {
  // static LiveController liveController = Get.put(LiveController());
  static StateController stateController = Get.put(StateController());
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true,
  );

  /// Call Event handler

  static void handleCallNotificationEvent(
      {String? name,
      String? token,
      String? userName,
      String? userImage,
      String? userId,
      String? secondId}) {
    log('₹₹');
    FlutterCallkitIncoming.onEvent.listen(
      (event) {
        switch (event!.name) {
          case CallEvent.ACTION_CALL_INCOMING:
            print('received an incoming call');

            break;
          case CallEvent.ACTION_CALL_START:
            print('started an outgoing call');

            break;
          case CallEvent.ACTION_CALL_ACCEPT:
            print(
                'accepted an incoming call++++++++++++++++++++++++++++++++++++');
            _answerIncomingCall(
                name: name,
                token: token,
                userName: userName,
                userImage: userImage,
                userId: userId,
                secondId: secondId);
            break;
          case CallEvent.ACTION_CALL_DECLINE:
            print(
                'declined an incoming call------------------------------------');
            _disconnectCall();
            break;
          case CallEvent.ACTION_CALL_ENDED:
            print('ended an incoming/outgoing call');
            break;
          case CallEvent.ACTION_CALL_TIMEOUT:
            print('missed an incoming call');
            break;
          case CallEvent.ACTION_CALL_CALLBACK:
            print(
                "only Android - click action `Call back` from missed call notification");
            break;
          case CallEvent.ACTION_CALL_TOGGLE_HOLD:
            // TODO: only iOS
            break;
          case CallEvent.ACTION_CALL_TOGGLE_MUTE:
            // TODO: only iOS
            break;
          case CallEvent.ACTION_CALL_TOGGLE_DMTF:
            // TODO: only iOS
            break;
          case CallEvent.ACTION_CALL_TOGGLE_GROUP:
            // TODO: only iOS
            break;
          case CallEvent.ACTION_CALL_TOGGLE_AUDIO_SESSION:
            // TODO: only iOS
            break;
          case CallEvent.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
            // TODO: only iOS
            break;
        }
      },
    );
  }

  ///call when app is Open

  static void showMsgHandler() {
    print('call when app in fore ground');
    try {
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage? message) {
          RemoteNotification? notification = message!.notification;
          log('notificationnotification 2>> ${message}');
          log('notificationnotification data>> ${message.data}');
          var data = jsonDecode(notification!.body!);
          if (data['msg'].toString().contains('Following You') ||
              data['channelName'].toString().contains('streaming') ||
              data['msg'].toString().contains('Send Gift You')) {
            // showMsgNormal(notification);
          } else {
            handleCallNotificationEvent(
              token: data['token'],
              userImage: data['profile_pic'],
              name: data['channelName'],
              userName: data['name'],
              userId: data['user_id'],
              secondId: data['caller_id'],
            );
            showMsg(notification);
          }
        },
      );
    } on FirebaseException catch (e) {
      print('notification 6 ${e.message}');
    }
  }

  static void showMsgNormal(RemoteNotification notification) {
    print('MESSAGE NORMAL SHOW');

    try {
      var data = jsonDecode(notification.body!);
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        data['channelName'].toString().contains('streaming')
            ? '${data['name']} Stated Live Streaming'
            : notification.title,
        '',
        // data['msg'],

        ///default
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel', // id
            'High Importance Notifications', // title
            importance: Importance.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: IOSNotificationDetails(),
        ),
      );
      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: AndroidInitializationSettings("@drawable/ic_launcher"),
        iOS: IOSInitializationSettings(
          requestAlertPermission: true,
          requestSoundPermission: true,
          requestBadgePermission: true,
        ),
      );
      if (data['channelName'].toString().contains('streaming')) {
        flutterLocalNotificationsPlugin.initialize(
          initializationSettings,
          onSelectNotification: (payload) async {
            Get.to(
              () => JoinLivePage(
                userId: '${data['user_id']}',
                channelName: '${data['channelName']}',
                channelToken: '${data['token']}',
                hostName: '${data['name']}',
                hostImage: '${data['profile_pic']}',
                username: PreferenceManager.getUserName(),
                userImage: 'https://wallpapercave.com/fwp/wp7027819.jpg',
                channelId: int.parse(
                  data['user_id'],
                ),
              ),
            );
          },
        );
      }
    } on FirebaseException catch (e) {
      print('notification 3 ${e.message}');
    }
  }

  static void getInitialMsg() {
    print('handle notification when app in fore ground..///close app');
    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        print('------RemoteMessage message------$message');

        if (message != null) {
          //  FlutterRingtonePlayer.stop();

          print("action======1=== ${message.data['action_click']}");
          print("slug======2=== ${message.data['slug_name']}");
        }
      },
    );
  }

  static void showMsg(RemoteNotification notification) {
    print('showMsg showMsg==>showMsg');

    try {
      var data = jsonDecode(notification.body!);

      print('show msg');
      print('NOTIFICATION BODY:- ${notification.body}');
      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: AndroidInitializationSettings("@drawable/ic_launcher"),
        iOS: IOSInitializationSettings(
          requestAlertPermission: true,
          requestSoundPermission: true,
          requestBadgePermission: true,
        ),
      );

      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: (payload) async {});
      flutterLocalNotificationsPlugin.show(
        0,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel', // id
            'High Importance Notifications', // title
            importance: Importance.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: IOSNotificationDetails(),
        ),
      );

      if (data['msg'].toString().contains('Following You') ||
          data['channelName'].toString().contains('streaming')) {
        print('ShowNormalMassage1');
        // showMsgNormal(notification);
      } else {
        showCallkitIncoming(
            name: '${data['name']}', image: '${data['profile_pic']}');
        handleCallNotificationEvent(
            token: data['token'],
            userImage: data['profile_pic'],
            name: data['channelName'],
            userName: data['name'],
            userId: data['user_id'],
            secondId: data['caller_id']);
        // showMsg(notification);
      }
    } on FirebaseException catch (e) {
      print('notification 4 ${e.message}');
    }
  }

  ///background notification handler..  when app in background

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    try {
      print('background notification handler..');
      await Firebase.initializeApp();
      print('Handling a background message ${message.messageId}');
      RemoteNotification? notification = message.notification;
      print('=========== NOTIFICATION ============ ${notification}');
    } on FirebaseException catch (e) {
      print('notification 1 ${e.message}');
    }
  }

  ///call when click on notification back

  static void onMsgOpen() {
    print('call when click on notification back');
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        print('listen->${message.data}');

        if (message.notification != null) {
          // print("action======1=== ${message?.data['action_click']}");
          print("action======2=== ${message.data['action_click']}");
        }
      },
    );
  }

  /// send notification device to device

  static Future<bool?> sendMessage({
    String? receiverFcmToken,
    String? msg,
  }) async {
    var serverKey =
        'AAAA0xnu8Ac:APA91bGmW8-AiI5b7tOG6i5lNJlIYr1b1oEqxge45bkoo4mkLv2n3v_KOd64YmkV4re7ugdcKmsFGccLa2GtTdRWDOdudYCwdRoxF3lxkT1MaMWDZ8G2NcYdca5Me3PrvKD7ObwCviD8';

    try {
      // for (String token in receiverFcmToken) {
      log("RESPONSE TOKEN  $receiverFcmToken");

      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': msg,
              'title': 'Messaging',
              'bodyLocKey': 'true',
            },
            'priority': 'high',
            'to': receiverFcmToken,
          },
        ),
      );
      log("RESPONSE CODE ${response.statusCode}");

      log("RESPONSE BODY ${response.body}");
      // return true;
    } catch (e) {
      print("error push notification");
      // return false;
    }
    return null;
  }

  static void _answerIncomingCall(
      {String? name,
      String? token,
      String? userName,
      String? userImage,
      String? userId,
      String? secondId}) {
    // liveController.audience();
    log('===== ACCEPT CALL =====');
    Get.to(
      () => CallUserScreen(
        channelName: name,
        channelToken: token,
        userImage: userImage,
        followers: '',
        userId: '${userId}',
        secondUserId: '${secondId}',
        // userType: liveController.isBrodCaster.value,
        userName: userName,
      ),
    );

    print('VIDEO CALL TOKEN ${token}');
  }

  static void _disconnectCall() {
    print('CALLS REJECTED');
    Get.back();
  }
}

// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:hotlinecafeee/ViewModel/brodcast_controller.dart';
// import 'package:hotlinecafeee/ViewModel/delete_controller.dart';
// import 'package:hotlinecafeee/screen/Live/join_live_screen.dart';
// import 'package:hotlinecafeee/screen/call_user_screen.dart';
// import 'package:http/http.dart' as http;
//
// import '../Preference/preference.dart';
// import '../custom_package/lib/flutter_callkit_incoming.dart';
//
// Future<void> showCallkitIncoming({required String name, String? image}) async {
//   var params = <String, dynamic>{
//     'id': '',
//     'nameCaller': '$name',
//     'appName': 'Hotline',
//     'avatar': '${image}',
//     'handle': '',
//     'type': 0,
//     'duration': 30000,
//     'textAccept': 'Accept',
//     'textDecline': 'Reject',
//     'textMissedCall': 'Missed call',
//     'textCallback': 'Call back',
//     'extra': <String, dynamic>{'userId': '1a2b3c4d'},
//     'headers': <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
//     'android': <String, dynamic>{
//       'isCustomNotification': true,
//       'isShowLogo': false,
//       'isShowCallback': false,
//       'ringtonePath': 'system_ringtone_default',
//       'backgroundColor': '#1E1E1E',
//       'background': '#1E1E1E',
//       'actionColor': ''
//     },
//   };
//   await FlutterCallkitIncoming.showCallkitIncoming(params);
// }
//
// class AppNotificationHandler {
//   static LiveController liveController = Get.put(LiveController());
//   static StateController stateController = Get.put(StateController());
//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   static AndroidNotificationChannel channel = const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     importance: Importance.high,
//     playSound: true,
//   );
//
//   /// Call Event handler
//
//   static void handleCallNotificationEvent(
//       {String? name, String? token, String? userName, String? userImage}) {
//     FlutterCallkitIncoming.onEvent.listen(
//       (event) {
//         switch (event!.name) {
//           case CallEvent.ACTION_CALL_INCOMING:
//             print('received an incoming call');
//
//             break;
//           case CallEvent.ACTION_CALL_START:
//             print('started an outgoing call');
//
//             break;
//           case CallEvent.ACTION_CALL_ACCEPT:
//             print(
//                 'accepted an incoming call++++++++++++++++++++++++++++++++++++');
//             _answerIncomingCall(
//                 name: name,
//                 token: token,
//                 userName: userName,
//                 userImage: userImage);
//             break;
//           case CallEvent.ACTION_CALL_DECLINE:
//             print(
//                 'declined an incoming call------------------------------------');
//             _disconnectCall();
//             break;
//           case CallEvent.ACTION_CALL_ENDED:
//             print('ended an incoming/outgoing call');
//             break;
//           case CallEvent.ACTION_CALL_TIMEOUT:
//             print('missed an incoming call');
//             break;
//           case CallEvent.ACTION_CALL_CALLBACK:
//             print(
//                 "only Android - click action `Call back` from missed call notification");
//             break;
//           case CallEvent.ACTION_CALL_TOGGLE_HOLD:
//             // TODO: only iOS
//             break;
//           case CallEvent.ACTION_CALL_TOGGLE_MUTE:
//             // TODO: only iOS
//             break;
//           case CallEvent.ACTION_CALL_TOGGLE_DMTF:
//             // TODO: only iOS
//             break;
//           case CallEvent.ACTION_CALL_TOGGLE_GROUP:
//             // TODO: only iOS
//             break;
//           case CallEvent.ACTION_CALL_TOGGLE_AUDIO_SESSION:
//             // TODO: only iOS
//             break;
//           case CallEvent.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
//             // TODO: only iOS
//             break;
//         }
//       },
//     );
//   }
//
//   ///call when app in fore ground
//
//   static void showMsgHandler() {
//     print('call when app in fore ground');
//     try {
//       FirebaseMessaging.onMessage.listen(
//         (RemoteMessage? message) {
//           RemoteNotification? notification = message?.notification;
//
//           var data = jsonDecode(notification!.body!);
//           if (data['msg'].toString().contains('Following You') ||
//               data['channelName'].toString().contains('streaming')) {
//             print(
//                 'messagemessagemessagemessage1>>>>>>>>   ${data['msg']} channelName :-  ${data['channelName']}  BODY :- ${notification.body!}   TITLE :- ${notification.title!}');
//
//             showMsgNormal(message!.notification!);
//           } else {
//             print(
//                 'messagemessagemessagemessage>>>>>>>>   ${data['msg']} channelName :-  ${data['channelName']}  BODY :- ${notification.body!}   TITLE :- ${notification.title!}');
//             handleCallNotificationEvent(
//                 token: data['token'],
//                 userImage: data['profile_pic'],
//                 name: data['channelName'],
//                 userName: data['name']);
//             showMsg(notification);
//           }
//         },
//       );
//     } on FirebaseException catch (e) {
//       print('notification 6 ${e.message}');
//     }
//   }
//
//   static void showMsgNormal(RemoteNotification notification) {
//     print('MESSAGE NORMAL SHOW');
//     try {
//       var data = jsonDecode(notification.body!);
//       flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         data['channelName'].toString().contains('streaming')
//             ? '${data['name']} Stated Live Streaming'
//             : notification.title,
//         data['msg'],
//
//         ///default
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             'high_importance_channel', // id
//             'High Importance Notifications', // title
//             importance: Importance.high,
//             icon: '@mipmap/ic_launcher',
//           ),
//           iOS: IOSNotificationDetails(),
//         ),
//       );
//       const InitializationSettings initializationSettings =
//           InitializationSettings(
//         android: AndroidInitializationSettings("@drawable/ic_launcher"),
//         iOS: IOSInitializationSettings(
//           requestAlertPermission: true,
//           requestSoundPermission: true,
//           requestBadgePermission: true,
//         ),
//       );
//       if (data['channelName'].toString().contains('streaming')) {
//         flutterLocalNotificationsPlugin.initialize(
//           initializationSettings,
//           onSelectNotification: (payload) async {
//             Get.to(
//               () => JoinLivePage(
//                 channelName: '${data['channelName']}',
//                 channelToken: '${data['token']}',
//                 hostName: '${data['name']}',
//                 hostImage: '${data['profile_pic']}',
//                 username: PreferenceManager.getUserName(),
//                 userImage: 'https://wallpapercave.com/fwp/wp7027819.jpg',
//                 channelId: int.parse(data['user_id']),
//               ),
//             );
//           },
//         );
//       }
//     } on FirebaseException catch (e) {
//       print('notification 3 ${e.message}');
//     }
//   }
//
//   /// handle notification when app in fore ground..///close app
//
//   static void getInitialMsg() {
//     print('handle notification when app in fore ground..///close app');
//     FirebaseMessaging.instance.getInitialMessage().then(
//       (RemoteMessage? message) {
//         print('------RemoteMessage message------$message');
//
//         if (message != null) {
//           //  FlutterRingtonePlayer.stop();
//
//           print("action======1=== ${message.data['action_click']}");
//           print("slug======2=== ${message.data['slug_name']}");
//         }
//       },
//     );
//   }
//
//   ///show notification msg when app is running
//
//   static void showMsg(RemoteNotification notification) {
//     print('showMsg showMsg==>showMsg');
//
//     try {
//       var data = jsonDecode(notification.body!);
//
//       print('show msg');
//       print('NOTIFICATION BODY:- ${notification.body}');
//       const InitializationSettings initializationSettings =
//           InitializationSettings(
//         android: AndroidInitializationSettings("@drawable/ic_launcher"),
//         iOS: IOSInitializationSettings(
//           requestAlertPermission: true,
//           requestSoundPermission: true,
//           requestBadgePermission: true,
//         ),
//       );
//
//       flutterLocalNotificationsPlugin.initialize(initializationSettings,
//           onSelectNotification: (payload) async {});
//       flutterLocalNotificationsPlugin.show(
//         0,
//         notification.title,
//         notification.body,
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'high_importance_channel', // id
//             'High Importance Notifications', // title
//             importance: Importance.high,
//             icon: '@mipmap/ic_launcher',
//           ),
//           iOS: IOSNotificationDetails(),
//         ),
//       );
//
//       if (data['msg'].toString().contains('Following You') ||
//           data['channelName'].toString().contains('streaming')) {
//         print('ShowNormalMassage1');
//         // showMsgNormal(notification);
//       } else {
//         showCallkitIncoming(
//             name: '${data['name']}', image: '${data['profile_pic']}');
//         handleCallNotificationEvent(
//             token: data['token'],
//             userImage: data['profile_pic'],
//             name: data['channelName'],
//             userName: data['name']);
//         // showMsg(notification);
//       }
//     } on FirebaseException catch (e) {
//       print('notification 4 ${e.message}');
//     }
//   }
//
//   ///background notification handler..  when app in background
//
//   static Future<void> firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     try {
//       print('background notification handler..');
//       await Firebase.initializeApp();
//       print('Handling a background message ${message.messageId}');
//       RemoteNotification? notification = message.notification;
//     } on FirebaseException catch (e) {
//       print('notification 1 ${e.message}');
//     }
//   }
//
//   ///call when click on notification back
//
//   static void onMsgOpen() {
//     print('call when click on notification back');
//     FirebaseMessaging.onMessageOpenedApp.listen(
//       (RemoteMessage message) {
//         print('A new onMessageOpenedApp event was published!');
//         print('listen->${message.data}');
//
//         if (message.notification != null) {
//           // print("action======1=== ${message?.data['action_click']}");
//           print("action======2=== ${message.data['action_click']}");
//         }
//       },
//     );
//   }
//
//   /// send notification device to device
//
//   static Future<bool?> sendMessage({
//     String? receiverFcmToken,
//     String? msg,
//   }) async {
//     var serverKey =
//         'AAAA0xnu8Ac:APA91bGmW8-AiI5b7tOG6i5lNJlIYr1b1oEqxge45bkoo4mkLv2n3v_KOd64YmkV4re7ugdcKmsFGccLa2GtTdRWDOdudYCwdRoxF3lxkT1MaMWDZ8G2NcYdca5Me3PrvKD7ObwCviD8';
//
//     try {
//       // for (String token in receiverFcmToken) {
//       log("RESPONSE TOKEN  $receiverFcmToken");
//
//       http.Response response = await http.post(
//         Uri.parse('https://fcm.googleapis.com/fcm/send'),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Authorization': 'key=$serverKey',
//         },
//         body: jsonEncode(
//           <String, dynamic>{
//             'notification': <String, dynamic>{
//               'body': msg,
//               'title': 'Messaging',
//               'bodyLocKey': 'true',
//             },
//             'priority': 'high',
//             'to': receiverFcmToken,
//           },
//         ),
//       );
//       log("RESPONSE CODE ${response.statusCode}");
//
//       log("RESPONSE BODY ${response.body}");
//       // return true;
//     } catch (e) {
//       print("error push notification");
//       // return false;
//     }
//     return null;
//   }
//
//   static void _answerIncomingCall(
//       {String? name, String? token, String? userName, String? userImage}) {
//     liveController.audience();
//     log('===== ACCEPT CALL =====');
//     Get.to(
//       () => CallUserScreen(
//         channelName: name,
//         channelToken: token,
//         userImage: userImage,
//         userType: liveController.isBrodCaster.value,
//         userName: userName,
//       ),
//     );
//
//     print('VIDEO CALL TOKEN ${token}');
//   }
//
//   static void _disconnectCall() {
//     print('CALLS REJECTED');
//     Get.back();
//   }
// }
