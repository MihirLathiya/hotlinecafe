import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/ViewModel/Auth_view_model.dart';
import 'package:hotlinecafee/common/chat_commons.dart';
import 'package:hotlinecafee/common/snackbar.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:hotlinecafee/model/response_model/username_res_model.dart';
import 'package:hotlinecafee/screen/bottom_bar.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({Key? key}) : super(key: key);

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  TextEditingController userName = TextEditingController();
  AuthViewModel usernameViewModel = Get.find();

  @override
  initState() {
    print('USERNAME${PreferenceManager.getUserName()}');
    userName.text = PreferenceManager.getUserName();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E1E1E),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff1e1e1e),
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(32.w, 29.h, 32.w, 34.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select Username',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              'Enter username to continue.',
              style: TextStyle(
                color: Color(0xff81818A),
                fontSize: 16.sp,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Container(
              height: 60,
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Enter UserName';
                  }
                },
                style: TextStyle(color: Color(0xff81818A)),
                controller: userName,
                onTap: () async {},
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff81818A)),
                      borderRadius: BorderRadius.circular(30)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff81818A)),
                      borderRadius: BorderRadius.circular(30)),
                  hintStyle: TextStyle(color: Color(0xff81818A)),
                  hintText: 'Enter username',
                ),
              ),
            ),
            Spacer(),
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
                  // Get.to(() => Dob());
                  setUserName();
                },
                child: Text("Next"),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Gender can’t be change once submitted',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setUserName() async {
    await usernameViewModel.userNameViewModel(
      model: {
        "user_id": PreferenceManager.getUserId(),
        "username": userName.text.trim(),
      },
    );
    if (usernameViewModel.userNameApiResponse.status == Status.COMPLETE) {
      UserNameResponseModel userNameResponseModel =
          usernameViewModel.userNameApiResponse.data;
      CommonSnackBar.commonSnackBar(message: userNameResponseModel.message);
      log('USERNAME DATA :- ${userNameResponseModel.message}');
      await PreferenceManager.setType(
          '${userNameResponseModel.data!.socialType}');
      firebaseFirestore
          .collection('user')
          .doc(PreferenceManager.getUserId())
          .set(
        {
          'userEmail': "${userNameResponseModel.data!.email}",
          'userImage': "${userNameResponseModel.data!.profilePic}",
          "userUid": "${userNameResponseModel.data!.userId}",
          'username': '${userNameResponseModel.data!.username!}',
          'status': "Online",
          'fcm': PreferenceManager.getDeviceId(),
          'randomMatch': false,
          'id': '',
          'token': '',
        },
      );

      await PreferenceManager.setLogin(true);

      Get.offAll(() => BottomBar());
    }
  }
}
