import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Model/Response_model/daat.dart';
import 'package:hotlinecafee/Model/Response_model/get_call_rate_res_model.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/ViewModel/follow_view_model.dart';
import 'package:hotlinecafee/ViewModel/get_call_rate_view_model.dart';
import 'package:hotlinecafee/ViewModel/home_view_model.dart';
import 'package:hotlinecafee/ViewModel/view_profile_view_model.dart';
import 'package:hotlinecafee/common/chat_commons.dart';
import 'package:hotlinecafee/common/loading.dart';
import 'package:hotlinecafee/common/snackbar.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:hotlinecafee/model/response_model/view_profile_res_model.dart';
import 'package:hotlinecafee/model/services/chat_room_service.dart';
import 'package:hotlinecafee/screen/call_user_screen.dart';
import 'package:hotlinecafee/screen/chat/chat_room.dart';
import 'package:hotlinecafee/screen/myProfile.dart';
import 'package:video_player/video_player.dart';

import 'folllower1.dart';
import 'giftCollection.dart';

class View_profile extends StatefulWidget {
  final String profileId;
  // final userId;
  final follow;
  const View_profile({Key? key, required this.profileId, this.follow})
      : super(key: key);

  @override
  State<View_profile> createState() => _View_profileState();
}

class _View_profileState extends State<View_profile> {
  /// View Profile
  // ViewProfileRequestModel viewProfileRequest = ViewProfileRequestModel();
  ViewProfileViewModel viewProfileViewModel = Get.put(ViewProfileViewModel());

  /// HomeScreen Api
  HomeViewModel homeViewModel = Get.find();

  FollowViewModel followViewModel = Get.put(FollowViewModel());

  FollowController followController = Get.put(FollowController());

  VideoPlayerController? videoController;
  String? roomId;

