import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Screen/login.dart';
import 'package:hotlinecafee/ViewModel/Auth_view_model.dart';
import 'package:hotlinecafee/model/services/google_service.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  AuthViewModel socialLogInViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E1E1E),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Login.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () async {
                  log('fygbhu');
                  await signInWithGoogle();
                },
                child: Container(
                  height: 52.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    border: Border.all(color: Colors.white12),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/google.png',
                        height: 28.h,
                        width: 28.h,
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Text(
                        'Continue with Google',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () async {
                  log('fygbhu');
                },
                child: Container(
                  height: 52.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    border: Border.all(color: Colors.white12),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/Apple.png',
                        height: 28.h,
                        width: 28.h,
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Text(
                        'Continue with Apple',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 52.h,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      primary: Color(0xffEE6D41)),
                  onPressed: () async {
                    // await logInMethod();
                    Get.to(
                      () => LoginPage(),
                    );
                  },
                  child: Text("Phone"),
                ),
              ),
              SizedBox(
                height: 114.h,
              ),
              Container(
                child: FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'By signing up, you agree to the',
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            ' Terms & conditions ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'and',
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        'Privacy policy.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 34.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
