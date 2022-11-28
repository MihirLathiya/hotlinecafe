import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/ViewModel/Auth_view_model.dart';
import 'package:hotlinecafee/auth/Signup.dart';
import 'package:hotlinecafee/common/chat_commons.dart';
import 'package:hotlinecafee/common/snackbar.dart';
import 'package:hotlinecafee/main.dart';
import 'package:hotlinecafee/model/response_model/login_res_model.dart';
import 'package:hotlinecafee/screen/bottom_bar.dart';
import 'package:hotlinecafee/screen/forgotPassword.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../Preference/preference.dart';
import '../model/apis/api_response.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _mobile = TextEditingController();
  TextEditingController _password = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey();

  AuthViewModel _logInViewModel = Get.find();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 90.h,
                ),
                Center(
                  child: Text(
                    "Hello Again!",
                    style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffFFFFFF)),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                    child: Text("Welcome back you’ve been\n missed!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff81818A)))),
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text("Mobile number",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff81818A))),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  height: 80,
                  child: TextFormField(
                    validator: (val) {
                      RegExp regex = RegExp(
                          r'^(?:(?:\+|0{0,2})91(\s*|[\-])?|[0]?)?([6789]\d{2}([ -]?)\d{3}([ -]?)\d{4})$');
                      if (!regex.hasMatch(val!)) {
                        return 'Enter valid Number';
                      }
                    },
                    // keyboardType: TextInputType.number,number
                    maxLength: 10,
                    controller: _mobile,
                    style: TextStyle(color: Color(0xff81818A)),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff81818A),
                          ),
                          borderRadius: BorderRadius.circular(30)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff81818A),
                          ),
                          borderRadius: BorderRadius.circular(30)),
                      hintStyle: TextStyle(color: Color(0xff81818A)),
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.call,
                              color: Color(0xff81818A),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "+91",
                              style: TextStyle(
                                color: Color(0xff81818a),
                              ),
                            )
                          ],
                        ),
                      ),
                      hintText: 'xxx-xxx-xx-xx',
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff81818A),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  height: 60,
                  child: TextFormField(
                    obscureText: true,
                    controller: _password,
                    style: TextStyle(
                      color: Color(0xff81818A),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is Required';
                      }
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff81818A),
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff81818A),
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xff81818A),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xff81818A),
                      ),
                      hintText: 'Enter Password',
                      // border: OutlineInputBorder(
                      //     borderSide: BorderSide(color: Color(0xff81818A), width: 1.0),
                      //     borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text("Forgot password?",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      onPressed: () {
                        Get.to(() => ForgotPasswordPage());
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  width: Get.width,
                  child: RoundedLoadingButton(
                    width: Get.width,
                    color: Color(0xffEE6D41),
                    borderRadius: 100,
                    child: Text(
                      'Log in',
                      style: TextStyle(color: Colors.white),
                    ),
                    controller: _btnController,
                    onPressed: logInMethod,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account ? ",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff9A9A9A)),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => SignupPage());
                      },
                      child: Text(
                        "Register ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                Center(
                  child: Text(
                    "Or",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xff81818A),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("images/Group 310.png"),
                      SvgPicture.asset("images/Group 293.svg"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Container(
                  height: 60.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Color(0xff81818A)),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      Get.offAll(
                        () => BottomBar(),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Explore as Guest",
                            style: TextStyle(color: Color(0xff81818A)),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff81818A),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// LOG IN API CALLING
  Future<void> logInMethod() async {
    if (_key.currentState!.validate()) {
      _btnController.start();
      await getFcmToken();

      await _logInViewModel.loginViewModel(model: {
        "mobile_no": "+91" + _mobile.text.trim(),
        "password": _password.text.trim(),
        "device_id": PreferenceManager.getDeviceId(),
      });

      if (_logInViewModel.logInApiResponse.status == Status.COMPLETE) {
        LoginResponseModel response = _logInViewModel.logInApiResponse.data;

        if (response.status == "200") {
          PreferenceManager.setMobile(_mobile.text);
          PreferenceManager.setUserName(response.data!.username!);
          PreferenceManager.setUserId("${response.data!.userId}");
          PreferenceManager.setType('${response.data!.socialType}');
          PreferenceManager.setRate('${response.data!.callRate}');
          PreferenceManager.setUserImage('${response.data!.profilePic}');
          PreferenceManager.setLatitude('${response.data!.lattitude}');
          PreferenceManager.setLongitude('${response.data!.longitude}');
          PreferenceManager.setLogin(true);
          log('GET TYPE :-${PreferenceManager.getUserId()}');
          log('GET TYPE :-${PreferenceManager.getUserImage()}');
          firebaseFirestore
              .collection('user')
              .doc(PreferenceManager.getUserId())
              .set({
            'userEmail': "${response.data!.email}",
            'userImage': "${response.data!.profilePic}",
            "userUid": "${response.data!.userId}",
            'username': '${response.data!.username!}',
            'status': "Online",
            'fcm': PreferenceManager.getDeviceId(),
            'randomMatch': false,
            'id': '',
            'token': '',
          });
        }
        CommonSnackBar.commonSnackBar(message: 'Login Successfully.');
        _btnController.reset();

        Get.offAll(
          () => BottomBar(),
        );
      }
    } else {
      CommonSnackBar.commonSnackBar(message: 'Wrong Number & Password');
      _btnController.reset();
    }
  }
}
