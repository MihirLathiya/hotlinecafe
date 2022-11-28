import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/ViewModel/Auth_view_model.dart';
import 'package:hotlinecafee/auth/gender.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:hotlinecafee/screen/bottom_bar.dart';
import 'package:hotlinecafee/screen/login.dart';

import '../common/snackbar.dart';
import '../model/response_model/verify_sign_up_otp_res_model.dart';

class Otp extends StatefulWidget {
  final bool? login;

  const Otp({Key? key, this.login}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  // OtpViewModel _otpViewModel = Get.find();
  // OtpRequestModelPost _otpRequestModelPost = OtpRequestModelPost();
  AuthViewModel signUpOtpViewModel = Get.find();

  TextEditingController _one = TextEditingController();
  TextEditingController _two = TextEditingController();
  TextEditingController _three = TextEditingController();
  TextEditingController _four = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60.h,
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 15.h),
            Center(
              child: Text(
                "OTP",
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Text(
                "Need to verify OTP sent on your mobile\n number. We have sent a verification code to\n  +91 ${PreferenceManager.getMobile()}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff81818A),
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 5.w),
                  child: SizedBox(
                    width: 45.w,
                    child: TextFormField(
                      controller: _one,
                      onSaved: (pin1) {},
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: TextStyle(color: Color(0xff81818A)),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff81818A)),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff81818A)),
                            borderRadius: BorderRadius.circular(5)),
                        fillColor: Colors.black,
                        filled: true,
                      ),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5.w),
                  child: SizedBox(
                    width: 45.w,
                    child: TextFormField(
                      controller: _two,
                      onSaved: (pin1) {},
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: TextStyle(color: Color(0xff81818A)),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff81818A)),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff81818A)),
                            borderRadius: BorderRadius.circular(5)),
                        fillColor: Colors.black,
                        filled: true,
                      ),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5.w),
                  child: SizedBox(
                    width: 45.w,
                    child: TextFormField(
                      onSaved: (pin1) {},
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: TextStyle(color: Color(0xff81818A)),
                      controller: _three,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff81818A)),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff81818A)),
                            borderRadius: BorderRadius.circular(5)),
                        fillColor: Colors.black,
                        filled: true,
                      ),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5.w),
                  child: SizedBox(
                    width: 45.w,
                    child: TextFormField(
                      onSaved: (pin1) {},
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: TextStyle(
                        color: Color(0xff81818A),
                      ),
                      controller: _four,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff81818A)),
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff81818A)),
                            borderRadius: BorderRadius.circular(5)),
                        fillColor: Colors.black,
                        filled: true,
                      ),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              height: 60.h,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  primary: Color(0xffEE6D41),
                ),
                onPressed: () async {
                  await verifyOtp();
                },
                child: Text("Verify"),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Center(
              child: InkWell(
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(text: "Resend code in "),
                  TextSpan(
                      text: "00:22",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ], style: TextStyle(color: Colors.white))),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// VERIFY OTP API CALLING
  Future<void> verifyOtp() async {
    print('##########${PreferenceManager.getDeviceId()}');
    // _otpRequestModelPost.mobileNo = '+91${PreferenceManager.getMobile()}';
    // _otpRequestModelPost.otp = _one.text + _two.text + _three.text + _four.text;

    await signUpOtpViewModel.signUpOtpViewModel(model: {
      "mobile_no": '+91${PreferenceManager.getMobile()}',
      "otp": _one.text + _two.text + _three.text + _four.text,
      "device_id": PreferenceManager.getDeviceId(),
    });

    if (signUpOtpViewModel.signOtpApiResponse.status == Status.COMPLETE) {
      VerifySignUpOtpResponseModel getData =
          signUpOtpViewModel.signOtpApiResponse.data;

      if (getData.message == 'OTP Match Successfully.') {
        await PreferenceManager.setUserId(getData.data!.userId!);

        print("_otpViewModel_otpViewModel$getData}");

        CommonSnackBar.commonSnackBar(message: "Verified Successful");

        widget.login!
            ? Get.to(() => BottomBar())
            : Get.to(() => GenderSelect());
      } else {
        CommonSnackBar.commonSnackBar(message: "${getData.message}");
      }
    }
  }
}
