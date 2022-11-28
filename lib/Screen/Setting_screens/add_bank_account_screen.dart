import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddBankAccountScreen extends StatefulWidget {
  const AddBankAccountScreen({Key? key}) : super(key: key);

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  TextEditingController bankAccountName = TextEditingController();
  TextEditingController bankIfsc = TextEditingController();
  TextEditingController bankAccountNumber = TextEditingController();
  TextEditingController bankAccountHolder = TextEditingController();
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
          'Add Bank Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.sp,
            ),
            bankDetail(
              validator: (val) {},
              controller: bankAccountName,
              hintText: 'Enter Bank Name',
              title: "Bank Account Name",
            ),
            bankDetail(
              validator: (val) {},
              controller: bankAccountName,
              hintText: 'Enter IFSC Code',
              title: "IFSC Code",
            ),
            bankDetail(
              validator: (val) {},
              controller: bankAccountName,
              hintText: 'Enter Bank account number',
              title: "Bank account number",
            ),
            bankDetail(
              validator: (val) {},
              controller: bankAccountName,
              hintText: 'Enter Account holder name',
              title: "Account holder name",
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
                  'Add Account',
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

Widget bankDetail(
    {String? title,
    TextEditingController? controller,
    String? hintText,
    validator}) {
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
          ),
        ),
      ),
      SizedBox(
        height: 28.sp,
      )
    ],
  );
}
