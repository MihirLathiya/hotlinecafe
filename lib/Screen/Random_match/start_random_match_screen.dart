import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Screen/Random_match/rando_match_video_screen.dart';
import 'package:hotlinecafee/ViewModel/random_match_view_model.dart';
import 'package:hotlinecafee/common/chat_commons.dart';

class StartRandomMatchScreen extends StatefulWidget {
  final userName;
  final userImage;
  final channelName;
  final channelToken;
  final secondUserId;
  final userId, count;
  const StartRandomMatchScreen(
      {Key? key,
      this.channelName,
      this.channelToken,
      this.count,
      this.userName,
      this.userImage,
      this.secondUserId,
      this.userId})
      : super(key: key);

  @override
  State<StartRandomMatchScreen> createState() => _StartRandomMatchScreenState();
}

class _StartRandomMatchScreenState extends State<StartRandomMatchScreen> {
  RandomMatchViewModel randomMatchViewModel = Get.find();

  @override
  void initState() {
    randomMatches();
    super.initState();
  }

  randomMatches() async {
    Timer.periodic(
      Duration(milliseconds: 600),
      (timer) async {
        bool? isMatch = await getOtherUserData(widget.secondUserId);
        if (isMatch == true) {
          timer.cancel();
          Get.to(
            () => RandomMatchVideoScreen(
              channelName: widget.channelName,
              channelToken: widget.channelToken,
              userName: widget.userName,
              userImage: widget.userImage,
              userId: widget.userId,
              secondUserId: widget.secondUserId,
            ),
          );
        }
      },
    );
  }

  Future<bool?> getOtherUserData(id) async {
    bool? x;

    var data = await firebaseFirestore.collection('user').doc(id).get();
    Map<String, dynamic>? userData = data.data();

    setState(() {
      x = userData!['randomMatch'];
    });

    print('OTHER USER STATUS :- $x');
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          child: Divider(color: Color(0xff242424), thickness: 1),
          preferredSize: Size.fromHeight(4.h),
        ),
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Random Match',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: GetBuilder<RandomMatchViewModel>(
        builder: (controller) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/scan.png',
                      height: 260.h,
                      width: 260.h,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.count} people',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      'are in matching...',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 50.h,
                        width: 200.w,
                        padding: EdgeInsets.all(16.sp),
                        decoration: BoxDecoration(
                          color: Color(0xff373743),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Color(0xff242424),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