  @override
  void initState() {
    super.initState();

    viewProfileViewModel.viewProfileViewModel(
      model: {
        "user_id": PreferenceManager.getUserId(),
        "profile_id": widget.profileId
      },
    );
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  GetCallRateViewModel getCallRateViewModel = Get.put(GetCallRateViewModel());

  List x = [];
  @override
  Widget build(BuildContext context) {
    // print('FOLLOW STATUS :- ${widget.follow}');
    return WillPopScope(
      onWillPop: () async {
        homeViewModel
            .homeViewModel(model: {"user_id": PreferenceManager.getUserId()});
        return true;
      },
      child: GetBuilder<ViewProfileViewModel>(
        builder: (controller) {
          if (controller.apiResponse.status == Status.LOADING) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.apiResponse.status == Status.COMPLETE) {
            ViewProfileResponseModel profileData = controller.apiResponse.data;
            followController.getFollow(profileData.data!.isFollow!);

            return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton.extended(
                backgroundColor: Color(0xffE76944),
                onPressed: () async {
                  await getCallRateViewModel.getCallRateViewModel(
                      model: {'user_id': profileData.data!.userId});
                  if (getCallRateViewModel.getCallRateApiResponse.status
                          .toString() ==
                      Status.COMPLETE.toString()) {
                    GetCallRateResponseModel getCallRate =
                        getCallRateViewModel.getCallRateApiResponse.data;
                    if (int.parse(PreferenceManager.getCurrentBalance()) >
                        int.parse(getCallRate.data!.ratePerMinit!)) {
                      await viewProfileViewModel.agoraTokenViewModel(
                        model: {
                          "user_id": PreferenceManager.getUserId(),
                          "caller_id": profileData.data!.userId
                        },
                      );

                      if (controller.apiResponse1.status.toString() ==
                          Status.LOADING.toString()) {
                        print('LOADING');
                      }

                      if (controller.apiResponse1.status.toString() ==
                          Status.COMPLETE.toString()) {
                        print('DONE');
                        AgoraTokenResponseModel agoraToken =
                            controller.apiResponse1.data;

                        Get.to(
                          () => CallUserScreen(
                            followers: profileData.data!.earnings,
                            userImage: profileData.data!.profilePic,
                            userName: profileData.data!.username,
                            channelName: agoraToken.data!.channelName,
                            channelToken: agoraToken.data!.token,
                            userId: PreferenceManager.getUserId(),
                            secondUserId: profileData.data!.userId,
                          ),
                        );
                      } else {
                        CommonSnackBar.commonSnackBar(
                            message: 'Something went wrong!');
                      }
                    } else {
                      CommonSnackBar.commonSnackBar(
                        message: 'Low Balance',
                      );
                    }
                  } else {
                    CommonSnackBar.commonSnackBar(
                        message: 'Something went wrong');
                  }
                },
                label: Row(
                  children: [
                    Image.asset(
                      'images/Video2.png',
                      height: 15.h,
                      width: 15.h,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "Video Call",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              backgroundColor: Colors.black,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.black,
                leading: IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    homeViewModel.homeViewModel(
                      model: {
                        "user_id": PreferenceManager.getUserId(),
                      },
                    );
                    viewProfileViewModel.viewProfileViewModel(
                      model: {
                        "user_id": PreferenceManager.getUserId(),
                        "profile_id": PreferenceManager.getUserId()
                      },
                    );
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  '${profileData.data!.username}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        bottomSheet(context);
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ))
                ],
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: ImageLoading(
                                url: '${profileData.data!.profilePic}',
                                height: 60.h,
                                width: 60.h,
                              ),
                            ),
                            Baseline(
                              baseline: 1,
                              baselineType: TextBaseline.alphabetic,
                              child: Container(
                                decoration: ShapeDecoration(
                                    color: Color(0xffEB5757),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: const BorderSide(
                                            width: 1,
                                            color: Colors.transparent))),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Image.asset('images/1040230 1.png'),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        'Lv ${profileData.data!.level}',
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
                                '${profileData.data!.shorts!.length}',
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
                                      fontSize: 12),
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
                                  '${profileData.data!.followings}',
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
                                        fontSize: 12),
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
                                  '${profileData.data!.followers}',
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
                                      fontSize: 12,
                                    ),
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
                            '${profileData.data!.name}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          '${profileData.data!.bio}',
                          style: TextStyle(
                            color: Color(0Xff81818A),
                          ),
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
                                  "${profileData.data!.region}",
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
                                  ))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset("images/7917749 3.png"),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "${profileData.data!.language}",
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
                                  ))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset("images/7917749 3.png"),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "${profileData.data!.language}",
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
                                Image.asset('images/1019173 1.png'),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "${profileData.data!.gender}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: 44.h,
                          width: Get.width / 2.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff53B175),
                            ),

                            onPressed: () async {
                              print('FOLLOWERS');
                              print(
                                  'FOLLOWSTATUSingh${followController.follow}');
                              if (followController.follow == 0) {
                                await followViewModel.followViewModel(model: {
                                  "user_id": PreferenceManager.getUserId(),
                                  "following_id": profileData.data!.userId
                                });

                                if (followViewModel.followApiResponse.status ==
                                    Status.COMPLETE) {
                                  followController.getFollow(1);

                                  print('FOLLOW111');

                                  CommonSnackBar.commonSnackBar(
                                      message: 'Follow');
                                }
                              } else if (followController.follow == 1) {
                                await followViewModel.unFollowViewModel(model: {
                                  "user_id": PreferenceManager.getUserId(),
                                  "following_id": profileData.data!.userId
                                });
                                if (followViewModel
                                        .unFollowApiResponse.status ==
                                    Status.COMPLETE) {
                                  followController.getFollow(0);

                                  print('unFOLLOW111');

                                  CommonSnackBar.commonSnackBar(
                                      message: 'Unfollow');
                                }
                              }
                            },
                            // textColor: Colors.white,
                            child: GetBuilder<FollowController>(
                              builder: (controller2) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (controller2.follow == 0)
                                    Icon(Icons.person_add_alt),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    controller2.follow == 0
                                        ? "Follow"
                                        : "Unfollow",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () {
                              userChat(
                                  userImage: profileData.data!.profilePic,
                                  userName: profileData.data!.username,
                                  name: profileData.data!.name,
                                  userId1: profileData.data!.userId);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              height: 44.h,
                              width: Get.width / 2.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.chat_bubble_outline,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Chat",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
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
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        Get.to(
                          () => Gift_Collection(
                            userId: profileData.data!.userId,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        height: 48.h,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
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
                  Expanded(
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: profileData.data!.shorts!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) => LiveCard(
                        url: profileData.data!.shorts![index].short!,
                        image: profileData.data!.profilePic,
                        bio: profileData.data!.bio,
                        name: profileData.data!.username,
                        follower: profileData.data!.followers.toString(),
                      ),
                    ),
                  ),
                ],
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
      ),
    );
  }

  // LiveCard() {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.of(context)
  //           .push(MaterialPageRoute(builder: (context) => Live()));
  //     },
  //     child: Container(
  //       // child: VideoPlayer(),
  //       color: Colors.red,
  //     ),
  //   );
  // }
