import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/ViewModel/Auth_view_model.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:hotlinecafee/screen/login.dart';

class ChangePasswordScreen extends StatefulWidget {
  final userUid;
  const ChangePasswordScreen({Key? key, this.userUid}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  AuthViewModel resetPasswordViewModel = Get.find();
  // ResetPasswordReqModel resetPasswordReqModel = ResetPasswordReqModel();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print('tfgyhu${widget.userUid}');
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60.h,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
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
                  "Reset Password",
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "New Password",
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
                height: 60.h,
                child: TextFormField(
                  validator: (val) {
                    RegExp regex = RegExp(
                        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
                    if (val!.isEmpty) {
                      return 'Enter Password';
                    } else if (!regex.hasMatch(val)) {
                      return 'Password is Not Valid';
                    }
                    return null;
                  },
                  controller: password,
                  style: TextStyle(color: Color(0xff81818A)),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff81818A)),
                        borderRadius: BorderRadius.circular(30)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff81818A)),
                        borderRadius: BorderRadius.circular(30)),
                    hintStyle: TextStyle(color: Color(0xff81818A)),
                    prefixIcon: Icon(
                      Icons.person_pin_outlined,
                      color: Color(0xff81818A),
                    ),
                    hintText: "Enter New Password",
                  ),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Confirm Password",
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
                height: 60.h,
                child: TextFormField(
                  controller: confirmPassword,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter ConfirmPassword';
                    } else if (val != password.text.trim()) {
                      return 'Password doesn\'t Match';
                    }
                    return null;
                  },
                  style: TextStyle(color: Color(0xff81818A)),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff81818A)),
                        borderRadius: BorderRadius.circular(30)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff81818A)),
                        borderRadius: BorderRadius.circular(30)),
                    hintStyle: TextStyle(color: Color(0xff81818A)),
                    prefixIcon: Icon(
                      Icons.person_pin_outlined,
                      color: Color(0xff81818A),
                    ),
                    hintText: "Confirm Password",
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
                    resetPassword(context);
                  },
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// RESET PASSWORD API CALLING
  Future<void> resetPassword(BuildContext context) async {
    log('PREFRENCE ${widget.userUid.toString()}');
    if (formKey.currentState!.validate()) {
      await resetPasswordViewModel.resetPasswordViewModel(model: {
        "user_id": widget.userUid.toString(),
        "password": password.text.trim(),
        "c_password": confirmPassword.text.trim(),
      });

      if (resetPasswordViewModel.resetPassApiResponse.status ==
          Status.COMPLETE) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Password Change Successfully"),
          ),
        );
        log('DONE');
        Get.offAll(() => LoginPage());
      } else {
        log('FAIL');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong !"),
          ),
        );
      }
    }
  }
}
