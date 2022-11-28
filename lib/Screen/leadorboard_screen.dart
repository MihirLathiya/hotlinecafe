import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Model/Response_model/leadorboard_res_model.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/ViewModel/leaderboard_view_model.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen>
    with SingleTickerProviderStateMixin {
  List tab = ['Charm', 'Rich', 'Receiver', 'Gifter'];
  TabController? _tabController;
  LeaderboardViewModel leaderboardViewModel = Get.put(LeaderboardViewModel());
  int selectTab = 0;
  @override
  void initState() {
    _tabController = TabController(length: tab.length, vsync: this);
    if (selectTab == 0) {
      leaderboardViewModel.leaderboardViewModel(model: {
        'user_id': PreferenceManager.getUserId(),
        'type': 'Charm',
      });
      // if()
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        bottom: PreferredSize(
            child: Divider(color: Color(0xff242424), thickness: 2),
            preferredSize: Size.fromHeight(4.h)),
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
        actions: [
          Image.asset(
            'images/indiaflag.png',
            fit: BoxFit.cover,
            height: 60.h,
            width: 60.h,
          )
        ],
        title: Text(
          'LeaderBoard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          TabBar(
            // isScrollable: true,
            onTap: (val) async {
              setState(() {
                selectTab = val;
              });

              log('selectTab :-$selectTab');
              if (selectTab == 0) {
                await leaderboardViewModel.leaderboardViewModel(model: {
                  'user_id': PreferenceManager.getUserId(),
                  'type': 'Charm',
                });
              } else if (selectTab == 1) {
                await leaderboardViewModel.leaderboardViewModel(model: {
                  'user_id': PreferenceManager.getUserId(),
                  'type': 'Rich',
                });
              } else if (selectTab == 2) {
                await leaderboardViewModel.leaderboardViewModel(model: {
                  'user_id': PreferenceManager.getUserId(),
                  'type': 'Reciever',
                });
              } else {
                await leaderboardViewModel.leaderboardViewModel(model: {
                  'user_id': PreferenceManager.getUserId(),
                  'type': 'Gifter',
                });
              }
              // if(se)
            },
            controller: _tabController,
            indicatorColor: Color(0xffE76944),
            indicatorWeight: 4,
            tabs: List.generate(
              tab.length,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 12.sp, top: 10),
                child: FittedBox(
                  child: Text(
                    '${tab[index]}',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<LeaderboardViewModel>(
              builder: (controller) {
                if (controller.leaderboardApiResponse.status.toString() ==
                    Status.LOADING.toString()) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (controller.leaderboardApiResponse.status.toString() ==
                    Status.COMPLETE.toString()) {
                  LeaderboardResponseModel response =
                      controller.leaderboardApiResponse.data;
                  return TabBarView(
                    controller: _tabController,
                    children: [
                      ...List.generate(
                        4,
                        (index) => Charm(
                          data: response,
                        ),
                      ),
                    ],
                  );
                } else {
                  if (controller.leaderboardApiResponse.status.toString() ==
                      Status.ERROR.toString()) {
                    return Center(
                      child: Text('Something went wrong'),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class Charm extends StatefulWidget {
  final LeaderboardResponseModel? data;
  const Charm({Key? key, this.data}) : super(key: key);

  @override
  State<Charm> createState() => _CharmState();
}

class _CharmState extends State<Charm> with SingleTickerProviderStateMixin {
  List charmTab = [
    'Daily',
    'Monthly',
  ];
  PageController pageController = PageController(initialPage: 0);
  var pageSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 15.sp,
          ),
          Container(
            height: 45.h,
            width: Get.width - 30.sp,
            decoration: BoxDecoration(
              color: Color(0xff81818A),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              children: [
                ...List.generate(
                  charmTab.length,
                  (index) => InkWell(
                    onTap: () {
                      setState(() {
                        pageSelected = index;
                        pageController.jumpToPage(index);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 45.h,
                      width: Get.width / 2.19,
                      decoration: BoxDecoration(
                          color: pageSelected == index
                              ? Color(0xffE76944)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(100)),
                      child: Text(
                        '${charmTab[index]}',
                        style: TextStyle(
                            color: pageSelected == index
                                ? Colors.white
                                : Colors.grey,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  pageSelected = value;
                });
              },
              children: [
                widget.data!.data!.today!.length != 0
                    ? ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: widget.data!.data!.today!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 14.sp),
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 28.h,
                                  width: 28.h,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage(index == 0
                                        ? "images/Polygon 1.png"
                                        : index == 1
                                            ? "images/Polygon 1.png"
                                            : index == 2
                                                ? "images/Polygon 12.png"
                                                : ''),
                                    fit: BoxFit.fill,
                                  )),
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: index == 0
                                            ? Color(0xff6B3600)
                                            : index == 1
                                                ? Color(0xff6B3600)
                                                : Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  width: 18.w,
                                ),
                                CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25.sp,
                                    backgroundImage: NetworkImage(
                                        "${widget.data!.data!.today![index].profilePic}")),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.data!.data!.today![index].name}',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 23.h,
                                          width: 50.w,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 3),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25.sp),
                                              color: Color(0xffEB5757)),
                                          child: FittedBox(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'images/1040230 12.png',
                                                ),
                                                SizedBox(
                                                  width: 8.sp,
                                                ),
                                                Text(
                                                  'Lv ${widget.data!.data!.today![index].level}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    // fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Image.asset(
                                          'images/Dimond_fill.png',
                                          height: 22.sp,
                                          width: 22.sp,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text(
                                          '${widget.data!.data!.today![index].coins}',
                                          style: TextStyle(
                                            color: Color(0xff81818A),
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'No data',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                widget.data!.data!.monthly!.length != 0
                    ? ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: widget.data!.data!.monthly!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 14.sp),
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 28.h,
                                  width: 28.h,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage(index == 0
                                        ? "images/Polygon 1.png"
                                        : index == 1
                                            ? "images/Polygon 1.png"
                                            : index == 2
                                                ? "images/Polygon 12.png"
                                                : ''),
                                    fit: BoxFit.fill,
                                  )),
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: index == 0
                                            ? Color(0xff6B3600)
                                            : index == 1
                                                ? Color(0xff6B3600)
                                                : Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  width: 18.w,
                                ),
                                CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25.sp,
                                    backgroundImage: NetworkImage(
                                        "${widget.data!.data!.monthly![index].profilePic}")),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.data!.data!.monthly![index].name}',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 23.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 3),
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25.sp),
                                              color: Color(0xffEB5757)),
                                          child: FittedBox(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'images/1040230 12.png',
                                                ),
                                                SizedBox(
                                                  width: 8.sp,
                                                ),
                                                Text(
                                                  'Lv ${widget.data!.data!.monthly![index].level}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    // fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Image.asset(
                                          'images/Dimond_fill.png',
                                          height: 22.sp,
                                          width: 22.sp,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text(
                                          '${widget.data!.data!.monthly![index].coins}',
                                          style: TextStyle(
                                              color: Color(0xff81818A),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'No data',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
