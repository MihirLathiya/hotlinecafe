import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({Key? key}) : super(key: key);

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        bottom: PreferredSize(
            child: Divider(color: Color(0xff242424), thickness: 2),
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
          'Delete Account',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.sp),
        child: Column(
          children: [
            SizedBox(
              height: 14.sp,
            ),
            Center(
              child: Image.asset(
                'images/Alert Icon.png',
                width: 90.h,
                height: 90.h,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'Confirmation',
              style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20.sp,
            ),
            SizedBox(
              height: 170.sp,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.sp),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 5.sp, backgroundColor: Colors.white),
                      horizontalTitleGap: -12.sp,
                      title: Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Row(
              children: [
                Checkbox(
                  side: BorderSide(color: Color(0xff81818A), width: 2),
                  value: isCheck,
                  checkColor: Colors.white,
                  activeColor: Color(0xffE76944),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.sp)),
                  onChanged: (value) {
                    setState(() {
                      isCheck = value!;
                    });
                  },
                ),
                Flexible(
                  child: Text(
                    '''I agree with Terms and Conditions &
Privacy Policy. I agree to delete my account and personal data.''',
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff81818A)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 32.sp,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(32.sp),
              onTap: () {
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                height: 48.sp,
                width: Get.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff81818A)),
                    borderRadius: BorderRadius.circular(32.sp)),
                child: Text(
                  "Delete My Account",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffEB5757)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
