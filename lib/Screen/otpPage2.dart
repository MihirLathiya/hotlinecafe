import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/ViewModel/Auth_view_model.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:hotlinecafee/screen/login.dart';

import '../model/response_model/verify_forgot_otp_res_model.dart';
import 'changePassword.dart';

// import '../ViewModel/verify_forgot_otp_view_model.dart';

// class OtpScreen extends StatelessWidget {
//   final number;
//   const OtpScreen2({Key? key, this.number}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: OtpScreen2(
//         number: number,
//       ),
//     );
//   }
// }

class OtpScreen2 extends StatefulWidget {
  final number;
  const OtpScreen2({Key? key, this.number}) : super(key: key);

  @override
  State<OtpScreen2> createState() => _OtpScreen2State();
}

class _OtpScreen2State extends State<OtpScreen2> {
  // VerifyForgotOtpViewModel verifyForgotOtpViewModel = Get.find();

  // VerifyForgotOTPReqModel verifyForgotOTPReqModel = VerifyForgotOTPReqModel();

  AuthViewModel verifyForgotOtpViewModel = Get.find();

  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<AuthViewModel>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60.h,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                SizedBox(
                  height: 15.h,
                ),
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
                        "Need to verify OTP sent on your mobile\n number. We have sent a verification code to\n ${widget.number}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff81818A)))),
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
                          controller: otp1,
                          onSaved: (pin1) {},
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: TextStyle(color: Color(0xff81818A)),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff81818A)),
                                borderRadius: BorderRadius.circular(5)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff81818A)),
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
                          controller: otp2,
                          onSaved: (pin1) {},
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: TextStyle(color: Color(0xff81818A)),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff81818A)),
                                borderRadius: BorderRadius.circular(5)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff81818A)),
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
                          controller: otp3,
                          onSaved: (pin1) {},
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: TextStyle(color: Color(0xff81818A)),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff81818A)),
                                borderRadius: BorderRadius.circular(5)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff81818A)),
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
                          controller: otp4,
                          onSaved: (pin1) {},
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: TextStyle(color: Color(0xff81818A)),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff81818A)),
                                borderRadius: BorderRadius.circular(5)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff81818A)),
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
                            borderRadius: BorderRadius.circular(25)),
                        primary: Color(0xffEE6D41)),
                    onPressed: () async {
                      String otps =
                          '${otp1.text}${otp2.text}${otp3.text}${otp4.text}';

                      await verifyForgotOTP(otps, context);
                    },
                    child: Text("Verify"),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "Resend code in "),
                        TextSpan(
                          text: "00:22",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  /// VERIFY FORGOT OTP API CALLING
  Future<void> verifyForgotOTP(String otps, BuildContext context) async {
    if (otps.isNotEmpty) {
      await verifyForgotOtpViewModel.verifyForgotOtpViewModel(model: {
        "otp": otps.trim(),
        "mobile_no": widget.number.toString().trim()
      });

      VerifyForgotOtpResponseModel responseModel =
          verifyForgotOtpViewModel.verifyForgotOtpApiResponse.data;

      if (verifyForgotOtpViewModel.verifyForgotOtpApiResponse.status ==
          Status.COMPLETE) {
        Get.to(
          () => ChangePasswordScreen(
            userUid: responseModel.data!.userId,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Wrong OTP"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Enter OTP"),
        ),
      );
    }
  }
}
