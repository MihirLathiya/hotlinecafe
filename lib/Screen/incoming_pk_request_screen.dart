// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class IncomingPkRequest extends StatelessWidget {
//   const IncomingPkRequest({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         children: [
//           SizedBox(height: 116.h),
//           Center(
//             child: Container(
//               height: 120.h,
//               width: 120.w,
//               decoration: BoxDecoration(
//                 // color: Colors.red,
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                   image: AssetImage('images/g.png'),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 16.h),
//           Text(
//             'Dulce Bothman',
//             style: TextStyle(
//               fontSize: 18.sp,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: 4.h),
//           Text(
//             'is inviting to join VS mode',
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: 260.h),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 48.w),
//             child: Row(
//               children: [
//                 Column(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         print('button');
//                       },
//                       child: Container(
//                         height: 60.h,
//                         width: 60.w,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: Colors.white.withOpacity(0.2),
//                           ),
//                           color: Colors.blueGrey.withOpacity(0.6),
//                         ),
//                         child:
//                             Icon(Icons.close, color: Colors.white, size: 28.sp),
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       'Reject',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: Colors.white,
//                       ),
//                     )
//                   ],
//                 ),
//                 Spacer(),
//                 Column(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         print('button');
//                       },
//                       child: Container(
//                         height: 60.h,
//                         width: 60.w,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Color(0xff53B175),
//                         ),
//                         child: Image.asset(
//                           'images/Video2.png',
//                           height: 28.h,
//                           width: 28.w,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       'Join',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: Colors.white,
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
