import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/ViewModel/view_profile_view_model.dart';
import 'package:hotlinecafee/common/chat_commons.dart';
import 'package:hotlinecafee/common/loading.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:hotlinecafee/model/response_model/view_profile_res_model.dart';
import 'package:hotlinecafee/model/services/chat_room_service.dart';
import 'package:hotlinecafee/screen/chat/chat_room.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ViewProfileViewModel viewProfileViewModel = Get.put(ViewProfileViewModel());
  ViewProfileResponseModel viewProfileResponseModel =
      ViewProfileResponseModel();
  String searchText = '';
  TextEditingController search = TextEditingController();

  String roomId = '';

  void initState() {
    viewProfileViewModel.apiResponseClear();
    // x.clear();
    viewProfileViewModel.getDataFromFirebase();
    print('xxx====> ${viewProfileViewModel.x.length}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('CURRENT BALANCE :-  ${PreferenceManager.getCurrentBalance()}');

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: GetBuilder<ViewProfileViewModel>(
          builder: (controller) {
            print('controller---${controller.apiResponse.status}');
            List<ViewProfileResponseModel> info = viewProfileViewModel.x;
            print("length======>${info.length}");
            print("Text======>${searchText}");
            if (searchText.isNotEmpty) {
              info = info.where((element) {
                return element.data!.name!
                    .toLowerCase()
                    .contains(searchText.toLowerCase());
              }).toList();
            }

            return SafeArea(
              child: Container(
                margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Chat',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.lock,
                              color: Color(0Xff4F4F5B),
                              size: 15,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              'End-to-End Encrypted',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(0Xff4F4F5B)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      height: 48,
                      child: TextField(
                        controller: search,
                        onChanged: (val) {
                          setState(() {
                            searchText = search.text;
                          });
                        },
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Color(0xff81818A)),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff81818A)),
                              borderRadius: BorderRadius.circular(30)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff81818A)),
                              borderRadius: BorderRadius.circular(30)),
                          hintStyle: TextStyle(color: Color(0xff81818A)),
                          suffixIcon: Icon(
                            Icons.search,
                            color: Color(0xff81818A),
                          ),
                          hintText: 'Search friends',
                        ),
                      ),
                    ),
                    Expanded(
                      child: controller.apiResponse.status == Status.COMPLETE
                          ? viewProfileViewModel.x.length == 0
                              ? Center(
                                  child: Text('No chat user',
                                      style: TextStyle(color: Colors.white)),
                                )
                              : ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: info.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var user1 =
                                        '${viewProfileViewModel.x[index].data!.userId}';
                                    var user2 =
                                        '${PreferenceManager.getUserId()}';
                                    var x = int.parse(user1) > int.parse(user2)
                                        ? "$user2$user1"
                                        : "$user1$user2";

                                    return StreamBuilder(
                                      stream: firebaseFirestore
                                          .collection("chatroom")
                                          .doc(x)
                                          .collection('chat')
                                          .orderBy('time', descending: true)
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<
                                                  QuerySnapshot<
                                                      Map<String, dynamic>>>
                                              snap) {
                                        if (snap.hasData) {
                                          Timestamp time1 =
                                              snap.data!.docs[0]['time'];
                                          DateTime myDateTime =
                                              time1.toDate(); // Time

                                          var time2 = DateTime.now();
                                          var time3 = time2
                                                      .difference(myDateTime)
                                                      .inSeconds >
                                                  60
                                              ? time2
                                                          .difference(
                                                              myDateTime)
                                                          .inMinutes >
                                                      60
                                                  ? time2
                                                              .difference(
                                                                  myDateTime)
                                                              .inHours >
                                                          24
                                                      ? '${time2.difference(myDateTime).inDays}d'
                                                      : '${time2.difference(myDateTime).inHours}h'
                                                  : '${time2.difference(myDateTime).inMinutes}m'
                                              : '${time2.difference(myDateTime).inSeconds}s';

                                          return Column(
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  roomId = await chatRoomId(
                                                    '${info[index].data!.userId}',
                                                    '${PreferenceManager.getUserId()}',
                                                  );

                                                  Get.to(
                                                    () => ChatRoomScreen(
                                                      name:
                                                          '${info[index].data!.name}',
                                                      userImage:
                                                          '${info[index].data!.profilePic}',
                                                      chatRoomId: '${roomId}',
                                                      userId:
                                                          '${info[index].data!.userId}',
                                                    ),
                                                  );
                                                },
                                                child: ListTile(
                                                  leading: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1000),
                                                    child: ImageLoading(
                                                      url:
                                                          '${info[index].data!.profilePic}',
                                                      width: 40.h,
                                                      height: 40.h,
                                                    ),
                                                  ),
                                                  title: Text(
                                                    '${info[index].data!.name}',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  subtitle: snap.data!.docs[0]
                                                              ['type'] ==
                                                          'img'
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              Icons.image,
                                                              color: Color(
                                                                  0xff9c9797),
                                                              size: 20.h,
                                                            ),
                                                            SizedBox(
                                                              width: 5.w,
                                                            ),
                                                            Text(
                                                              'Photo',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0Xff9C9797),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                            ),
                                                          ],
                                                        )
                                                      : Text(
                                                          '${snap.data!.docs[0]['message']}',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Color(
                                                                0Xff9C9797),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                  trailing: Text(
                                                    "$time3 ago",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0XffC5BDBD),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.white38,
                                              )
                                            ],
                                          );
                                        } else {
                                          return ShimmerChatLoading(count: 10);
                                        }
                                      },
                                    );
                                  },
                                )
                          : ShimmerChatLoading(count: 10),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  getData({String? userId}) async {
    await viewProfileViewModel.viewProfileViewModel(
      model: {
        'user_id': "$userId",
        "profile_id": "$userId",
      },
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:hotlinecafee/Preference/preference.dart';
// import 'package:hotlinecafee/ViewModel/view_profile_view_model.dart';
// import 'package:hotlinecafee/common/chat_commons.dart';
// import 'package:hotlinecafee/common/loading.dart';
// import 'package:hotlinecafee/model/apis/api_response.dart';
// import 'package:hotlinecafee/model/response_model/view_profile_res_model.dart';
// import 'package:hotlinecafee/model/services/chat_room_service.dart';
// import 'package:hotlinecafee/screen/chat/chat_room.dart';
//
// class ChatScreen extends StatefulWidget {
//   ChatScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   ViewProfileViewModel viewProfileViewModel = Get.put(ViewProfileViewModel());
//   ViewProfileResponseModel viewProfileResponseModel =
//       ViewProfileResponseModel();
//   String searchText = '';
//   TextEditingController search = TextEditingController();
//
//   String roomId = '';
//
//   void initState() {
//     viewProfileViewModel.apiResponseClear();
//     // x.clear();
//     viewProfileViewModel.getDataFromFirebase();
//     print('xxx====> ${viewProfileViewModel.x.length}');
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         body: GetBuilder<ViewProfileViewModel>(
//           builder: (controller) {
//             print('controller---${controller.apiResponse.status}');
//
//             return SafeArea(
//               child: Container(
//                 margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Chat',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w900,
//                               fontSize: 24,
//                               color: Colors.white),
//                         ),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.lock,
//                               color: Color(0Xff4F4F5B),
//                               size: 15,
//                             ),
//                             SizedBox(
//                               width: 2,
//                             ),
//                             Text(
//                               'End-to-End Encrypted',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 12,
//                                   color: Color(0Xff4F4F5B)),
//                             ),
//                           ],
//                         ),
//                         // Row(
//                         //   children: [
//                         //     Icon(
//                         //       Icons.add_box_outlined,
//                         //       color: Colors.white,
//                         //       size: 28,
//                         //     ),
//                         //     SizedBox(
//                         //       width: 20,
//                         //     ),
//                         //     Icon(Icons.notifications_none_outlined,
//                         //         color: Colors.white, size: 28),
//                         //   ],
//                         // ),
//                       ],
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(vertical: 15),
//                       height: 48,
//                       child: TextField(
//                         controller: search,
//                         onChanged: (val) {
//                           setState(() {
//                             searchText = search.text;
//                           });
//                         },
//                         obscureText: false,
//                         keyboardType: TextInputType.text,
//                         style: TextStyle(color: Color(0xff81818A)),
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Color(0xff81818A)),
//                               borderRadius: BorderRadius.circular(30)),
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Color(0xff81818A)),
//                               borderRadius: BorderRadius.circular(30)),
//                           hintStyle: TextStyle(color: Color(0xff81818A)),
//                           suffixIcon: Icon(
//                             Icons.search,
//                             color: Color(0xff81818A),
//                           ),
//                           hintText: 'Search friends',
//                         ),
//                       ),
//                     ),
//
//                     // if(controller.apiResponse.status == Status.COMPLETE){}else{
//                     //
//                     // }
//
//                     Expanded(
//                       child: controller.apiResponse.status == Status.COMPLETE
//                           ? viewProfileViewModel.x.length == 0
//                               ? Center(
//                                   child: Text('No chat user',
//                                       style: TextStyle(color: Colors.white)),
//                                 )
//                               : ListView.builder(
//                                   itemCount: viewProfileViewModel.x.length,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     var user1 =
//                                         '${viewProfileViewModel.x[index].data!.userId}';
//                                     var user2 =
//                                         '${PreferenceManager.getUserId()}';
//                                     var x = int.parse(user1) > int.parse(user2)
//                                         ? "$user2$user1"
//                                         : "$user1$user2";
//
//                                     return StreamBuilder(
//                                       stream: firebaseFirestore
//                                           .collection("chatroom")
//                                           .doc(x)
//                                           .collection('chat')
//                                           .orderBy('time', descending: true)
//                                           .snapshots(),
//                                       builder: (BuildContext context,
//                                           AsyncSnapshot<
//                                                   QuerySnapshot<
//                                                       Map<String, dynamic>>>
//                                               snap) {
//                                         if (snap.hasData) {
//                                           Timestamp time1 =
//                                               snap.data!.docs[0]['time'];
//                                           DateTime myDateTime =
//                                               time1.toDate(); // Time
//
//                                           var time2 = DateTime.now();
//                                           var time3 = time2
//                                                       .difference(myDateTime)
//                                                       .inSeconds >
//                                                   60
//                                               ? time2
//                                                           .difference(
//                                                               myDateTime)
//                                                           .inMinutes >
//                                                       60
//                                                   ? time2
//                                                               .difference(
//                                                                   myDateTime)
//                                                               .inHours >
//                                                           24
//                                                       ? '${time2.difference(myDateTime).inDays}d'
//                                                       : '${time2.difference(myDateTime).inHours}h'
//                                                   : '${time2.difference(myDateTime).inMinutes}m'
//                                               : '${time2.difference(myDateTime).inSeconds}s';
//
//                                           return Column(
//                                             children: [
//                                               InkWell(
//                                                 onTap: () async {
//                                                   roomId = await chatRoomId(
//                                                     '${viewProfileViewModel.x[index].data!.userId}',
//                                                     '${PreferenceManager.getUserId()}',
//                                                   );
//
//                                                   Get.to(
//                                                     () => ChatRoomScreen(
//                                                       name:
//                                                           '${viewProfileViewModel.x[index].data!.name}',
//                                                       userImage:
//                                                           '${viewProfileViewModel.x[index].data!.profilePic}',
//                                                       chatRoomId: '${roomId}',
//                                                       userId:
//                                                           '${viewProfileViewModel.x[index].data!.userId}',
//                                                     ),
//                                                   );
//                                                 },
//                                                 child: ListTile(
//                                                   leading: ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             1000),
//                                                     child: ImageLoading(
//                                                       url:
//                                                           '${viewProfileViewModel.x[index].data!.profilePic}',
//                                                       width: 40.h,
//                                                       height: 40.h,
//                                                     ),
//                                                   ),
//                                                   title: Text(
//                                                     '${viewProfileViewModel.x[index].data!.name}',
//                                                     style: TextStyle(
//                                                       fontSize: 18,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                   subtitle: snap.data!.docs[0]
//                                                               ['type'] ==
//                                                           'img'
//                                                       ? Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Icon(
//                                                               Icons.image,
//                                                               color: Color(
//                                                                   0xff9c9797),
//                                                               size: 20.h,
//                                                             ),
//                                                             SizedBox(
//                                                               width: 5.w,
//                                                             ),
//                                                             Text(
//                                                               'Photo',
//                                                               style: TextStyle(
//                                                                 fontSize: 14,
//                                                                 color: Color(
//                                                                     0Xff9C9797),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                               ),
//                                                               overflow:
//                                                                   TextOverflow
//                                                                       .ellipsis,
//                                                               maxLines: 1,
//                                                             ),
//                                                           ],
//                                                         )
//                                                       : Text(
//                                                           '${snap.data!.docs[0]['message']}',
//                                                           style: TextStyle(
//                                                             fontSize: 14,
//                                                             color: Color(
//                                                                 0Xff9C9797),
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                           ),
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           maxLines: 1,
//                                                         ),
//                                                   trailing: Text(
//                                                     "$time3 ago",
//                                                     style: TextStyle(
//                                                       fontSize: 14,
//                                                       color: Color(0XffC5BDBD),
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Divider(
//                                                 color: Colors.white38,
//                                               )
//                                             ],
//                                           );
//                                         } else {
//                                           return ShimmerChatLoading(count: 10);
//                                         }
//                                       },
//                                     );
//                                   },
//                                 )
//                           : ShimmerChatLoading(count: 10),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   getData({String? userId}) async {
//     await viewProfileViewModel.viewProfileViewModel(
//       model: {
//         'user_id': "$userId",
//         "profile_id": "$userId",
//       },
//     );
//   }
// }
