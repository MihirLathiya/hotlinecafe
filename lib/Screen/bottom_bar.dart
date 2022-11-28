import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Model/Apis/api_response.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/ViewModel/current_blance_view-model.dart';
import 'package:hotlinecafee/ViewModel/delete_controller.dart';
import 'package:hotlinecafee/screen/explore.dart';
import 'package:hotlinecafee/screen/home.dart';
import 'package:hotlinecafee/screen/myProfile.dart';
import 'package:hotlinecafee/screen/short_screen.dart';

import '../common/chat_commons.dart';
import 'chat/chatScreen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with WidgetsBindingObserver {
  String? userId;
  StateController stateController = Get.put(StateController());
  setStatus(String status) async {
    await firebaseFirestore.collection('user').doc(userId).update(
      {"status": status},
    );
  }

  CurrentBalanceViewModel _currentBalanceViewModel =
      Get.put(CurrentBalanceViewModel());

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
      stateController.changeState('Online');
    } else {
      setStatus("Offline");
      stateController.changeState('Offline');

      // offline
    }
    super.didChangeAppLifecycleState(state);
  }

  List selectIcon = [
    'images/svg/Home.svg',
    'images/svg/Discovery.svg',
    'images/svg/Play.svg',
    'images/svg/Chat.svg',
    'images/svg/Profile.svg'
  ];
  var x;
  List unselected = [
    'images/svg/unselectHome.svg',
    'images/svg/unselectDiscovery.svg',
    'images/svg/unselectPlay.svg',
    'images/svg/unselectChat.svg',
    'images/svg/unselectProfile.svg'
  ];
  List pages = [
    MyHomeScreen(),
    ExploreScreen(),
    ShortsScreen(),
    ChatScreen(),
    MyProfile(),
  ];

  void initState() {
    userId = PreferenceManager.getUserId();
    setStatus('Online');
    WidgetsBinding.instance.addObserver(this);
    currentBalance();
    super.initState();
  }

  currentBalance() async {
    await _currentBalanceViewModel.currentBalanceViewModel(
      model: {'user_id': PreferenceManager.getUserId()},
    );
    if (_currentBalanceViewModel.currentBalanceApiResponse.status ==
        Status.COMPLETE) {
      log('CURRENT BALANCE :-  ${_currentBalanceViewModel.currentBalanceApiResponse.data['data']['balance']}');

      // await PreferenceManager.setCurrentBalance(
      //     '${currentBalanceResponseModel.data!.balance}');
    }
  }

  int select = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(
            left: 25.w,
            right: 25.w,
          ),
          height: 50.h,
          width: Get.width,
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                pages.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      select = index;
                    });
                  },
                  child: select == index
                      ? SizedBox(
                          height: 21.h,
                          width: 21.h,
                          child: SvgPicture.asset(
                            '${selectIcon[index]}',
                            color: Color(0xffE76944),
                          ),
                        )
                      : SizedBox(
                          height: 21.h,
                          width: 21.h,
                          child: SvgPicture.asset(
                            '${unselected[index]}',
                            color: Color(0xff81818A),
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
        body: pages[select],
      ),
    );
  }
}
