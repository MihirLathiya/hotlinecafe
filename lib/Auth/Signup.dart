import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Common/snackbar.dart';
import 'package:hotlinecafee/Model/Apis/api_response.dart';
import 'package:hotlinecafee/Model/response_model/sign_up_res_model.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/Screen/login.dart';
import 'package:hotlinecafee/Screen/otp.dart';
import 'package:hotlinecafee/ViewModel/auth_view_model.dart';
import 'package:hotlinecafee/model/request_model/sign_up_request_model.dart';
import 'package:hotlinecafee/screen/bottom_bar.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Signup(),
    );
  }
}

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  AuthViewModel _signUpViewModel = Get.find();
  SignUpRequestModel _signUpRequestModel = SignUpRequestModel();

  TextEditingController _name = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _password = TextEditingController();

  final formKey = GlobalKey<FormState>();
  RegExp regex = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");

  var value1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<AuthViewModel>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 90.h,
                    ),
                    Center(
                        child: Text(
                      "Let’s get started!",
                      style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffFFFFFF)),
                    )),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                        child: Text("Welcome to Hotline Cafe.",
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
                      child: Text("Name",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff81818A))),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 60.h,
                      child: TextFormField(
                        validator: (value) {
                          RegExp regex = RegExp(r'^[a-zA-Z]+$');
                          if (!regex.hasMatch(value!)) {
                            return 'Enter valid Name';
                          }
                        },
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Color(0xff81818A)),
                        controller: _name,
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
                          label: Text(
                            "Enter name",
                            style: TextStyle(
                              color: Color(0xff81818A),
                            ),
                            // border: OutlineInputBorder(
                            //     borderSide: BorderSide(color: Color(0xff81818A), width: 1.0),
                            //     borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("Username",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff81818A))),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 60.h,
                      child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Enter UserName';
                          }
                        },
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Color(0xff81818A)),
                        controller: _userName,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff81818A)),
                              borderRadius: BorderRadius.circular(30)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff81818A)),
                              borderRadius: BorderRadius.circular(30)),
                          hintStyle: TextStyle(color: Color(0xff81818A)),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xff81818A),
                          ),
                          label: Text(
                            "Enter Username",
                            style: TextStyle(
                              color: Color(0xff81818A),
                            ),
                            // border: OutlineInputBorder(
                            //     borderSide: BorderSide(color: Color(0xff81818A), width: 1.0),
                            //     borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Mobile Number",
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
                      height: 80.h,
                      child: TextFormField(
                        validator: (val) {
                          RegExp regex = RegExp(
                              r'^(?:(?:\+|0{0,2})91(\s*|[\-])?|[0]?)?([6789]\d{2}([ -]?)\d{3}([ -]?)\d{4})$');
                          if (!regex.hasMatch(val!)) {
                            return 'Enter valid Number';
                          }
                        },
                        style: TextStyle(color: Color(0xff81818A)),
                        controller: _mobile,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
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
                          // border: OutlineInputBorder(
                          //     borderSide: BorderSide(color: Color(0xff81818A), width: 1.0),
                          //     borderRadius: BorderRadius.circular(30)),
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
                      height: 60.h,
                      child: TextFormField(
                        validator: (value) {
                          // RegExp regex = RegExp(
                          //     r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
                          if (!regex.hasMatch(value!)) {
                            return "Enter valid Password";
                          }
                        },
                        obscureText: true,
                        style: TextStyle(color: Color(0xff81818A)),
                        controller: _password,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff81818A)),
                              borderRadius: BorderRadius.circular(30)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff81818A)),
                              borderRadius: BorderRadius.circular(30)),
                          hintStyle: TextStyle(color: Color(0xff81818A)),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xff81818A),
                          ),
                          hintText: 'Enter Password',
                        ),
                        onChanged: (val) {
                          setState(() {});
                        },
                      ),
                    ),
                    if (!regex.hasMatch(_password.text))
                      Text(
                        'Password Must be 8 or more character and contain at least 1 number and 1 special character',
                        style:
                            TextStyle(fontSize: 10.h, color: Color(0xff81818A)),
                      ),
                    if (regex.hasMatch(_password.text))
                      Text(
                        '',
                        style:
                            TextStyle(fontSize: 10.h, color: Color(0xff81818A)),
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
                          String mobile = '+91${_mobile.text}';

                          await signUpMethod(mobile);
                        },
                        child: Text("Registration"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff9A9A9A)),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => LoginPage());
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
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
                      height: 50.h,
                    ),
                    Container(
                      height: 60.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              color: Color(0xff81818A),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            primary: Colors.transparent),
                        onPressed: () {
                          Get.offAll(() => BottomBar());
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
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            activeColor: Color(0xffE76944),
                            side: BorderSide(color: Colors.white),
                            checkColor: Colors.white,
                            value: value1,
                            onChanged: (value) {
                              setState(() {
                                value1 = value!;
                              });
                            }),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff81818A)),
                            children: [
                              TextSpan(
                                  text: "By signing up, user agrees to the \n"),
                              TextSpan(
                                text: "Terms & conditions ",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(text: "and"),
                              TextSpan(
                                text: " Privacy policy.",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50.h,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// SIGNUP API CALLING
  Future<void> signUpMethod(String mobile) async {
    if (formKey.currentState!.validate() && value1 == true) {
      _signUpRequestModel.name = _name.text;
      _signUpRequestModel.username = _userName.text;
      _signUpRequestModel.mobileNo = mobile.trim();
      _signUpRequestModel.password = _password.text;
      print('$mobile');

      await _signUpViewModel.signUpViewModel(
          model: _signUpRequestModel.toJson());

      SignUpResponseModel response = _signUpViewModel.signUpApiResponse.data;

      if (_signUpViewModel.signUpApiResponse.status == Status.COMPLETE) {
        print("SignUp_Response===>>$response");

        await PreferenceManager.setMobile(_mobile.text);
        await PreferenceManager.setUserName(_userName.text);
        await PreferenceManager.setName(_name.text);

        CommonSnackBar.commonSnackBar(message: "Registration Successful");

        Get.off(() => Otp(login: false));
      } else {
        CommonSnackBar.commonSnackBar(message: "UserName Already Used.");
      }
    } else if (value1 == false) {
      CommonSnackBar.commonSnackBar(message: "Accept Term & Condition");
    }
  }
}
