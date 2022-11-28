import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/auth/log_in.dart';
import 'package:hotlinecafee/model/services/google_service.dart';
import 'package:hotlinecafee/screen/setting_screens/delete_account_screen.dart';
import 'package:hotlinecafee/screen/setting_screens/my_payment_method_screen.dart';
import 'package:hotlinecafee/screen/setting_screens/privcy_policy_screen.dart';
import 'package:hotlinecafee/screen/setting_screens/user_agreement_screen.dart';

import 'block_list_screen.dart';
import 'change_password_screen.dart';
import 'help_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        bottom: PreferredSize(
            child: Divider(color: Color(0xff242424), thickness: 1),
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
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 18.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 16.sp,
              ),
              setting_options(
                name: 'My Payment Methods',
                onTap: () {
                  Get.to(
                    () => MyPaymentMethodScreen(),
                  );
                },
                link: 'images/svg/bank.svg',
              ),
              SizedBox(
                height: 16.sp,
              ),
              setting_options(
                name: 'Change Password',
                onTap: () {
                  Get.to(() => ChangePasswordScreen());
                },
                link: 'images/svg/frame.svg',
              ),
              SizedBox(
                height: 16.sp,
              ),
              setting_options(
                name: 'App Language',
                onTap: () {},
                link: 'images/svg/language.svg',
              ),
              SizedBox(
                height: 16.sp,
              ),
              setting_options(
                name: 'Help',
                onTap: () {
                  Get.to(() => HelpScreen());
                },
                link: 'images/svg/message-question.svg',
              ),
              SizedBox(
                height: 16.sp,
              ),
              setting_options(
                name: 'Block List',
                onTap: () {
                  Get.to(() => BlockListScreen());
                },
                link: 'images/svg/Block.svg',
              ),
              SizedBox(
                height: 16.sp,
              ),
              setting_options(
                name: 'Privacy Policy',
                onTap: () {
                  Get.to(() => PrivacyPolicyScreen());
                },
                link: 'images/svg/shield-tick.svg',
              ),
              SizedBox(
                height: 16.sp,
              ),
              setting_options(
                name: 'User Agreement',
                onTap: () {
                  Get.to(() => UserArgumentScreen());
                },
                link: 'images/svg/document-text.svg',
              ),
              SizedBox(
                height: 16.sp,
              ),
              setting_options(
                name: 'About Us',
                onTap: () {},
                link: 'images/svg/3 User.svg',
              ),
              SizedBox(
                height: 16.sp,
              ),
              setting_options(
                name: 'Rate Us',
                onTap: () {},
                link: 'images/svg/Star.svg',
              ),
              SizedBox(
                height: 16.sp,
              ),
              setting_options(
                name: 'Like on Facebook',
                onTap: () {},
                link: 'images/svg/facebook.svg',
              ),
              SizedBox(
                height: 16.sp,
              ),
              setting_options(
                name: 'Delete My Account',
                onTap: () {
                  Get.to(() => DeleteAccountScreen());
                },
                link: 'images/svg/Delete.svg',
              ),
              SizedBox(
                height: 16.sp,
              ),
              setting_options(
                name: 'Log Out',
                onTap: () async {
                  Get.back();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        backgroundColor: Color(0xff1A1A27),
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 16.w),
                                height: 380.h,
                                padding: EdgeInsets.only(
                                    top: 30.h,
                                    left: 24.w,
                                    right: 24.w,
                                    bottom: 24.h),
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18.sp),
                                  color: Color(0xff1A1A27),
                                ),
                                child: Column(
                                  children: [
                                    // Image.asset(
                                    //   'images/Alert Icon.png',
                                    //   height: 56.h,
                                    //   width: 56.h,
                                    //   fit: BoxFit.cover,
                                    // ),
                                    Container(
                                      height: 66.h,
                                      width: 66.h,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/Alert Icon.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    Text(
                                      'Logout',
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    Text(
                                      'Are you sure want to logout your \naccount ?',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        height: 1.5,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff81818A),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    InkWell(
                                      borderRadius: BorderRadius.circular(100),
                                      onTap: () async {
                                        if (PreferenceManager.getType() ==
                                            'Google ') {
                                          log('GOOGLE LOG OUT');
                                          await PreferenceManager.getClear();

                                          await signOutGoogle();
                                          Get.offAll(() => LogInScreen());
                                        } else {
                                          log('NORMAL LOG OUT');

                                          await PreferenceManager.getClear();
                                          Get.offAll(() => LogInScreen());
                                        }
                                      },
                                      child: Container(
                                        height: 58.h,
                                        width: Get.width,
                                        padding: EdgeInsets.all(16.sp),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                            color: Color(0xff242424),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Logout',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    SizedBox(
                                      height: 58.h,
                                      width: Get.width,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xffE76944),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
                link: 'images/svg/logout.svg',
              ),
            ],
          ),
        ),
      ),
    );
  }

  setting_options({String? link, String? name, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            link!,
            height: 24.sp,
            width: 24.sp,
          ),
          SizedBox(width: 15.sp),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name!,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 18.sp),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(0xff4F4F5B),
                        size: 15.sp,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16.sp,
                ),
                Divider(
                  color: Color(0xff242424),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
