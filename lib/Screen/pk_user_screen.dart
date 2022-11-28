// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
//
// class PkUser extends StatefulWidget {
//   const PkUser({Key? key}) : super(key: key);
//
//   @override
//   State<PkUser> createState() => _PkUserState();
// }
//
// class _PkUserState extends State<PkUser> {
//   String TimerCount = "00:01:32";
//   List data = ['Popular', 'Lucky', 'Fusion', 'Vip', 'Luxury'];
//   int selector = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             height: Get.height / 2,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("images/Girl.jpg"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 50.h,
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Row(
//                       children: [
//                         Stack(
//                           clipBehavior: Clip.none,
//                           children: [
//                             CircleAvatar(
//                               radius: 16.r,
//                               backgroundColor: Colors.white,
//                               child: CircleAvatar(
//                                 radius: 15.r,
//                                 backgroundImage:
//                                     AssetImage("images/SqureGirl.png"),
//                               ),
//                             ),
//                             Positioned(
//                               left: 13.w,
//                               child: CircleAvatar(
//                                 radius: 16.r,
//                                 backgroundColor: Colors.white,
//                                 child: CircleAvatar(
//                                   radius: 15.r,
//                                   backgroundImage:
//                                       AssetImage("images/Girl2.png"),
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               bottom: -10.h,
//                               left: 3.w,
//                               child: Container(
//                                 height: 18.h,
//                                 width: 33.w,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20.r),
//                                   color: Color(0xffEB5757),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     "Live",
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 12.sp),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           width: 25.w,
//                         ),
//                         Container(
//                           height: 32.h,
//                           width: 49.w,
//                           decoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.3),
//                             borderRadius: BorderRadius.circular(20.r),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.visibility,
//                                 color: Colors.white,
//                                 size: 15.sp,
//                               ),
//                               SizedBox(
//                                 width: 2.w,
//                               ),
//                               Text(
//                                 "3.5k",
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 12.sp),
//                               )
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: 30.w,
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(top: 10.h),
//                       child: Text(
//                         "00:01:32",
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Container(
//                         height: 32.h,
//                         width: 49.w,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20.r),
//                         ),
//                         child: Center(
//                           child: Text("End"),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             height: Get.height / 2,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("images/SqureGirl.png"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 12.w),
//               child: Stack(
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Container(
//                           height: 40.h,
//                           width: 40.w,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(color: Colors.grey),
//                           ),
//                           child: Center(
//                             child: Icon(
//                               Icons.clear,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         child: Column(
//                           children: [
//                             Text(
//                               "Calling",
//                               style: TextStyle(
//                                   fontSize: 22.sp, color: Colors.white),
//                             ),
//                             SizedBox(
//                               height: 10.h,
//                             ),
//                             CircleAvatar(
//                               radius: 26.r,
//                               child: CircleAvatar(
//                                 radius: 24.r,
//                                 backgroundImage: AssetImage("images/Girl2.png"),
//                               ),
//                               backgroundColor: Colors.white,
//                             ),
//                             SizedBox(
//                               height: 8.h,
//                             ),
//                             Text(
//                               "Annetaa black",
//                               style: TextStyle(
//                                   fontSize: 22.sp, color: Colors.white),
//                             ),
//                             SizedBox(
//                               height: 5.h,
//                             ),
//                             Text(
//                               "@fwsefsf",
//                               style: TextStyle(
//                                   fontSize: 16.sp, color: Colors.grey),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Padding(
//                           padding: const EdgeInsets.only(bottom: 20.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Container(
//                                 height: 48,
//                                 width: MediaQuery.of(context).size.width * 0.6,
//                                 decoration: ShapeDecoration(
//                                     color: Colors.white24,
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(40.0),
//                                         side: const BorderSide(
//                                             width: 1,
//                                             color: Colors.transparent))),
//                                 child: TextField(
//                                     keyboardType: TextInputType.text,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                     ),
//                                     decoration: InputDecoration(
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         borderRadius: BorderRadius.circular(40),
//                                       ),
//                                       floatingLabelStyle:
//                                           TextStyle(color: Colors.white54),
//                                       border: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                           color: Colors.grey,
//                                           width: 1,
//                                         ),
//                                         borderRadius: BorderRadius.circular(40),
//                                       ),
//                                       hintText: "Type",
//                                       hintStyle: TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500),
//                                     )),
//                               ),
//                               Container(
//                                 height: 40,
//                                 width: 40,
//                                 decoration: ShapeDecoration(
//                                     color: Colors.black38,
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(40.0),
//                                         side: const BorderSide(
//                                             width: 1,
//                                             color: Colors.transparent))),
//                                 child: IconButton(
//                                     onPressed: () {},
//                                     icon: Icon(
//                                       Icons.menu,
//                                       color: Colors.white,
//                                     )),
//                               ),
//                               GestureDetector(
//                                 onTap: () {},
//                                 child: SvgPicture.asset(
//                                   'images/camera.svg',
//                                   height: 40.h,
//                                   width: 40.w,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Opacity(
//                         opacity: 0.7,
//                         child: Padding(
//                           padding: const EdgeInsets.all(6.0),
//                           child: Row(
//                             children: [
//                               CircleAvatar(
//                                 radius: 14.r,
//                                 child: Image.asset(
//                                   "images/Girl2.png",
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(6.0.sp),
//                                 child: Column(
//                                   children: [
//                                     Text(
//                                       "Jerome Bell",
//                                       style: TextStyle(
//                                           color: Colors.white, fontSize: 12.sp),
//                                     ),
//                                     Text(
//                                       "Has join the room.",
//                                       style: TextStyle(
//                                           color: Colors.white, fontSize: 12.sp),
//                                     )
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       Opacity(
//                         opacity: 0.9,
//                         child: Padding(
//                           padding: const EdgeInsets.all(6.0),
//                           child: Row(
//                             children: [
//                               CircleAvatar(
//                                 radius: 14.r,
//                                 child: Image.asset("images/Girl2.png"),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(6.0),
//                                 child: Column(
//                                   children: [
//                                     Text(
//                                       "Jerome Bell",
//                                       style: TextStyle(
//                                           color: Colors.white, fontSize: 12.sp),
//                                     ),
//                                     Text(
//                                       "Has join the room.",
//                                       style: TextStyle(
//                                           color: Colors.white, fontSize: 12.sp),
//                                     )
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 75.h,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
