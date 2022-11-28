import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/common/chat_commons.dart';
import 'package:hotlinecafee/common/loading.dart';

class ChatRoomScreen extends StatefulWidget {
  final name;
  final userId;
  final userImage;
  final chatRoomId;

  const ChatRoomScreen({
    Key? key,
    this.name,
    this.userImage,
    this.chatRoomId,
    this.userId,
  }) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen>
    with WidgetsBindingObserver {
  TextEditingController message = TextEditingController();
  File? file;
  String? name;
  String status = 'Offline';
  setStatus(String statu) async {
    status = statu;
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      setStatus("Offline");

      // offline
    }
    super.didChangeAppLifecycleState(state);
  }

  /// Set Image
  setImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      File doc = File(result.files.single.path.toString());

      setState(() {
        file = doc;
      });
      name = result.names.first.toString();

      uploadImage(widget.chatRoomId, file);
    } else {
      return null;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  dispose() {
    message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('₹${widget.userId}');
    return Scaffold(
      backgroundColor: Color(0xff1E1E1E),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff1E1E1E),
        title: StreamBuilder(
          stream: firebaseFirestore
              .collection('user')
              .doc('${widget.userId}')
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              log('MESSAGE ${snapshot.data!['status']}');
              return Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: ImageLoading(
                      url: '${widget.userImage}',
                      height: 40.h,
                      width: 40.h,
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  snapshot.data!['status'] == 'Online'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.name}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              snapshot.data!['status'],
                              style: TextStyle(
                                color: Color(0xff53B175),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          '${widget.name}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ],
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
      body: Column(
        children: [
          Divider(color: Colors.white38),
          Expanded(
            child: StreamBuilder(
              stream: firebaseFirestore
                  .collection('chatroom')
                  .doc(widget.chatRoomId)
                  .collection('chat')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      var message = snapshot.data!.docs[index];
                      var myDateTime;
                      var myDateTime2;
                      var time1;
                      var time2;

                      try {
                        time1 = snapshot.data!.docs[index]['time'];
                        try {
                          time2 = snapshot.data!.docs[index + 1]['time'];
                        } catch (e) {}
                        myDateTime = time1
                            .toDate()
                            .toString()
                            .split(' ')
                            .first
                            .toString();
                        try {
                          myDateTime2 = time2
                              .toDate()
                              .toString()
                              .split(' ')
                              .first
                              .toString();
                        } catch (e) {}
                      } catch (e) {
                        log('DATE ERROR');
                      }

                      Widget seprate = SizedBox();

                      try {
                        if (index != 0 && myDateTime != myDateTime2) {
                          var day = myDateTime.toString().split('-').last;
                          var month = myDateTime.toString().split('-')[1];
                          var year = myDateTime.toString().split('-').first;
                          var cDate =
                              DateTime.now().toString().split(' ').first;
                          var cDay = cDate.toString().split('-').last;
                          var cMonth = cDate.toString().split('-')[1];
                          var cYear = cDate.toString().split('-').first;
                          var currentDate = '$cDay $cMonth $cYear';
                          var notCurrentDate = '$day $month $year';

                          var extractMonth = month == 1
                              ? 'January'
                              : month == 2
                                  ? 'February'
                                  : month == 3
                                      ? 'March'
                                      : month == 4
                                          ? 'April'
                                          : month == 5
                                              ? 'May'
                                              : month == 6
                                                  ? 'June'
                                                  : month == 7
                                                      ? 'July'
                                                      : month == 8
                                                          ? 'August'
                                                          : month == 9
                                                              ? 'September'
                                                              : month == 10
                                                                  ? 'October'
                                                                  : month == 11
                                                                      ? 'November'
                                                                      : 'December';

                          seprate = Text(
                            currentDate == notCurrentDate
                                ? 'Today'
                                : '$day $extractMonth $year',
                            style: TextStyle(
                              color: Colors.white24,
                              fontSize: 14,
                            ),
                          );
                        }
                      } catch (e) {
                        seprate = SizedBox();
                        log('TIME ERROR');
                      }

                      return Column(
                        children: [
                          seprate,
                          message['type'] == 'text'
                              ? ContainerDecoration(
                                  message: message,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          message['message'],
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ContainerDecoration(
                                  message: message,
                                  child: Loading(
                                    message: message,
                                  ),
                                )
                        ],
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          sendMessage(Get.width, Get.height),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  sendMessage(double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: TextFormField(
        style: TextStyle(fontSize: 18, color: Colors.white),
        onChanged: (value) {
          setState(() {});
        },
        controller: message,
        decoration: InputDecoration(
          fillColor: Colors.white12,
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1200),
              borderSide: BorderSide(color: Colors.white38)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1200),
              borderSide: BorderSide(color: Colors.white38)),
          prefixIcon: Container(
            margin: EdgeInsets.only(left: 6.w, right: 12.w),
            height: 40.h,
            width: 40.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff4B53FF),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/Video2.png',
                  height: 15.h,
                  width: 20.h,
                ),
              ],
            ),
          ),
          suffixIcon: message.value.text.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // showMediaSheet();
                        setImage();
                      },
                      splashRadius: 10,
                      icon: SvgPicture.asset(
                        'images/svg/fi_paperclip.svg',
                        color: Color(0xff4F4F5B),
                        height: 20.h,
                        width: 20.h,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // showMediaSheet();
                      },
                      splashRadius: 10,
                      icon: SvgPicture.asset(
                        'images/svg/Voice.svg',
                        color: Color(0xff4F4F5B),
                        height: 20.h,
                        width: 20.h,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        onSendMessage();
                      },
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: Color(0xff4B53FF),
                          fontWeight: FontWeight.w600,
                          fontSize: 16.h,
                        ),
                      ),
                    )
                  ],
                ),
          hintText: "Type Something...",
          hintStyle: TextStyle(fontSize: 18, color: Color(0xff4F4F5B)),
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Future<String?> getData() async {
    String? fcm;
    var data = await FirebaseFirestore.instance
        .collection('user')
        .doc(widget.userId)
        .get();

    Map<String, dynamic>? datas = data.data();
    setState(() {
      fcm = datas!['fcm'];
    });
    return fcm;
  }

  void onSendMessage() async {
    if (message.text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chat')
          .add(
        {
          'sendBy': PreferenceManager.getUserId(),
          "message": message.text,
          "time": DateTime.now(),
          'type': 'text',
          'isDelete': false,
          'isCheck': false,
        },
      );
    }

    message.clear();
  }
}
