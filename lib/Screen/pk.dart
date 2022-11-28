import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyVSScreen extends StatefulWidget {
  const MyVSScreen({Key? key}) : super(key: key);

  @override
  State<MyVSScreen> createState() => _MyVSScreenState();
}

class _MyVSScreenState extends State<MyVSScreen> {
  String TimerCount = "00:01:32";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 50.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  child: Image.asset(
                    "images/NewGirl2.png",
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Image.asset(
                    "images/NewGirl"
                    ".png",
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text(
                    TimerCount,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  decoration: ShapeDecoration(
                      color: Colors.blueGrey,
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
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.48,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/SqureGirl.png"),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 5.w,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.48,
                decoration: BoxDecoration(
                    color: Colors.white54,
                    image: DecorationImage(
                        image: AssetImage("images/SqureGirl.png"),
                        fit: BoxFit.cover)),
              ),
            ],
          ),
          Baseline(
              baseline: -100,
              baselineType: TextBaseline.alphabetic,
              child: Image.asset("images/VsImage.png")),
          Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Opacity(
                      opacity: 0.3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Image.asset("images/SmallFace.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Jerome Bell",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Has join the room.",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Image.asset("images/SmallFace.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Jerome Bell",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Has join the room.",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.75,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Image.asset("images/SmallFace.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Jerome Bell",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Has join the room.",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.90,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Image.asset("images/SmallFace.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Jerome Bell",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Has join the room.",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Image.asset("images/SmallFace.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Jerome Bell",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Has join the room.",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Image.asset("images/SmallFace.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Jerome Bell",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Has join the room.",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.chat_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          bottomSheet(context);
                        },
                        child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blue,
                            child: Image.asset(
                              "images/Gift.png",
                              fit: BoxFit.fill,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return SheetContainer();
                              },
                            );
                          },
                          icon: Icon(
                            Icons.list,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

bottomSheet(BuildContext context) {
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

class SheetContainer extends StatefulWidget {
  const SheetContainer({Key? key}) : super(key: key);

  @override
  State<SheetContainer> createState() => _SheetContainerState();
}

class _SheetContainerState extends State<SheetContainer> {
  List data = ['Popular', 'Lucky', 'Fusion', 'Vip', 'Luxury'];
  int selector = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600.h,
      decoration: BoxDecoration(
        color: Color(0xff1A1A27),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.sp), topLeft: Radius.circular(20.sp)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Container(
              height: 4.h,
              width: 36.w,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100.h),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Container(
                  height: 50.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    // color: Color(0xff4B53FF)
                    //     .withOpacity(0.8),
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(40.sp),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/Girl2.png'),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'keyless',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 16.w),
                Container(
                  height: 50.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    // color: Color(0xff4B53FF)
                    //     .withOpacity(0.8),
                    color: Color(0xff121212),
                    borderRadius: BorderRadius.circular(40.sp),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/Girl2.png'),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'keyless',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                  data.length,
                  (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selector = index;
                          });
                        },
                        child: Text(
                          '${data[index]}',
                          style: TextStyle(
                            color: selector == index
                                ? Colors.white
                                : Color(0xff4F4F5B),
                          ),
                        ),
                      )),
            ),
            SizedBox(height: 24.h),
            Container(
              height: 320.h,
              child: GridView.builder(
                itemCount: 12,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Image.asset(
                        'images/twemoji_wrapped-gift.png',
                        height: 48.h,
                        width: 48.w,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Lucky Donut',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Image(
                            image: AssetImage(
                              'images/Coin.png',
                            ),
                            height: 15.h,
                            width: 15.w,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            '5,999',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10.sp,
                              color: Color(0xff81818A),
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              children: [
                Container(
                  height: 50.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.sp),
                      border: Border.all(
                        color: Colors.grey,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/Coin.png'),
                      ),
                      SizedBox(
                        width: 5.25.w,
                      ),
                      Text(
                        '20,000',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  height: 50.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.sp),
                      border: Border.all(
                        color: Colors.grey,
                      )),
                  child: Row(
                    children: [
                      SizedBox(width: 12.w),
                      GestureDetector(
                        onTap: () {
                          print('remove');
                        },
                        child: Container(
                          height: 25.h,
                          width: 25.w,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.remove,
                            size: 20.sp,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.sp),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '20',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          print('Add');
                        },
                        child: Container(
                          height: 25.h,
                          width: 25.w,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.add,
                            size: 20.sp,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.sp),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 55.h,
                        width: 80.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30.sp),
                            border: Border.all()),
                        child: Text(
                          'Send',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
