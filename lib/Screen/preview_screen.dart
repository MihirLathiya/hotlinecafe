import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'new_short_screen.dart';

class PreviewScreen extends StatefulWidget {
  final String videoFile;
  PreviewScreen({Key? key, required this.videoFile}) : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  late VideoPlayerController _controller;
  bool _isPlay = true;
  Future<void> getVideo({String? videoUrl}) async {
    _controller = VideoPlayerController.network(
      '${widget.videoFile}',
      // closedCaptionFile: _loadCaptions(),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((value) {
      _controller.play();
    });

    // _controller.setLooping(true);
  }

  @override
  void initState() {
    print('PREVIEW>>${widget.videoFile}');
    getVideo();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            _controller.dispose();
            Get.back();
          },
          icon: Icon(
            Icons.close,
            color: Colors.white,
            size: 20.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => NewShortScreen(
                    videoFile: widget.videoFile,
                  ));
              print('Next');
            },
            child: Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(16.h),
            height: 650.h,
            width: Get.width,
            decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: VideoPlayer(_controller),
          ),
          _isPlay == false
              ? InkWell(
                  onTap: () {
                    setState(() {
                      _isPlay = true;
                    });
                    _controller.play();
                  },
                  child: Image.asset('images/play.png', height: 55.sp),
                )
              : InkWell(
                  onTap: () {
                    setState(() {
                      _isPlay = false;
                    });
                    _controller.pause();
                  },
                  child: SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                  ),
                )
        ],
      ),
    );
  }
}
