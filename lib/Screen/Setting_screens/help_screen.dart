import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
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
          'Help',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(children: [
              SizedBox(
                height: 10.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.sp),
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(color: Color(0xff242424), width: 2)),
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    childrenPadding: EdgeInsets.only(
                        left: 10.sp, right: 10.sp, bottom: 10.sp),
                    children: [
                      Text(
                        '''Lorem sum has been the industry's standard dummy text ever since the 1500s, when an unknown rinter ok a galley of type and scrambled it tomake a type specimen book.''',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp),
                      )
                    ],
                    title: Row(
                      children: [
                        Text(
                          'Que. ',
                          style: TextStyle(
                              color: Color(0xff81818A),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'How Order charges calculate?',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]),
          );
        },
      ),
    );
  }
}
