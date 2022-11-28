import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/ViewModel/Auth_view_model.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:hotlinecafee/model/response_model/send_forgot_otp_res_model.dart';

import 'otpPage2.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ForgotPassword(),
        );
      },
    );
  }
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();

  AuthViewModel _forgotPasswordViewModel = Get.find();

  TextEditingController mobileNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<AuthViewModel>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60.h,
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
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
                      "Forgot Password?",
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                      child: Text(
                          "Reset your password by receiving OTP on your\n registered mobile number. Please enter your\n mobile number below to get OTP.",
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
                    height: 60,
                    child: TextFormField(
                      validator: (value) {
                        RegExp regex = RegExp(
                            '^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}\$');
                        if (!regex.hasMatch(value!)) {
                          return 'Enter valid Number';
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: mobileNumber,
                      maxLength: 10,
                      style: TextStyle(color: Color(0xff81818A)),
                      decoration: InputDecoration(
                        counter: Offstage(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff81818A)),
                            borderRadius: BorderRadius.circular(30)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff81818A)),
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
                    height: 35.h,
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
                        var number = '+91${mobileNumber.text}'.trim();
                        await forgotPassword(number, context);
                      },
                      child: Text("Submit"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// FORGOT PASSWORD API CALLING
  Future<void> forgotPassword(String number, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      await _forgotPasswordViewModel
          .forgotPasswordViewModel(model: {"mobile_no": number});

      if (_forgotPasswordViewModel.forgotPassApiResponse.status ==
          Status.COMPLETE) {
        sendForgotOtp(number: number);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Mobile does not exist."),
          ),
        );
      }
    }
  }

  /// RESEND FORGOT OTP API CALLING
  Future<void> sendForgotOtp({String? number}) async {
    await _forgotPasswordViewModel
        .sendForgotOtpViewModel(model: {"mobile_no": number});
    SendForgotOtpResponseModel response1 =
        _forgotPasswordViewModel.sendForgotOtpApiResponse.data;
    print('respons>>>>>> ${response1}');
    if (response1.status == '200') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("OTP send Successfully"),
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => OtpScreen2(
            number: number,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Resend OTP Failed"),
        ),
      );
    }
  }
}
