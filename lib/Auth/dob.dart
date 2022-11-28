import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/ViewModel/Auth_view_model.dart';
import 'package:hotlinecafee/auth/username.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:hotlinecafee/model/response_model/gender_selection_res_model.dart';

class DobScreen extends StatefulWidget {
  final gender;
  const DobScreen({Key? key, this.gender}) : super(key: key);

  @override
  State<DobScreen> createState() => _DobScreenState();
}

class _DobScreenState extends State<DobScreen> {
  String datePicker = '';
  DateTime? pickedDate;
  TextEditingController _date = TextEditingController();
  AuthViewModel _genderSectionViewModel = Get.find();

  final formKey = GlobalKey<FormState>();
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
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Date of Birth',
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
                'Enter your date of birth as per id',
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
                    RegExp regex = RegExp(
                        r'^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$');
                    if (!regex.hasMatch(val!)) {
                      return 'Enter Year-month-day format';
                    }
                  },
                  style: TextStyle(color: Color(0xff81818A)),
                  controller: _date,
                  onTap: () async {},
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff81818A)),
                        borderRadius: BorderRadius.circular(30)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff81818A)),
                        borderRadius: BorderRadius.circular(30)),
                    hintStyle: TextStyle(color: Color(0xff81818A)),
                    prefixIcon: IconButton(
                      splashRadius: 20,
                      onPressed: () async {
                        pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(3100),
                        );
                        log('DATETIME :- $pickedDate');
                        setState(() {
                          datePicker = pickedDate.toString().split(' ')[0];
                          _date.text = datePicker.toString();
                        });
                        log('DATETIME :- ${_date.text}');
                      },
                      icon: Icon(
                        Icons.date_range,
                        color: Color(0xff81818A),
                      ),
                    ),
                    hintText: 'YYYY-MM-DD',
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
                    await genderSelect(_date);
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
      ),
    );
  }

  /// GENDER SELECT API CALLING
  Future<void> genderSelect(TextEditingController _date) async {
    if (formKey.currentState!.validate()) {
      await _genderSectionViewModel.genderSectionViewModel(model: {
        'user_id': PreferenceManager.getUserId(),
        'gender': widget.gender,
        'dob': _date.text,
      });

      if (_genderSectionViewModel.genderSelectApiResponse.status ==
          Status.COMPLETE) {
        GenderSelectionResponseModel getData =
            _genderSectionViewModel.genderSelectApiResponse.data;
        log(await "getData_getData====>>>$getData");

        Get.to(() => UserNameScreen());
      }
    }
  }
}
