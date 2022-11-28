import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({Key? key}) : super(key: key);

  @override
  State<ShortsScreen> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  int select = 0;
  PageController pageController = PageController(initialPage: 0);

  List video = [
    'https://irisinformatics.net/dating/uploads/short/file_example_MP4_1920_18MG.mp4',
    "https://irisinformatics.net/dating/uploads/short/a1ec9e43-f765-425c-ba9a-0a4b6ed3ada21899614391877124019.mp4",
    'https://irisinformatics.net/dating/uploads/short/file_example_MP4_1920_18MG.mp4',
    'https://irisinformatics.net/dating/uploads/short/file_example_MP4_1920_18MG.mp4'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        onPageChanged: (val) {
          setState(() {
            select = val;
          });
        },
        itemCount: video.length,
        itemBuilder: (context, index) {
          return Shorts(
            url: video[index],
          );
        },
      ),
    );
  }
}

class Shorts extends StatefulWidget {
  final String? url;
  const Shorts({Key? key, this.url}) : super(key: key);

  @override
  State<Shorts> createState() => _ShortsState();
}

class _ShortsState extends State<Shorts> {
  late VideoPlayerController _controller;
  bool _isPlay = true;

  Future<void> getVideo() async {
    _controller = VideoPlayerController.network(
      '${widget.url}',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    _controller.setLooping(true);
    _controller.addListener(() {
      _controller.value.aspectRatio;
      setState(() {});
    });
    await _controller.initialize().then((value) {
      _controller.play();
    });
  }

  @override
  void initState() {
    getVideo();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List language = [
    'Tamil',
    'Bengali',
    'Spanish',
    'English',
    'Hindi',
    'Tamil',
    "Spanish"
  ];
  bool x = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              _isPlay == false
                  ? GestureDetector(
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
          Positioned(
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              x = !x;
                            });
                          },
                          icon: Icon(
                            x == true
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            size: 32.sp,
                            color: x == true ? Colors.red : Color(0xff81818A),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.sp),
                          child: Text(
                            '12K',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff81818A)),
                          ),
                        ),
                        SizedBox(
                          height: 17.sp,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            showFilterSheet();
                          },
                          child: Image.asset('images/comment.png',
                              height: 33.sp, width: 33.sp, fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.sp),
                          child: Text(
                            '12K',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff81818A)),
                          ),
                        ),
                        SizedBox(
                          height: 7.sp,
                        ),
                        IconButton(
                            onPressed: () {
                              bottomSheet(context);
                            },
                            icon: Icon(
                              Icons.more_vert,
                              size: 30.sp,
                              color: Color(0xff81818A),
                            )),
                        SizedBox(
                          height: 22.h,
                        )
                      ],
                    ),
                    SizedBox(
                      width: 15.sp,
                    )
                  ],
                ),
                Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25.sp,
                                  backgroundImage:
                                      AssetImage("images/girl.png"),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Abc',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          width: 4.sp,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 25.5.sp,
                                          width: 55.sp,
                                          decoration: BoxDecoration(
                                              color: Color(0xffE76944),
                                              borderRadius:
                                                  BorderRadius.circular(13.sp)),
                                          child: Text(
                                            'Follow',
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '12k Followers',
                                      style: TextStyle(
                                          color: Color(0xff81818A),
                                          fontSize: 12.5.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.sp,
                            ),
                            Text(
                              'Look at the beautiful sky it’s...',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(32.sp),
                        onTap: () {
                          // Get.to(() => CallUserScreen());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 42.sp,
                          width: 85.sp,
                          decoration: BoxDecoration(
                              color: Color(0xff53B175),
                              borderRadius: BorderRadius.circular(32.sp)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/Video2.png',
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'Call',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 17.sp,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  bottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Colors.black,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.sp,
                  ),
                  GestureDetector(
                    onTap: () {
                      Report(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Report...",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 27.sp),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Row(
                    children: [
                      Transform.rotate(
                        angle: 2.5,
                        child: Icon(
                          Icons.link,
                          size: 22.sp,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Copy link",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 27.sp),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Row(
                    children: [
                      Transform.rotate(
                        angle: 5.5,
                        child: Icon(
                          Icons.send_outlined,
                          size: 22.sp,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Share to",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 27.sp),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.bookmark_border,
                        size: 25.sp,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Report(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Colors.black,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Text(
                  "Report",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Report2(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Pornographic",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Report2(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Illegal or Violence",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Report2(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Endanger Personal Safety",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Report2(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Illegal Poster",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Report2(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Illegal Avatar",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Report2(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Other",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          );
        });
  }

  Report2(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.black,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                      child: Text(
                    "Report",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Write your report reason",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextField(
                      maxLines: 5,
                      style: TextStyle(color: Color(0xff81818A)),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff81818A)),
                            borderRadius: BorderRadius.circular(30)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff81818A)),
                            borderRadius: BorderRadius.circular(30)),
                        hintStyle: TextStyle(color: Color(0xff81818A)),
                        hintText: 'Type Here',
                        // border: OutlineInputBorder(
                        //     borderSide: BorderSide(color: Color(0xff81818A), width: 1.0),
                        //     borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              backgroundColor: Colors.grey),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Cancel"),
                          ),
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              backgroundColor: Color(0xffEE6D41)),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Submit"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future showFilterSheet() {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 514.h,
          width: Get.width,
          decoration: BoxDecoration(
            color: Color(0xff1A1A27),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.sp),
              topLeft: Radius.circular(20.sp),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  'Filter',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
                Divider(
                  color: Color(0xff373743),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Regions',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                      Text(
                        'Clear',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xffE76944),
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Wrap(
                  children: [
                    ...List.generate(
                      language.length,
                      (index) => GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(right: 12.w, bottom: 16.h),
                          padding: EdgeInsets.all(10.h),
                          decoration: BoxDecoration(
                            color: Color(0xff81818A),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundImage: AssetImage(
                                  'images/TaskChat.png',
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                language[index],
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Language',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                      Text(
                        'Clear',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xffE76944),
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Wrap(
                  children: [
                    ...List.generate(
                      language.length,
                      (index) => GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(right: 12.w, bottom: 16.h),
                          padding: EdgeInsets.all(10.h),
                          decoration: BoxDecoration(
                            color: Color(0xff81818A),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            language[index],
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
