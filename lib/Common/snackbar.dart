import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CommonSnackBar {
  static commonSnackBar({String? message}) {
    Get.showSnackbar(GetSnackBar(
      message: message,
      duration: Duration(seconds: 2),
    ));
  }
}

class Users {
  String? username;
  String? image;
  String? name;
  String? id;

  Users({this.username, this.name, this.image, this.id});
}

class Message {
  String? message;
  String? type;
  String? user;
  String? image;

  Message({this.message, this.type, this.user, this.image});
}

backDropButton({String? icon, GestureDoubleTapCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    child: ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          height: 44.h,
          width: 44.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey.shade800.withOpacity(0.5),
                Colors.grey.shade800.withOpacity(0.5),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white12,
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              '$icon',
              color: Colors.white,
              height: 21.h,
              width: 21.w,
            ),
          ),
        ),
      ),
    ),
  );
}
