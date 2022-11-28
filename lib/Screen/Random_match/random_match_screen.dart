import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/Screen/Random_match/start_random_match_screen.dart';
import 'package:hotlinecafee/ViewModel/random_match_view_model.dart';
import 'package:hotlinecafee/common/chat_commons.dart';
import 'package:hotlinecafee/common/snackbar.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:new_im_animations/im_animations.dart';

class RandomMatchScreen extends StatefulWidget {
  final count;
  final id;
  final token;
  // final channelName;
  // final channelToken;
  const RandomMatchScreen({
    Key? key,
    this.count,
    this.id,
    this.token,

    // this.channelName, this.channelToken
  }) : super(key: key);

  @override
  State<RandomMatchScreen> createState() => _RandomMatchScreenState();
}

class _RandomMatchScreenState extends State<RandomMatchScreen> {
  RandomMatchViewModel onOffRandomMatchViewModel = Get.find();
  List pairedList = [];
  List waitingList = [];
  var id = '';
  var token = '';
  var userName = '';
  var userImage = '';
  var secondUserId = '';
  Timer? timerVar;
  Future getWaitingData() async {
    var data =
        await firebaseFirestore.collection('pairing_system').doc('data').get();
    Map<String, dynamic>? userData = data.data();

    waitingList = userData!['waiting'];

    waitingList.toSet().toList();
    print('WAITING LIST :- $waitingList');
    return waitingList;
  }

  backFunction() async {
    await onOffRandomMatchViewModel.randomMatchOffViewModel(
        model: {'user_id': PreferenceManager.getUserId(), 'on_off': '0'});
    if (onOffRandomMatchViewModel.randomOffApiResponse.status == Status.ERROR) {
      return CommonSnackBar.commonSnackBar(message: 'Something went wrong');
    }
    if (onOffRandomMatchViewModel.randomOffApiResponse.status ==
        Status.COMPLETE) {
      await getWaitingData();
      waitingList.remove(PreferenceManager.getUserId());
      await FirebaseFirestore.instance
          .collection('pairing_system')
          .doc('data')
          .update(
        {'waiting': waitingList},
      );
      await FirebaseFirestore.instance
          .collection('user')
          .doc(PreferenceManager.getUserId())
          .update(
        {'id': '', 'token': ''},
      );

      Get.back();
    }
    timerVar?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backFunction();

        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          bottom: PreferredSize(
              child: Divider(color: Color(0xff242424), thickness: 1),
              preferredSize: Size.fromHeight(4.h)),
          leading: IconButton(
            splashRadius: 20,
            onPressed: () async {
              backFunction();
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
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Sonar(
                    insets: 10.0,
                    waveColor: Colors.grey,
                    radius: 200,
                    child: Image.asset(
                      'images/earth.png',
                      height: 260.h,
                      width: 260.h,
                    ),
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
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        height: 48.h,
                        width: 200.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffE76944),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          onPressed: () async {
                            await searchMatch();
                          },
                          child: Text(
                            'Random Match',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 24.h,
                          width: 50.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff4B53FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            onPressed: () {},
                            child: FittedBox(
                              child: Text(
                                'FREE',
                                style: TextStyle(
                                  fontSize: 7.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> searchMatch() async {
    Timer.periodic(
      Duration(seconds: 1),
      (timer) async {
        timerVar = timer;
        String first = '';
        pairedList.clear();
        var data =
            await firebaseFirestore.collection('paired').doc('first').get();
        Map<String, dynamic>? userData = data.data();

        pairedList = userData!['pair'];
        pairedList.toSet().toList();

        log('PAIRED LIST :- ${pairedList}');

        if (pairedList.isNotEmpty) {
          pairedList.forEach(
            (element) async {
              if (element.toString().split(' + ').first ==
                      PreferenceManager.getUserId() ||
                  element.toString().split(' + ').last ==
                      PreferenceManager.getUserId()) {
                List x = element.toString().split(' + ');
                x.remove(PreferenceManager.getUserId());
                log('MATCHED ID1 :- ${x.first}');

                var data = await firebaseFirestore
                    .collection('user')
                    .doc('${x.first}')
                    .get();
                Map<String, dynamic>? userData = data.data();

                setState(() {
                  id = userData!['id'];
                  token = userData['token'];
                  userImage = userData['userImage'];
                  userName = userData['username'];
                  secondUserId = userData['userUid'];
                });
                timer.cancel();
                var finalId = await channelNameRoom(id, widget.id);
                var finalToken =
                    await channelTokenRoom(id, widget.id, token, widget.token);

                log('FINAL IDS :- ${finalId}');
                log('FINAL TOKEN :- ${finalToken}');
                await FirebaseFirestore.instance
                    .collection('user')
                    .doc(PreferenceManager.getUserId())
                    .update({'randomMatch': true});
                Get.to(
                  () => StartRandomMatchScreen(
                    userName: userName,
                    userImage: userImage,
                    channelName: finalId,
                    channelToken: finalToken,
                    userId: PreferenceManager.getUserId(),
                    secondUserId: secondUserId,
                    count: widget.count,
                  ),
                );
              } else {
                await getWaitingData();

                log('WAITING LIST 123 :- $waitingList');
                await waitingList.toSet().toList();
                if (waitingList.length > 1) {
                  first = '${waitingList[0]} + ${waitingList[1]}';
                  pairedList.add(first);
                  waitingList.remove(waitingList.first);
                  waitingList.remove(waitingList.first);
                  if (pairedList.contains('0 + 0')) {
                  } else {
                    pairedList.add('0 + 0');
                  }
                  await pairedList.toSet().toList();
                  await FirebaseFirestore.instance
                      .collection('paired')
                      .doc('first')
                      .update({'pair': pairedList});
                  await FirebaseFirestore.instance
                      .collection('pairing_system')
                      .doc('data')
                      .update(
                    {'waiting': waitingList},
                  );
                } else {
                  log('NO USER LIVE');
                }
              }
            },
          );
        }
      },
    );
  }

  Future<String> channelNameRoom(String user1, String user2) async {
    if (int.parse(user1.split('random').last) >
        int.parse(user2.split('random').last)) {
      return '$user1';
    } else {
      return '$user2';
    }
  }

  Future<String> channelTokenRoom(
      String user1, String user2, String token1, String token2) async {
    if (int.parse(user1.split('random').last) >
        int.parse(user2.split('random').last)) {
      return '$token1';
    } else {
      return '$token2';
    }
  }
}
