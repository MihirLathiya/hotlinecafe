import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/common/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

import 'bottom_bar.dart';

class NewShortScreen extends StatefulWidget {
  final String videoFile;

  const NewShortScreen({Key? key, required this.videoFile}) : super(key: key);

  @override
  State<NewShortScreen> createState() => _NewShortScreenState();
}

class _NewShortScreenState extends State<NewShortScreen> {
  late VideoPlayerController _controller;

  Future<void> getVideo({String? videoUrl}) async {
    _controller = VideoPlayerController.network(
      '${widget.videoFile}',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print('PREVIEW>>${widget.videoFile}');
    getVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          child: Divider(color: Color(0xff242424), thickness: 2),
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
          'New Short',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Container(
              height: 120.h,
              width: 120.w,
              decoration: BoxDecoration(
                // /color: Colors.red,
                borderRadius: BorderRadius.circular(10.h),
              ),
              child: VideoPlayer(_controller),
            ),
            SizedBox(height: 20.h),
            TextFormField(
              maxLines: 10,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Write caption here...',
                hintStyle: TextStyle(
                  color: Color(0xff4F4F5B),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Spacer(),
            MaterialButton(
              color: Color(0xffE76944),
              height: 48.h,
              minWidth: Get.width,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.sp),
              ),
              onPressed: () async {
                print('Tap');
                var request = http.MultipartRequest(
                    'POST',
                    Uri.parse(
                        'https://irisinformatics.net/dating/wb/upload_short'));
                request.fields
                    .addAll({'user_id': PreferenceManager.getUserId()});
                request.files.add(await http.MultipartFile.fromPath(
                    'short', '${widget.videoFile}'));

                http.StreamedResponse response = await request.send();

                if (response.statusCode == 200) {
                  print(await response.stream.bytesToString());
                  CommonSnackBar.commonSnackBar(message: "Successfully Upload");
                } else {
                  print(response.reasonPhrase);
                }
                _controller.dispose();
                Get.offAll(() => BottomBar());
              },
              child: Text(
                'Post',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(height: 56.h),
          ],
        ),
      ),
    );
  }
}
