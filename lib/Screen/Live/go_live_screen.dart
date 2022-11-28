import 'dart:async';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/ViewModel/brodcast_controller.dart';
import 'package:hotlinecafee/ViewModel/home_view_model.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:hotlinecafee/model/response_model/live_streaming_res_model.dart';
import 'package:hotlinecafee/screen/Live/broadcast_page.dart';
import 'package:hotlinecafee/screen/go_live.dart';
import 'package:permission_handler/permission_handler.dart' as permission;

class GoLiveScreen extends StatefulWidget {
  final isBroadcaster;
  final image;

  const GoLiveScreen({
    Key? key,
    this.isBroadcaster,
    this.image,
  }) : super(key: key);

  @override
  State<GoLiveScreen> createState() => _GoLiveScreenState();
}

class _GoLiveScreenState extends State<GoLiveScreen> {
  bool isLive = false;

  Count1Controller count1controller = Get.put(Count1Controller());
  HomeViewModel homeViewModel = Get.find();

  CameraController? controller;

  Timer? timer;
  void startTimer() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (count1controller.count.value > 0) {
          count1controller.counterIncrease();
        } else {
          timer.cancel();
          setState(() {
            isLive = false;
          });
          count1controller.defaultValue();
        }
      },
    );
    controller = CameraController(cameras![0], ResolutionPreset.max);
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Rectangle 9.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: isLive == true
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        '${count1controller.count.value}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.sp,
                        ),
                      ),
                    )
                  ],
                ),
              )
            : SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 40.h,
                              width: 40.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.sp),
                                color: Colors.black.withOpacity(0.2),
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.only(top: 5.h),
                                  height: 50.h,
                                  width: 50.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.sp),
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                  child: Image.asset('images/p.png'),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: -10,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff4B53FF),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 2),
                                    child: Text(
                                      "VS",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.h,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          MaterialButton(
                            color: Color(0xffE76944),
                            height: 48.h,
                            minWidth: 160.w,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.sp),
                            ),
                            onPressed: () async {
                              setState(() {
                                isLive = true;
                              });
                              startTimer();
                              await homeViewModel.liveStreamViewModel(model: {
                                'user_id': PreferenceManager.getUserId(),
                              });

                              if (homeViewModel.liveStreamApiResponse.status ==
                                  Status.COMPLETE) {
                                await [
                                  permission.Permission.microphone,
                                  permission.Permission.camera
                                ].request();

                                LiveStreamingResponseModel liveStream =
                                    homeViewModel.liveStreamApiResponse.data;

                                log('CHANNEL NAME :- ${liveStream.data!.channelName}');
                                log('CHANNEL token :- ${liveStream.data!.token}');
                                log('USerID :- ${PreferenceManager.getUserId()}');

                                Get.to(
                                  () => HostLivePage(
                                    channelToken: liveStream.data!.token,
                                    channelName: liveStream.data!.channelName,
                                    channelId: int.parse(
                                      PreferenceManager.getUserId(),
                                    ),
                                    image: '${widget.image}',
                                    time: DateTime.now(),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Go Live',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              'images/camera.svg',
                              height: 48.h,
                              width: 48.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
