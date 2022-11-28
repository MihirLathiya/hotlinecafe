import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BlockListScreen extends StatefulWidget {
  const BlockListScreen({Key? key}) : super(key: key);

  @override
  State<BlockListScreen> createState() => _BlockListScreenState();
}

class _BlockListScreenState extends State<BlockListScreen> {
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
          'Block List',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(10.sp),
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 26.sp,
                      backgroundImage: AssetImage("images/NewGirl.png")),
                  horizontalTitleGap: 13,
                  title: Text(
                    'Guy Hawkins',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    '@cassierandolph43',
                    style: TextStyle(
                        color: Color(0xff81818A),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 2, color: Color(0xff373743)),
                            borderRadius: BorderRadius.circular(8.sp))),
                    onPressed: () {},
                    child: Text(
                      'Unblock',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )),
    );
  }
}
