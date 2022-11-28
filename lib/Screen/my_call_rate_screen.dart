import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/ViewModel/call_rent_view_model.dart';
import 'package:hotlinecafee/common/snackbar.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class MyCallRateScreen extends StatefulWidget {
  const MyCallRateScreen({Key? key}) : super(key: key);

  @override
  State<MyCallRateScreen> createState() => _MyCallRateScreenState();
}

class _MyCallRateScreenState extends State<MyCallRateScreen> {
  int selector = 0;

  List priceValue = ['100', '120', '140', '160', '180'];
  List level = ['1', '4', '5', '6', '7'];
  String callRate = '100';
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  CallRentViewModel callRentViewModel = Get.put(CallRentViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          'My Call Rate',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h),
            Container(
              height: 76.h,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.sp),
                  border: Border.all(
                    color: Colors.grey,
                  )),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your call rate',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff81818A)),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      PreferenceManager.getRate() == null
                          ? '$callRate/min'
                          : '${PreferenceManager.getRate()}/min',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'This diamonds will be shown in Earnings ',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff81818A)),
            ),
            SizedBox(height: 40.h),
            Text(
              'Free',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: priceValue.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  log('SELECT CALLRATE :- ${callRate}');
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selector = index;
                        callRate = priceValue[index];
                      });
                    },
                    child: Column(
                      children: [
                        Divider(
                          color: Colors.grey,
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Image.asset(
                              'images/Vector 76.png',
                              height: 16.h,
                              width: 19.w,
                            ),
                            SizedBox(width: 10.33.w),
                            Text(
                              '${priceValue[index]}/min (Lv ${level[index]})',
                              style: TextStyle(
                                  color: selector == index
                                      ? Color(0xffE76944)
                                      : Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            selector == index
                                ? Container(
                                    height: 20.h,
                                    width: 20.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color(0xffE76944),
                                      borderRadius: BorderRadius.circular(5.sp),
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      size: 12.sp,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text('')
                          ],
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: Get.width,
              child: RoundedLoadingButton(
                width: Get.width,
                color: Color(0xffEE6D41),
                borderRadius: 100,
                child: Text(
                  'Update',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                controller: _btnController,
                onPressed: updateMethod,
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Future<void> updateMethod() async {
    try {
      _btnController.start();
      await callRentViewModel.callRentViewModel(model: {
        'user_id': PreferenceManager.getUserId(),
        'rate': '$callRate',
      });
      if (callRentViewModel.callRentApiResponse.status == Status.COMPLETE) {
        CommonSnackBar.commonSnackBar(message: 'Call Rate Updated');
        _btnController.reset();
      }
    } catch (e) {
      _btnController.reset();
    }
  }
}
