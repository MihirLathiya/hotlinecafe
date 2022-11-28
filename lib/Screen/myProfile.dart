import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/Screen/Setting_screens/setting_screen.dart';
import 'package:hotlinecafee/Screen/gift_history.dart';
import 'package:hotlinecafee/ViewModel/view_profile_view_model.dart';
import 'package:hotlinecafee/model/response_model/view_profile_res_model.dart';
import 'package:hotlinecafee/screen/Razor%20Pay/razorpay_screen.dart';
import 'package:hotlinecafee/screen/earning_screen.dart';
import 'package:hotlinecafee/screen/giftCollection.dart';
import 'package:hotlinecafee/screen/my_call_rate_screen.dart';
import 'package:hotlinecafee/screen/save_post_screen.dart';
import 'package:video_player/video_player.dart';

import '../common/loading.dart';
import '../model/apis/api_response.dart';
import 'editProfile.dart';
import 'folllower1.dart';
import 'myLevel.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  /// View Profile
  // ViewProfileRequestModel viewProfileRequest = ViewProfileRequestModel();
  ViewProfileViewModel viewProfileViewModel = Get.put(ViewProfileViewModel());

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  void getDetails() {
    print('INIT');
    viewProfileViewModel.viewProfileViewModel(model: {
      "user_id": PreferenceManager.getUserId(),
      "profile_id": PreferenceManager.getUserId()
    });
    if (viewProfileViewModel.apiResponse.status == Status.COMPLETE) {
      ViewProfileResponseModel viewProfileResponseModel =
          viewProfileViewModel.apiResponse.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewProfileViewModel>(
      builder: (controller) {
        if (controller.apiResponse.status == Status.LOADING) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.apiResponse.status == Status.COMPLETE) {
          ViewProfileResponseModel viewProfileResponseModel =
              controller.apiResponse.data;
          var userData = viewProfileResponseModel.data;
          PreferenceManager.setUserImage('${userData?.profilePic}');
          PreferenceManager.setName('${userData?.name}');
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              title: Text(
                '${userData?.username}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Profile(context: context, data: userData);
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: ImageLoading(
                                url: '${userData?.profilePic}',
                                height: 60,
                                width: 60,
                              ),
                            ),
                            Baseline(
                              baseline: 1,
                              baselineType: TextBaseline.alphabetic,
                              child: Container(
                                decoration: ShapeDecoration(
                                  color: Color(0xffEB5757),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(
                                      width: 1,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Image.asset('images/1040230 1.png'),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        'Lv ${userData!.level}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                '${userData.shorts!.length}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'Posts',
                                  style: TextStyle(
                                    color: Color(0Xff81818A),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Followers()));
                            },
                            child: Column(
                              children: [
                                Text(
                                  '${userData.followings}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Following',
                                    style: TextStyle(
                                      color: Color(0Xff81818A),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Followers()));
                            },
                            child: Column(
                              children: [
                                Text(
                                  '${userData.followers}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Followers',
                                    style: TextStyle(
                                        color: Color(0Xff81818A),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 0, 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: Text(
                            '${userData.name}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          '${userData.bio}',
                          style: TextStyle(color: Color(0Xff81818A)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 10, left: 18.w, right: 18.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: ShapeDecoration(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              side: const BorderSide(
                                width: 1,
                                color: Colors.white24,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset('images/image 6.png'),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "${userData.region}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: ShapeDecoration(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              side: const BorderSide(
                                width: 1,
                                color: Colors.white24,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset('images/7917749 3.png'),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "${userData.language}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: ShapeDecoration(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              side: const BorderSide(
                                width: 1,
                                color: Colors.white24,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset('images/7917749 3.png'),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "${userData.language}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: ShapeDecoration(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              side: const BorderSide(
                                width: 1,
                                color: Colors.white24,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset('images/1019173 1.png'),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "${userData.gender}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "images/Coin.png",
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // "${userData.b}",
                                        '${userData.balance}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        "Coin Balance",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => StoreScreen());
                                    },
                                    child: Container(
                                      height: 20.h,
                                      width: 20.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffE76944),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 15.h,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Container(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "images/Dimond_fill.png",
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${userData.earnings}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        "Earning",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Get.to(
                          () => Gift_Collection(
                            userId: userData.userId,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        height: 48.h,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/twemoji_wrapped-gift.png'),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Gift Collection",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white24),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.navigate_next,
                              color: Colors.white24,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: userData.shorts!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.7),
                    itemBuilder: (context, index) {
                      return LiveCard(
                        url: userData.shorts![index].short!,
                        bio: userData.bio,
                        image: userData.profilePic,
                        follower: userData.followers.toString(),
                        name: userData.username,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else if (controller.apiResponse.status == Status.ERROR) {
          return Scaffold(
            body: Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        } else
          return SizedBox();
      },
    );
  }
}

Profile({BuildContext? context, Data? data}) {
  showModalBottomSheet(
    context: context!,
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
            GestureDetector(
              onTap: () {
                Get.back();
                Get.to(
                  () => Edit_profile(
                    number: data!.mobileNo,
                    name: data.name,
                    bio: data.bio,
                    dob: data.dob.toString(),
                    emailId: data.email,
                    gender: data.gender,
                    language: data.language,
                    userName: data.username,
                    userImages: data.profilePic,
                    region: data.region,
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Edit Profile",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Get.back();

                Get.to(() => My_level());
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "My Level",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Get.back();

                Get.to(() => StoreScreen());
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "My Coin Balance",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Get.back();

                Get.to(() => MyCallRateScreen());
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Coins()));
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "My Chat Price",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Get.back();

                Get.to(() => GiftHistoryScreen());
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Gift History",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Get.back();

                Get.to(() => EarningScreen());
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "My Earnings",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Get.back();

                // Report2(context);
                Get.to(() => SavePostScreen());
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Saved Shorts",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () async {
                Get.back();

                Get.to(() => SettingScreen());
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Settings",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      );
    },
  );
}

class LiveCard extends StatefulWidget {
  final String? url, name, image, follower, bio;
  LiveCard(
      {Key? key,
      required this.url,
      this.name,
      this.image,
      this.follower,
      this.bio})
      : super(key: key);

  @override
  State<LiveCard> createState() => _LiveCardState();
}

class _LiveCardState extends State<LiveCard> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    getVideo();
    super.initState();
  }

  Future<void> getVideo({String? videoUrl}) async {
    _controller = VideoPlayerController.network(
      '${widget.url}',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller?.addListener(() {
      setState(() {});
    });
    await _controller?.initialize();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ShortsView(
              url: widget.url,
              name: widget.name,
              follower: widget.follower,
              bio: widget.bio,
              image: widget.image,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          VideoPlayer(_controller!),
          Positioned(
            bottom: 5,
            right: 10,
            child: Image.asset(
              'images/play6.png',
              height: 20,
              width: 20,
            ),
          )
        ],
      ),
    );
  }
}

class ShortsView extends StatefulWidget {
  final String? url, name, image, follower, bio;
  const ShortsView(
      {Key? key, this.url, this.name, this.image, this.follower, this.bio})
      : super(key: key);

  @override
  State<ShortsView> createState() => _ShortsViewState();
}

class _ShortsViewState extends State<ShortsView> {
  late VideoPlayerController _controller;
  bool _isPlay = true;
  Future<void> getVideo() async {
    _controller = VideoPlayerController.network(
      '${widget.url}',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    _controller.setLooping(true);
    _controller.addListener(() {
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              x = !x;
                            });
                            log('xxxxxxxx$x');
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
                              bottomsheet(context);
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
                  ),
                  SizedBox(
                    width: 15.sp,
                  ),
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                                        NetworkImage("${widget.image}"),
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${widget.name}',
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
                                                    BorderRadius.circular(
                                                        13.sp)),
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
                                        '${widget.follower} Followers',
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
                                '${widget.bio}',
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
      ),
    );
  }

  bottomsheet(BuildContext context) {
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
                                primary: Colors.grey),
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
                              primary: Color(0xffEE6D41),
                            ),
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
        });
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
