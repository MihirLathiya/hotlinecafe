import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController password = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
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
          'Change Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            bankDetail1(
              validator: (val) {},
              hintText: 'Enter old password',
              controller: oldPassword,
              title: 'Old Password',
              suffixIcon: IconButton(
                splashRadius: 18,
                onPressed: () {},
                icon: Icon(
                  Icons.remove_red_eye,
                  color: Color(0xff81818a),
                ),
              ),
            ),
            Divider(
              color: Color(0xff242424),
            ),
            SizedBox(
              height: 16.h,
            ),
            bankDetail1(
              validator: (val) {},
              hintText: 'Enter New password',
              controller: oldPassword,
              title: 'New Password',
              suffixIcon: IconButton(
                splashRadius: 18,
                onPressed: () {},
                icon: Icon(
                  Icons.remove_red_eye,
                  color: Color(0xff81818a),
                ),
              ),
            ),
            bankDetail1(
              validator: (val) {},
              hintText: 'Enter Confirm password',
              controller: password,
              title: 'Confirm Password',
              suffixIcon: IconButton(
                splashRadius: 18,
                onPressed: () {},
                icon: Icon(
                  Icons.remove_red_eye,
                  color: Color(0xff81818a),
                ),
              ),
            ),
            SizedBox(
              height: 48.h,
              width: Get.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffE76944),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget bankDetail1(
    {String? title,
    TextEditingController? controller,
    String? hintText,
    validator,
    Widget? suffixIcon}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 20.sp),
        child: Text(
          title!,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xff81818A),
          ),
        ),
      ),
      SizedBox(
        height: 10.sp,
      ),
      Container(
        height: 80,
        child: TextFormField(
          validator: validator,
          keyboardType: TextInputType.number,
          maxLength: 10,
          controller: controller,
          style: TextStyle(color: Color(0xff81818A)),
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff242424)),
                  borderRadius: BorderRadius.circular(30)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff242424)),
                  borderRadius: BorderRadius.circular(30)),
              hintStyle: TextStyle(color: Color(0xff81818A)),
              hintText: hintText,
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xff242424),
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: suffixIcon,
              )),
        ),
      ),
      SizedBox(
        height: 14.sp,
      )
    ],
  );
}
