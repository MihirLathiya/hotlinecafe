import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'add_bank_account_screen.dart';

class MyPaymentMethodScreen extends StatefulWidget {
  const MyPaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<MyPaymentMethodScreen> createState() => _MyPaymentMethodScreenState();
}

class _MyPaymentMethodScreenState extends State<MyPaymentMethodScreen> {
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
          'My Payment Method',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.sp,
              ),
              Text(
                'My Card',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.sp),
                    child: Container(
                      height: 80.h,
                      width: Get.width,
                      padding: EdgeInsets.all(16.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.sp),
                        border: Border.all(
                          color: Color(0xff242424),
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'images/Photo Square.png',
                            height: 48.sp,
                            width: 48.sp,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 16.sp,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Doe',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  '••••  ••••  •••• 8563',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          SvgPicture.asset(
                            'images/svg/Delete.svg',
                            color: Color(0xff242424),
                            height: 24.h,
                            width: 24.h,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 32.sp,
              ),
              Text(
                'Bank Account',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.sp),
                    child: Container(
                      height: 80.h,
                      width: Get.width,
                      padding: EdgeInsets.all(16.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.sp),
                        border: Border.all(
                          color: Color(0xff242424),
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'images/Photo Square.png',
                            height: 48.sp,
                            width: 48.sp,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 16.sp,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ICICI Bank',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  '••••  ••••  •••• 8563',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          SvgPicture.asset(
                            'images/svg/Delete.svg',
                            color: Color(0xff242424),
                            height: 24.h,
                            width: 24.h,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 16.sp,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  Get.to(() => AddBankAccountScreen());
                },
                child: Container(
                  height: 60.h,
                  width: Get.width,
                  padding: EdgeInsets.all(16.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Color(0xff242424),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Add Bank Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
