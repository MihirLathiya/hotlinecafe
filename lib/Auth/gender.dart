import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/ViewModel/Auth_view_model.dart';
import 'package:hotlinecafee/auth/dob.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:hotlinecafee/model/response_model/gender_selection_res_model.dart';

class GenderSelect extends StatefulWidget {
  const GenderSelect({Key? key}) : super(key: key);

  @override
  State<GenderSelect> createState() => _GenderSelectState();
}

class _GenderSelectState extends State<GenderSelect> {
  List gender = [
    {'image': "images/boy.png", 'gender': 'Male'},
    {'image': "images/girl.png", 'gender': 'Female'},
  ];
  AuthViewModel _genderSectionViewModel = Get.find();

  int selectGender = 0;
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
              'Gender selection',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Column(
              children: [
                ...List.generate(
                  2,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: 28.h),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10000),
                      onTap: () {
                        setState(() {
                          selectGender = index;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        height: 80.h,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10000),
                          border: Border.all(
                            color: selectGender == index
                                ? Color(0xffE76944)
                                : Colors.white38,
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              gender[index]['image'],
                              height: 48.h,
                              width: 48.h,
                            ),
                            Text(
                              gender[index]['gender'],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20.h,
                              ),
                            ),
                            Spacer(),
                            if (selectGender == index)
                              Icon(
                                Icons.done,
                                color: Color(0xffE76944),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
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
                      await genderSelect(_genderSectionViewModel);
                    },
                    child: Text("Next"),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  'Gender can’t be change once submitted',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// GENDER SELECT API CALLING
  Future<void> genderSelect(AuthViewModel _genderSectionViewModel) async {
    await _genderSectionViewModel.genderSectionViewModel(model: {
      'user_id': PreferenceManager.getUserId(),
      'gender': selectGender == 0 ? 'Male' : 'Female',
      'dob': '12-12-1212',
    });

    if (_genderSectionViewModel.genderSelectApiResponse.status ==
        Status.COMPLETE) {
      GenderSelectionResponseModel getData =
          _genderSectionViewModel.genderSelectApiResponse.data;
      log(await "getData_getData====>>>$getData");

      Get.to(
        () => DobScreen(
          gender: selectGender == 0 ? 'Male' : 'Female',
        ),
      );
    }
  }
}