// }

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  // Get.back();
                  Report(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.cancel_outlined,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Report...",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                indent: 32,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.block,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Block @kierrasaris564",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Divider(
                indent: 32,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Image.asset("images/Send.png"),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Block @kierrasaris564",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        );
      },
    );
  }

  Report(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Color(0xfff1A1A27),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Divider(
                    color: Colors.grey,
                    indent: 170,
                    endIndent: 170,
                    thickness: 2.5,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Center(
                      child: Text(
                    "Report",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  )),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Report2(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Pornographic",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
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
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
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
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
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
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
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
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
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
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Report2(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Color(0xfff1A1A27),
      builder: (context) {
        return ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Divider(
                  color: Colors.grey,
                  indent: 170,
                  endIndent: 170,
                  thickness: 2.5,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Center(
                    child: Text(
                  "Report",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                )),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "    Write your report reason",
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
                                borderSide:
                                    BorderSide(color: Color(0xff81818A)),
                                borderRadius: BorderRadius.circular(30)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff81818A),
                                ),
                                borderRadius: BorderRadius.circular(30)),
                            hintStyle: TextStyle(color: Color(0xff81818A)),
                            hintText: 'Type Here',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: Get.height * 0.06,
                            width: Get.width * 0.4,
                            decoration: BoxDecoration(
                              // color: Color(0xff81818A),
                              border: Border.all(),

                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                            ),
                            // color: Color(0xff81818A),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: Get.height * 0.06,
                            width: Get.width * 0.4,
                            // color: Color(0xfffE76944),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  backgroundColor: Color(0xfffE76944)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
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
                )
              ],
            ),
          ],
        );
      },
    );
  }

  void userChat(
      {String? name,
      String? userName,
      String? userImage,
      String? userId1}) async {
    roomId = await chatRoomId(
      '${userId1}',
      '${PreferenceManager.getUserId()}',
    );

    log('CHATROOMID :- $roomId');
    x.clear();
    var querySnapshot =
        await firebaseFirestore.collection('chatroom').doc(roomId).get();

    if (querySnapshot.exists == true) {
      log('EXIST');
    } else {
      firebaseFirestore.collection('chatroom').doc(roomId).set({
        'user${PreferenceManager.getUserId()}':
            "${PreferenceManager.getUserId()}",
        'user$userId1': "$userId1",
        'user': PreferenceManager.getUserId(),
        'user1': userId1,
      });
    }
    Get.to(
      () => ChatRoomScreen(
        name: name,
        userImage: userImage,
        chatRoomId: '${roomId}',
        userId: userId1,
      ),
    );
  }
}
