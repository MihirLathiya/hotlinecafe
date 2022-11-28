// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
//
// class CallRecieverPhoto extends StatefulWidget {
//   const CallRecieverPhoto({Key? key}) : super(key: key);
//
//   @override
//   State<CallRecieverPhoto> createState() => _CallRecieverPhotoState();
// }
//
// class _CallRecieverPhotoState extends State<CallRecieverPhoto> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage("assets/images/Rectangle 9.png"),
//               fit: BoxFit.cover),
//         ),
//         child: Padding(
//           padding:
//               EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w, bottom: 30.h),
//           child: Stack(
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(6.0),
//                         child: Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 14.r,
//                               backgroundImage:
//                                   AssetImage("assets/images/Rectangle 9.png"),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(6.0.sp),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Jerome Bell",
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 12.sp),
//                                   ),
//                                   Text(
//                                     "12k Followers",
//                                     style: TextStyle(
//                                         color: Colors.grey, fontSize: 12.sp),
//                                   )
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       Text(
//                         "00:01:32",
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.w600),
//                       ),
//                       Container(
//                         height: 32.h,
//                         width: 77.w,
//                         decoration: BoxDecoration(
//                           color: Colors.black.withOpacity(0.3),
//                           borderRadius: BorderRadius.circular(20.r),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.favorite,
//                               color: Colors.blue,
//                               size: 15.sp,
//                             ),
//                             SizedBox(
//                               width: 5.w,
//                             ),
//                             Text(
//                               "120/min",
//                               style: TextStyle(
//                                   color: Colors.white, fontSize: 12.sp),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CircleAvatar(
//                         radius: 22.r,
//                         child: Center(
//                           child: SvgPicture.asset("assets/images/chat.svg"),
//                         ),
//                         backgroundColor: Colors.black.withOpacity(0.3),
//                       ),
//                       Row(
//                         children: [
//                           SizedBox(
//                             width: 16.w,
//                           ),
//                           CircleAvatar(
//                             radius: 22.r,
//                             child: Center(
//                               child: SvgPicture.asset("assets/images/Gift.svg"),
//                             ),
//                             backgroundColor: Color(0xff4B53FF),
//                           ),
//                           SizedBox(
//                             width: 16.w,
//                           ),
//                           CircleAvatar(
//                             radius: 22.r,
//                             child: Center(
//                               child: SvgPicture.asset("assets/images/menu.svg"),
//                             ),
//                             backgroundColor: Colors.black.withOpacity(0.3),
//                           ),
//                           SizedBox(
//                             width: 16.w,
//                           ),
//                           CircleAvatar(
//                             radius: 22.r,
//                             child: Center(
//                               child: SvgPicture.asset(
//                                   "assets/images/fi_close x.svg"),
//                             ),
//                             backgroundColor: Colors.black.withOpacity(0.3),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//               Positioned(
//                 bottom: 55.h,
//                 right: 12.w,
//                 child: Container(
//                   height: 136.h,
//                   width: 88.w,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage("assets/images/Rectangle 20807.png"),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
