import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Model/Response_model/daat.dart';
import 'package:hotlinecafee/Model/Response_model/get_call_rate_res_model.dart';
import 'package:hotlinecafee/Model/Response_model/random_count_res_model.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/Screen/call_user_screen.dart';
import 'package:hotlinecafee/Screen/notification.dart';
import 'package:hotlinecafee/ViewModel/get_call_rate_view_model.dart';
import 'package:hotlinecafee/ViewModel/home_view_model.dart';
import 'package:hotlinecafee/ViewModel/location_view_model.dart';
import 'package:hotlinecafee/ViewModel/random_count_view_model.dart';
import 'package:hotlinecafee/ViewModel/random_match_view_model.dart';
import 'package:hotlinecafee/common/chat_commons.dart';
import 'package:hotlinecafee/common/loading.dart';
import 'package:hotlinecafee/common/snackbar.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:hotlinecafee/model/response_model/home_res_model.dart';
import 'package:hotlinecafee/model/response_model/location_res_model.dart';
import 'package:hotlinecafee/screen/Live/join_live_screen.dart';
import 'package:hotlinecafee/screen/Random_match/random_match_screen.dart';
import 'package:hotlinecafee/screen/preview_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permission;

import 'go_live.dart';
import 'viewProfile.dart';

class MyHomeScreen extends StatefulWidget {
  final userId;
  const MyHomeScreen({Key? key, this.userId}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen>
    with TickerProviderStateMixin {
  // LiveController liveController = Get.put(LiveController());
  RandomMatchViewModel onOffRandomMatchViewModel = Get.find();
  GetCallRateViewModel getCallRateViewModel = Get.put(GetCallRateViewModel());

  final ImagePicker _picker = ImagePicker();
  File? _image;
  final imagePicker = ImagePicker();
  XFile? photo;
  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  /// HomeScreen Api
  HomeViewModel homeViewModel = Get.find();

  Future<void> videos() async {
    photo = await _picker.pickVideo(source: ImageSource.camera);
    print('PHOTO >>${photo!.path}');
  }

  LocationViewModel locationViewModel = Get.put(LocationViewModel());
  LocationResponseModel responseModel = LocationResponseModel();
  RandomCountViewModel randomCountViewModel = Get.put(RandomCountViewModel());
  late bool serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? userLocation;

  Future<void> getUserLocation() async {
    Location location = Location();

    // Check if location service is enable
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        _permissionGranted = await location.requestPermission();
      }
    }

    final locationData = await location.getLocation();
    // setState(() {
    userLocation = locationData;
    PreferenceManager.setLatitude(userLocation!.latitude.toString());
    PreferenceManager.setLongitude(userLocation!.longitude.toString());
    // });

    await locationViewModel.locationViewModel(model: {
      "user_id": PreferenceManager.getUserId(),
      "lattitude": userLocation!.latitude.toString(),
      "longitude": userLocation!.longitude.toString(),
    });

    if (locationViewModel.apiResponse.status == Status.COMPLETE) {
      log('Done');
    } else {
      log('Fail');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserLocation();

    homeViewModel
        .homeViewModel(model: {"user_id": PreferenceManager.getUserId()});
  }

  var waitingList = [];
  Future getWaitingData() async {
    var data =
        await firebaseFirestore.collection('pairing_system').doc('data').get();
    Map<String, dynamic>? userData = data.data();

    setState(() {
      waitingList = userData!['waiting'];
    });

    print('WAITING LIST :- $waitingList');
    return waitingList;
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffE76944),
        onPressed: () async {
          Get.to(() => CameraApp());
        },
        child: Image.asset(
          'images/Video2.png',
          height: 20.h,
          width: 20.w,
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hotline Cafe",
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        await videos().then(
                          (value) {
                            Get.to(
                              () => PreviewScreen(
                                videoFile: photo!.path.toString(),
                              ),
                            );
                          },
                        );
                      },
                      child: SvgPicture.asset(
                        'images/svg/add.svg',
                        height: 24.h,
                        width: 24.h,
                      ),
                    ),
                    SizedBox(width: 27.w),
                    InkWell(
                      onTap: () {
                        Get.to(() => NotificationScreen());
                      },
                      child: SvgPicture.asset(
                        'images/svg/Notification.svg',
                        height: 24.h,
                        width: 24.h,
                      ),
                    ),
                    // SizedBox(width: 27.w),
                    // InkWell(
                    //   onTap: () async {
                    //     Get.to(() => MyHomePage());
                    //   },
                    //   child: Icon(
                    //     Icons.store_mall_directory_outlined,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              "Welcome ${PreferenceManager.getUserName()} !",
              style: TextStyle(fontSize: 14, color: Color(0xff81818A)),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: () async {
                await onOffRandomMatchViewModel.randomMatchOnOffViewModel(
                    model: {
                      'user_id': PreferenceManager.getUserId(),
                      'on_off': '1'
                    });
                if (onOffRandomMatchViewModel.randomOnOffApiResponse.status ==
                    Status.ERROR) {
                  return CommonSnackBar.commonSnackBar(
                      message: 'Something went wrong');
                }
                if (onOffRandomMatchViewModel.randomOnOffApiResponse.status ==
                    Status.COMPLETE) {
                  // RandomMatchOnOffResponseModel responseOnOffModel;
                  var responseOnOffModel =
                      onOffRandomMatchViewModel.randomOnOffApiResponse.data;
                  await randomCountViewModel.randomCountViewModel(model: {
                    'user_id': PreferenceManager.getUserId(),
                  });
                  if (randomCountViewModel.randomCountApiResponse.status ==
                      Status.ERROR) {
                    return CommonSnackBar.commonSnackBar(
                        message: 'Something went wrong');
                  }
                  if (randomCountViewModel.randomCountApiResponse.status
                          .toString() ==
                      Status.COMPLETE.toString()) {
                    RandomCountResponseModel responseModel =
                        randomCountViewModel.randomCountApiResponse.data;
                    log('===========DATA${responseModel.data!.count.toString()}');
                    Get.to(
                      () => RandomMatchScreen(
                        count: responseModel.data!.count.toString(),
                        id: responseOnOffModel.data!.channelName,
                        token: responseOnOffModel.data!.token,
                      ),
                    );
                    await getWaitingData();
                    log('LIST :- ${waitingList}');

                    if (waitingList.contains(PreferenceManager.getUserId())) {
                      log('ALREADY CONTAIN');
                    } else {
                      waitingList.add(PreferenceManager.getUserId());
                    }
                    await waitingList.toSet().toList();
                    await FirebaseFirestore.instance
                        .collection('pairing_system')
                        .doc('data')
                        .update(
                      {
                        'waiting': waitingList,
                      },
                    );
                    await FirebaseFirestore.instance
                        .collection('user')
                        .doc('${PreferenceManager.getUserId()}')
                        .update(
                      {
                        'id': responseOnOffModel.data!.channelName,
                        'token': responseOnOffModel.data!.token,
                      },
                    );

                    waitingList.clear();
                  }
                }
              },
              child: Image.asset(
                'images/randomMatch.png',
                height: 88.h,
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 50,
            width: double.infinity,
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                unselectedLabelStyle:
                    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                labelStyle:
                    TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w900),
                indicatorColor: Color(0xffE76944),
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.only(left: 10, right: 0),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                controller: _tabController,
                isScrollable: true,
                tabs: [
                  Tab(
                    text: "For You",
                  ),
                  Tab(
                    text: "Following",
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Container(
            child: Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                controller: _tabController,
                children: [
                  /// FOR YOU
                  GetBuilder<HomeViewModel>(
                    builder: (controller) {
                      if (controller.apiResponse.status == Status.LOADING) {
                        return ShimmerHomeLoad(context);
                      }

                      if (controller.apiResponse.status == Status.COMPLETE) {
                        HomeResponseModel homResponse =
                            controller.apiResponse.data;

                        return GridView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          itemCount: homResponse.data?.forYou?.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  childAspectRatio: 0.7),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                if (homResponse.data?.forYou?[index].isLive ==
                                        '1' &&
                                    homResponse
                                            .data?.forYou?[index].channelName !=
                                        "") {
                                  await [
                                    permission.Permission.microphone,
                                    permission.Permission.camera
                                  ].request();

                                  log('CHANNEL NAME :- ${homResponse.data?.forYou?[index].channelName}');
                                  log('CHANNEL token :- ${homResponse.data!.forYou![index].token}');
                                  log('USerID :- ${homResponse.data!.forYou![index].userId!}');

                                  await Get.to(
                                    () => JoinLivePage(
                                      userId: homResponse
                                          .data!.forYou![index].userId!,
                                      channelName: homResponse
                                          .data?.forYou?[index].channelName,
                                      userImage:
                                          PreferenceManager.getUserImage(),
                                      hostImage: homResponse
                                          .data!.forYou![index].profilePic,
                                      username: PreferenceManager.getUserName(),
                                      hostName: homResponse
                                          .data!.forYou![index].username,
                                      channelToken: homResponse
                                          .data!.forYou![index].token,
                                      channelId: int.parse(homResponse
                                          .data!.forYou![index].userId!),
                                    ),
                                  );
                                } else {
                                  CommonSnackBar.commonSnackBar(
                                    message: 'User Not Live',
                                  );
                                }
                              },
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  // color: Colors.black,?
                                ),
                                child: Stack(
                                  children: [
                                    ImageLoading(
                                      url:
                                          "${homResponse.data?.forYou?[index].profilePic}",
                                      height: Get.height,
                                      width: Get.width,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5.0, left: 5.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: homResponse
                                                            .data
                                                            ?.forYou?[index]
                                                            .isLive ==
                                                        "1"
                                                    ? Color(0xffEB5757)
                                                    : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.0, vertical: 2),
                                              child: Text(
                                                homResponse.data?.forYou?[index]
                                                            .isLive ==
                                                        "1"
                                                    ? "Live"
                                                    : "",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 5.0, top: 5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.0, vertical: 2),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.remove_red_eye,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                  Text(
                                                    "${homResponse.data?.forYou?[index].view}",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 5.h),
                                      child: GestureDetector(
                                        onTap: () async {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  View_profile(
                                                profileId: homResponse.data!
                                                    .forYou![index].userId!,
                                                // follow: homResponse.data.forYou[index].,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1000),
                                                  child: ImageLoading(
                                                    url:
                                                        "${homResponse.data?.forYou?[index].profilePic}",
                                                    height: 28.h,
                                                    width: 28.h,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${homResponse.data?.forYou?[index].username}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      "${homResponse.data?.forYou?[index].follower} Followers",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      if (controller.apiResponse.status == Status.ERROR) {
                        return Center(
                          child: Text(
                            'Something went wrong',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else
                        return SizedBox();
                    },
                  ),

                  /// FOLLOWING
                  GetBuilder<HomeViewModel>(
                    builder: (controller) {
                      if (controller.apiResponse.status == Status.LOADING) {
                        return ShimmerHomeLoad(context);
                      }

                      if (controller.apiResponse.status == Status.COMPLETE) {
                        HomeResponseModel homResponse1 =
                            controller.apiResponse.data;
                        return GridView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: homResponse1.data!.following!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  childAspectRatio: 0.7),
                          itemBuilder: (context, index) {
                            var data1 = homResponse1.data!.following![index];
                            return GestureDetector(
                              onTap: () async {
                                if (homResponse1
                                            .data?.following?[index].isLive ==
                                        '1' &&
                                    homResponse1.data?.following?[index]
                                            .channelName !=
                                        "") {
                                  await [
                                    permission.Permission.microphone,
                                    permission.Permission.camera
                                  ].request();

                                  await Get.to(
                                    () => JoinLivePage(
                                      userId: homResponse1
                                          .data!.following![index].userId!,
                                      channelName: homResponse1
                                          .data?.following?[index].channelName,
                                      userImage:
                                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
                                      hostImage: homResponse1
                                          .data!.following![index].profilePic,
                                      username: PreferenceManager.getUserName(),
                                      hostName: homResponse1
                                          .data!.following![index].username,
                                      channelToken: homResponse1
                                          .data!.following![index].token,
                                      channelId: int.parse(
                                        homResponse1
                                            .data!.following![index].userId!,
                                      ),
                                    ),
                                  );
                                } else {
                                  CommonSnackBar.commonSnackBar(
                                    message: 'User Not Live',
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black,
                                ),
                                child: Stack(
                                  children: [
                                    ImageLoading(
                                      url: '${data1.profilePic}',
                                      height: Get.height,
                                      width: Get.width,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5.0, left: 5.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: data1.isLive == "1"
                                                    ? Color(0xffEB5757)
                                                    : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.0, vertical: 2),
                                              child: Text(
                                                data1.isLive == "1"
                                                    ? "Live"
                                                    : "",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 5.0, top: 5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.0, vertical: 2),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.remove_red_eye,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                  Text(
                                                    "${data1.view}",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(5.h),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          View_profile(
                                                        profileId: data1
                                                            .userId!, // follow: data1.,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              1000),
                                                      child: ImageLoading(
                                                        url:
                                                            "${data1.profilePic}",
                                                        height: 28.h,
                                                        width: 28.h,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 4.w,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${data1.username}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                          "${data1.follower} Followers",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 10),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              GestureDetector(
                                                onTap: () async {
                                                  await getCallRateViewModel
                                                      .getCallRateViewModel(
                                                          model: {
                                                        'user_id': data1.userId
                                                      });

                                                  if (getCallRateViewModel
                                                          .getCallRateApiResponse
                                                          .status ==
                                                      Status.COMPLETE) {
                                                    GetCallRateResponseModel
                                                        getCallRate =
                                                        getCallRateViewModel
                                                            .getCallRateApiResponse
                                                            .data;
                                                    log('SECOND USER CALL RATE :- ${getCallRate.data!.ratePerMinit.runtimeType}');
                                                    if (int.parse(PreferenceManager
                                                            .getCurrentBalance()) >
                                                        int.parse(getCallRate
                                                            .data!
                                                            .ratePerMinit!)) {
                                                      await homeViewModel
                                                          .agoraTokenViewModel(
                                                              model: {
                                                            "user_id":
                                                                PreferenceManager
                                                                    .getUserId(),
                                                            "caller_id":
                                                                data1.userId
                                                          });

                                                      if (controller
                                                              .apiResponse1
                                                              .status ==
                                                          Status.LOADING) {
                                                        print('LOADING');
                                                      }

                                                      if (controller
                                                              .apiResponse1
                                                              .status ==
                                                          Status.COMPLETE) {
                                                        print('DONE');
                                                        AgoraTokenResponseModel
                                                            agoraToken =
                                                            controller
                                                                .apiResponse1
                                                                .data;
                                                        // liveController.bordCaster();
                                                        print(
                                                            'VIDEO CALL TOKEN ${agoraToken.data!.token}');

                                                        Get.to(
                                                          () => CallUserScreen(
                                                            secondUserId:
                                                                data1.userId,
                                                            followers:
                                                                data1.follower,
                                                            userImage: data1
                                                                .profilePic,
                                                            userName:
                                                                data1.username,
                                                            channelName:
                                                                agoraToken.data!
                                                                    .channelName,
                                                            channelToken:
                                                                agoraToken.data!
                                                                    .token,
                                                            // userType: liveController
                                                            //     .isBrodCaster.value,
                                                            userId:
                                                                PreferenceManager
                                                                    .getUserId(),
                                                          ),
                                                        );
                                                      } else {
                                                        CommonSnackBar
                                                            .commonSnackBar(
                                                          message:
                                                              'Something went wrong!',
                                                        );
                                                      }
                                                    } else {
                                                      CommonSnackBar
                                                          .commonSnackBar(
                                                              message:
                                                                  'Low Balance');
                                                    }
                                                  }
                                                },
                                                child: SvgPicture.asset(
                                                  'images/call.svg',
                                                  height: 36,
                                                  width: 36,
                                                ),
                                              ),
                                              SizedBox(width: 3),
                                            ],
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
                      } else if (controller.apiResponse.status ==
                          Status.ERROR) {
                        return Center(
                          child: Text(
                            'Something went wrong',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else
                        return SizedBox();
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
