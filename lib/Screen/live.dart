import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'call_user_screen.dart';

// class Live1 extends StatelessWidget {
//   const Live({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(debugShowCheckedModeBanner: false, home: Live());
//   }
// }

class Live extends StatefulWidget {
  const Live({Key? key}) : super(key: key);

  @override
  State<Live> createState() => _LiveState();
}

class _LiveState extends State<Live> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Image.asset(
                "images/Rectangle 9.png",
                fit: BoxFit.cover,
              )),
          SafeArea(
              child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.black12,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                Column(
                  children: [
                    Image.asset('images/Girl2.png'),
                    Baseline(
                      baseline: 5,
                      baselineType: TextBaseline.alphabetic,
                      child: Container(
                          decoration: ShapeDecoration(
                              color: Color(0xffEB5757),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(
                                      width: 1, color: Colors.transparent))),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              'Live',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11),
                            ),
                          )),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'kaylynnwest...',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '12k Followers',
                      style: TextStyle(
                        color: Colors.white54,
                      ),
                    )
                  ],
                ),
                Container(
                  width: 70,
                  child: ButtonTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    buttonColor: Color(0xffE76944),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Influencer()));
                      },
                      // textColor: Colors.white,
                      child: Text(
                        "Follow",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                    decoration: ShapeDecoration(
                        color: Colors.black12,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            side: const BorderSide(
                                width: 1, color: Colors.transparent))),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                          ),
                          Text(
                            '3.5k',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )
                        ],
                      ),
                    )),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.black12,
                  child: Icon(
                    Icons.cancel_outlined,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ])),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: ShapeDecoration(
                        color: Colors.white24,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            side: const BorderSide(
                                width: 1, color: Colors.transparent))),
                    child: TextField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          floatingLabelStyle: TextStyle(color: Colors.white54),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          hintText: "Type",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  Container(
                      child: IconButton(
                          iconSize: 34,
                          onPressed: () {},
                          icon: Image.asset('images/Gift.png'))),
                  IconButton(
                    onPressed: () {
                      Get.to(() => CallUserScreen());
                    },
                    icon: SvgPicture.asset(
                      'images/call.svg',
                      height: 44.h,
                      width: 44.h,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: ShapeDecoration(
                        color: Colors.black38,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            side: const BorderSide(
                                width: 1, color: Colors.transparent))),
                    child: IconButton(
                        onPressed: () {
                          bottomsheet(context);
                        },
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

bottomsheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.black38,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Image.asset('images/3408506 1.png'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Game 1',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Image.asset('images/7469372 1.png'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Game 2',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset('images/2314909 1.png'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Lucky Draw',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Image.asset('images/3473515 1.png'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Top Up',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        );
      });
}
