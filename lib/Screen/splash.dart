import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/screen/bottom_bar.dart';

import 'onboradScreen.dart';

class Splash1 extends StatefulWidget {
  final title;
  const Splash1({Key? key, this.title}) : super(key: key);

  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  void initState() {
    var login = PreferenceManager.getLogin();
    log('LOGIN STATUS :- ${login}');
    super.initState();
    Timer(
      Duration(seconds: 2),
      () => Get.offAll(
        () => login == true || login != null ? BottomBar() : OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('USERID :- ${PreferenceManager.getUserId()}');

    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/AppIcon (2).png',
              height: 209.h,
              width: 209.h,
            ),
          ],
        ),
      ),
    );
  }
}
