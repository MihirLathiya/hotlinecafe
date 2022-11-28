import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/Screen/leadorboard_screen.dart';
import 'package:hotlinecafee/ViewModel/explore_view_model.dart';
import 'package:hotlinecafee/common/snackbar.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:hotlinecafee/model/response_model/explore_res_model.dart';
import 'package:hotlinecafee/model/response_model/language_list_res_model.dart';
import 'package:hotlinecafee/model/response_model/region_res_model.dart';
import 'package:hotlinecafee/screen/Live/join_live_screen.dart';
import 'package:permission_handler/permission_handler.dart' as permission;

import '../common/loading.dart';
import 'go_live.dart';
import 'viewProfile.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  var selectTab = 0;

  TextEditingController search = TextEditingController();
  TabController? _tabController;

  ExploreViewModel exploreViewModel = Get.put(ExploreViewModel());
  ExploreResponseModel exploreResponseModel = ExploreResponseModel();

  List<String> tabs = ['All', 'Popular', 'Live', 'VS', 'Nearby', 'New'];
  // late PermissionStatus _permissionGranted;

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);

    exploreViewModel.exploreViewModel(model: {
      "user_id": PreferenceManager.getUserId(),
      "lattitude": PreferenceManager.getLatitude(),
      "longitude": PreferenceManager.getLongitude(),
      'search': '',
    });
    languageList();

    super.initState();
  }

  LanguageListResponseModel? languageListResponseModel;
  RegionListResponseModel? regionListResponseModel;
  void languageList() async {
    await exploreViewModel.languageListViewModel(model: {
      "user_id": PreferenceManager.getUserId(),
    });
    await exploreViewModel.regionListViewModel(model: {
      "user_id": PreferenceManager.getUserId(),
    });

    if (exploreViewModel.languageListApiResponse.status == Status.COMPLETE) {
      languageListResponseModel = exploreViewModel.languageListApiResponse.data;
      log('LANGUAGE DATA :- ${languageListResponseModel!.data![0].language}');
    }
    if (exploreViewModel.regionListApiResponse.status == Status.COMPLETE) {
      regionListResponseModel = exploreViewModel.regionListApiResponse.data;
      log('REGION DATA :- ${regionListResponseModel!.data![0].name}');
    }
  }

  FilterController filterController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffE76944),
        onPressed: () {
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
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Explore",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      splashRadius: 18,
                      onPressed: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LeaderBoardScreen(),
                          ),
                        );
                      },
                      icon: SvgPicture.asset(
                        'images/svg/Chart.svg',
                        height: 20.h,
                        width: 20.h,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 10.h,
          ),
          TabBar(
            // indicatorPadding: EdgeInsets.only(left: 10, right: 0),
            indicatorColor: Color(0xffE76944),
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.only(left: 10, right: 0, bottom: 5),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            controller: _tabController,
            onTap: (val) {
              setState(() {
                selectTab = val;
              });
            },
            tabs: List.generate(
              tabs.length,
              (index) => Text(tabs[index]),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.h, left: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Color(0xff242424),
                      ),
                    ),
                    child: Center(
                      child: TextField(
                        onSubmitted: (value) async {
                          await exploreViewModel.exploreViewModel(model: {
                            "user_id": PreferenceManager.getUserId(),
                            "lattitude": PreferenceManager.getLatitude(),
                            "longitude": PreferenceManager.getLongitude(),
                            "search": search.text.trim(),
                            'region': filterController.country.value,
                            'language': filterController.languages.value
                          });
                        },
                        onChanged: (value) async {
                          await exploreViewModel.exploreViewModel(
                            model: {
                              "user_id": PreferenceManager.getUserId(),
                              "lattitude": PreferenceManager.getLatitude(),
                              "longitude": PreferenceManager.getLongitude(),
                              "search": search.text.trim(),
                              'region': filterController.country.value,
                              'language': filterController.languages.value
                            },
                          );
                        },
                        style: TextStyle(color: Color(0xff4F4F5B)),
                        controller: search,
                        decoration: InputDecoration(
                          // contentPadding: EdgeInsets.symmetric(vertical: ),
                          border: InputBorder.none,
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'images/svg/search.svg',
                                height: 24.h,
                                width: 24.h,
                              ),
                            ],
                          ),
                          hintText: 'Search Friend',
                          hintStyle: TextStyle(
                            color: Color(0xff4F4F5B),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    showFilterSheet(
                      languageListResponseModel: languageListResponseModel,
                      regionListResponseModel: regionListResponseModel,
                    );
                  },
                  child: Container(
                    height: 48.h,
                    width: 48.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Color(0xff242424),
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'images/svg/Filter.svg',
                        height: 24.h,
                        width: 24.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          GetBuilder<ExploreViewModel>(
            builder: (controller) {
              if (controller.apiResponse.status.toString() ==
                  Status.LOADING.toString()) {
                return ShimmerHomeLoad(context);
              }

              if (controller.apiResponse.status.toString() ==
                  Status.COMPLETE.toString()) {
                ExploreResponseModel exploreResponse =
                    controller.apiResponse.data;

                return MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Expanded(
                    child: TabBarView(
                      // physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        MasonryGridView.count(
                          physics: BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          itemCount: exploreResponse.data!.all!.length,
                          itemBuilder: (context, index) {
                            return LiveCard(
                                userId:
                                    exploreResponse.data!.all![index].userId,
                                follower:
                                    exploreResponse.data!.all![index].follower,
                                name:
                                    exploreResponse.data!.all![index].username,
                                view: exploreResponse.data!.all![index].view,
                                channelName: exploreResponse
                                    .data!.all![index].channelName,
                                channelToken:
                                    exploreResponse.data!.all![index].token,
                                profilePic: exploreResponse
                                    .data!.all![index].profilePic,
                                isLive:
                                    exploreResponse.data!.all![index].isLive);
                          },
                        ),
                        MasonryGridView.count(
                          physics: BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          itemCount: exploreResponse.data!.popular!.length,
                          itemBuilder: (context, index) {
                            return LiveCard(
                                channelName: exploreResponse
                                    .data!.popular![index].channelName,
                                channelToken:
                                    exploreResponse.data!.popular![index].token,
                                userId: exploreResponse
                                    .data!.popular![index].userId,
                                follower: exploreResponse
                                    .data!.popular![index].follower,
                                name: exploreResponse
                                    .data!.popular![index].username,
                                view:
                                    exploreResponse.data!.popular![index].view,
                                profilePic: exploreResponse
                                    .data!.popular![index].profilePic,
                                isLive: exploreResponse
                                    .data!.popular![index].isLive);
                          },
                        ),
                        MasonryGridView.count(
                          physics: BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          itemCount: exploreResponse.data!.live!.length,
                          itemBuilder: (context, index) {
                            log('CHANNEL NAME :- ${exploreResponse.data!.live![index]}');
                            return LiveCard(
                                channelName: exploreResponse
                                    .data!.live![index].channelName,
                                channelToken:
                                    exploreResponse.data!.live![index].token,
                                userId:
                                    exploreResponse.data!.live![index].userId,
                                follower:
                                    exploreResponse.data!.live![index].follower,
                                name:
                                    exploreResponse.data!.live![index].username,
                                view: exploreResponse.data!.live![index].view,
                                profilePic: exploreResponse
                                    .data!.live![index].profilePic,
                                isLive:
                                    exploreResponse.data!.live![index].isLive);
                          },
                        ),
                        MasonryGridView.count(
                          physics: BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          itemCount: exploreResponse.data!.vs!.length,
                          itemBuilder: (context, index) {
                            return VsLiveCard(
                              fromDataChannelName: exploreResponse
                                  .data!.vs![index].fromData!.channelName,
                              fromDataChannelToken: exploreResponse
                                  .data!.vs![index].fromData!.channelName,
                              fromDataUserId: exploreResponse
                                  .data!.vs![index].fromData!.userId,
                              fromDataFollower: exploreResponse
                                  .data!.vs![index].fromData!.follower,
                              fromDataName: exploreResponse
                                  .data!.vs![index].fromData!.name,
                              fromDataView: exploreResponse
                                  .data!.vs![index].fromData!.view,
                              fromDataProfilePic: exploreResponse
                                  .data!.vs![index].fromData!.profilePic,
                              fromDataIsLive: exploreResponse
                                  .data!.vs![index].fromData!.isLive,
                              toDataChannelName: exploreResponse
                                  .data!.vs![index].toData!.channelName,
                              toDataChannelToken: exploreResponse
                                  .data!.vs![index].toData!.channelName,
                              toDataUserId: exploreResponse
                                  .data!.vs![index].toData!.userId,
                              toDataFollower: exploreResponse
                                  .data!.vs![index].toData!.follower,
                              toDataName:
                                  exploreResponse.data!.vs![index].toData!.name,
                              toDataView:
                                  exploreResponse.data!.vs![index].toData!.view,
                              toDataProfilePic: exploreResponse
                                  .data!.vs![index].toData!.profilePic,
                              toDataIsLive: exploreResponse
                                  .data!.vs![index].toData!.isLive,
                            );
                          },
                        ),
                        MasonryGridView.count(
                          physics: BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          itemCount: exploreResponse.data!.nearBy!.length,
                          itemBuilder: (context, index) {
                            return LiveCard(
                                channelName: exploreResponse
                                    .data!.nearBy![index].channelName,
                                channelToken:
                                    exploreResponse.data!.nearBy![index].token,
                                userId:
                                    exploreResponse.data!.nearBy![index].userId,
                                follower: exploreResponse
                                    .data!.nearBy![index].follower,
                                name: exploreResponse
                                    .data!.nearBy![index].username,
                                view: exploreResponse.data!.nearBy![index].view,
                                profilePic: exploreResponse
                                    .data!.nearBy![index].profilePic,
                                isLive: exploreResponse
                                    .data!.nearBy![index].isLive);
                          },
                        ),
                        MasonryGridView.count(
                          physics: BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          itemCount: exploreResponse.data!.dataNew!.length,
                          itemBuilder: (context, index) {
                            return LiveCard(
                                channelName: exploreResponse
                                    .data!.dataNew![index].channelName,
                                channelToken:
                                    exploreResponse.data!.dataNew![index].token,
                                userId: exploreResponse
                                    .data!.dataNew![index].userId,
                                follower: exploreResponse
                                    .data!.dataNew![index].follower,
                                name: exploreResponse
                                    .data!.dataNew![index].username,
                                view:
                                    exploreResponse.data!.dataNew![index].view,
                                profilePic: exploreResponse
                                    .data!.dataNew![index].profilePic,
                                isLive: exploreResponse
                                    .data!.dataNew![index].isLive);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (controller.apiResponse.status.toString() ==
                  Status.ERROR.toString()) {
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
    );
  }

  LiveCard({
    String? searchText,
    String? name,
    String? isLive,
    String? profilePic,
    int? follower,
    String? view,
    String? userId,
    String? channelName,
    String? channelToken,
  }) {
    return GestureDetector(
      onTap: () async {
        if (isLive == '1' && channelName != '') {
          await [permission.Permission.microphone, permission.Permission.camera]
              .request();

          log('CHANNEL NAME :- ${channelName}');
          log('CHANNEL token :- ${channelToken}');
          log('USerID :- ${userId!}');

          await Get.to(
            () => JoinLivePage(
              userId: '${userId}',
              channelName: '$channelName',
              userImage:
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
              hostImage: profilePic,
              username: PreferenceManager.getUserName(),
              hostName: name,
              channelToken: '$channelToken',
              channelId: int.parse(userId),
            ),
          );
        } else {
          CommonSnackBar.commonSnackBar(
            message: 'User Not Live',
          );
        }
      },
      child: Container(
        height: 240.h,
        margin: EdgeInsets.only(bottom: 8, right: 2, left: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black,
        ),
        child: Stack(
          children: [
            ImageLoading(
              url: '$profilePic',
              height: 240.h,
              width: Get.width,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isLive == "1"
                          ? Color(0xffEB5757)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
                      child: Text(
                        isLive == "1" ? "Live" : "",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5.0, top: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
                      child: Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                            size: 15,
                          ),
                          Text(
                            "$view",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => View_profile(
                      profileId: userId!,
                    ),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.h),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: ImageLoading(
                            url: "${profilePic}",
                            height: 28.h,
                            width: 28.h,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name!,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Text(
                              "${follower} Followers",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  VsLiveCard({
    String? fromDataName,
    String? fromDataIsLive,
    String? fromDataProfilePic,
    int? fromDataFollower,
    String? fromDataView,
    String? fromDataChannelName,
    String? fromDataChannelToken,
    String? fromDataUserId,
    String? toDataName,
    String? toDataIsLive,
    String? toDataProfilePic,
    int? toDataFollower,
    String? toDataView,
    String? toDataChannelName,
    String? toDataChannelToken,
    String? toDataUserId,
  }) {
    return GestureDetector(
      onTap: () {
        // Get.to(() => selectTab == 3 ? MyVSScreen() : Live());

        Get.to(
          () => JoinLivePage(
            userId: '${fromDataUserId}',
            channelName: '$fromDataChannelName',
            userImage: '${PreferenceManager.getUserImage()}',
            hostImage: '$fromDataProfilePic',
            username: PreferenceManager.getUserName(),
            hostName: fromDataName,
            channelToken: '$fromDataChannelToken',
            channelId: int.parse(fromDataUserId!),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 300.h,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('$fromDataProfilePic'),
                  ),
                ),
              ),
              ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('$toDataProfilePic'),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                left: -300.w,
                top: 0,
                bottom: 0,
                child: Transform.rotate(
                  angle: 2.14,
                  child: Column(
                    children: [
                      Container(
                        height: 3,
                        width: 800,
                        color: Color(0xffE76944),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
                        child: Text(
                          "VS",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.0, top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
                        child: Row(
                          children: [
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                              size: 15,
                            ),
                            Text(
                              "3.5k",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => View_profile(
                        profileId: '36',
                      ),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: ImageLoading(
                                  url: "${toDataProfilePic}",
                                  height: 28.h,
                                  width: 28.h,
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "$toDataName",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    Text(
                                      "$toDataFollower Followers",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "$fromDataName",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    Text(
                                      "${fromDataFollower} Followers",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: ImageLoading(
                                  url: "${fromDataProfilePic}",
                                  height: 28.h,
                                  width: 28.h,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future showFilterSheet(
      {LanguageListResponseModel? languageListResponseModel,
      RegionListResponseModel? regionListResponseModel}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 514.h,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                  height: 25.h,
                ),
                Text(
                  'Filter',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Divider(
                  color: Color(0xff373743),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
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
                    TextButton(
                      onPressed: () async {
                        await exploreViewModel.exploreViewModel(model: {
                          "user_id": PreferenceManager.getUserId(),
                          "lattitude": PreferenceManager.getLatitude(),
                          "longitude": PreferenceManager.getLongitude(),
                          'search': ''
                        });
                        filterController.selectedCountry(100);
                        filterController.country('');
                      },
                      child: Text(
                        'Clear',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xffE76944),
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    children: [
                      ...List.generate(
                        regionListResponseModel!.data!.length,
                        (index) => GestureDetector(
                          onTap: () {
                            filterController.selectedCountry(index);
                            filterController.selectedFilterCountry(
                                regionListResponseModel.data![index].name);
                          },
                          child: Obx(
                            () => Container(
                              margin:
                                  EdgeInsets.only(right: 18.w, bottom: 16.h),
                              padding: EdgeInsets.all(10.h),
                              decoration: BoxDecoration(
                                color: filterController.selectCountry.value ==
                                        index
                                    ? Color(0xff4B53FF)
                                    : Color(0xff373743),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: ImageLoading(
                                        url:
                                            '${regionListResponseModel.data![index].flag}',
                                        height: 18.h,
                                        width: 18.h),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    '${regionListResponseModel.data![index].name}',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                /// LANGUAGE
                Row(
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
                    TextButton(
                      onPressed: () async {
                        await exploreViewModel.exploreViewModel(model: {
                          "user_id": PreferenceManager.getUserId(),
                          "lattitude": PreferenceManager.getLatitude(),
                          "longitude": PreferenceManager.getLongitude(),
                          'search': ''
                        });
                        filterController.selectedLanguage(100);
                        filterController.languages('');
                      },
                      child: Text(
                        'Clear',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xffE76944),
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    children: [
                      ...List.generate(
                        languageListResponseModel!.data!.length,
                        (index) => GestureDetector(
                          onTap: () {
                            filterController.selectedLanguage(index);

                            filterController.selectedFilterLanguage(
                                languageListResponseModel
                                    .data![index].language);
                          },
                          child: Obx(
                            () => Container(
                              margin: EdgeInsets.only(
                                right: 12.w,
                                bottom: 16.h,
                              ),
                              padding: EdgeInsets.all(10.h),
                              decoration: BoxDecoration(
                                color: filterController.selectLanguage.value ==
                                        index
                                    ? Color(0xff4B53FF)
                                    : Color(0xff373743),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${languageListResponseModel.data![index].language}',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xffE76944)),
                  onPressed: () async {
                    filerOnPress();

                    Get.back();
                  },
                  child: Text(
                    'Apply',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    ).whenComplete(() async {
      filerOnPress();
    });
  }

  filerOnPress() async {
    log('==========LANGUAGE========== ${filterController.languages.value}');
    log('==========COUNTRY========== ${filterController.country.value}');

    if (filterController.country.value != '' ||
        filterController.languages.value != '') {
      await exploreViewModel.exploreViewModel(model: {
        "user_id": PreferenceManager.getUserId(),
        "lattitude": PreferenceManager.getLatitude(),
        "longitude": PreferenceManager.getLongitude(),
        "search": search.text.trim(),
        'region': filterController.country.value,
        'language': filterController.languages.value
      });
    }
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.h;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(210.h, 0.h);
    path.lineTo(0.h, 330.h);
    path.lineTo(0.h, 0.h);
    path.lineTo(300.h, 300.h);
    path.lineTo(250.h, 250.h);
    path.lineTo(0.h, 0.h);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
