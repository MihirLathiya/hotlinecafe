import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Preference/preference.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

/// Container Decoration
class ContainerDecoration extends StatelessWidget {
  const ContainerDecoration({
    Key? key,
    required this.message,
    this.child,
    this.uid,
  }) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> message;
  final child;
  final uid;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: message['sendBy'] == PreferenceManager.getUserId()
          ? Alignment.topRight
          : Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(
            horizontal: message['type'] == 'img' ? 0.w : 12.w,
            vertical: message['type'] == 'img' ? 0.w : 16.h),
        decoration: BoxDecoration(
          borderRadius: message['sendBy'] == PreferenceManager.getUserId()
              ? BorderRadius.only(
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(0),
                ),
          color: message['type'] == 'img'
              ? Colors.transparent
              : message['sendBy'] == PreferenceManager.getUserId()
                  ? Color(0xff4B53FF)
                  : Color(0xff81818A),
        ),
        child: child,
      ),
    );
  }
}

/// UploadImage
Future uploadImage(
  chatRoomId,
  file,
) async {
  String fileName = 'img ${Random().nextInt(100000)}.png';
  int status = 1;
  firebaseFirestore
      .collection('chatroom')
      .doc(chatRoomId)
      .collection('chat')
      .doc(fileName)
      .set({
    'sendBy': PreferenceManager.getUserId(),
    'message': '',
    'type': 'img',
    'isDelete': false,
    'isCheck': false,
    // 'isPlay': false,
    'time': DateTime.now()
  });

  var ref =
      FirebaseStorage.instance.ref().child('image').child('$fileName.img');
  var uploadTask = await ref.putFile(file!).catchError((error) async {
    print('ERRORRRRRRRRR');
    firebaseFirestore
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chat')
        .doc(fileName)
        .delete();

    status = 0;
  });
  if (status == 1) {
    String imageUrl = await uploadTask.ref.getDownloadURL();
    firebaseFirestore
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chat')
        .doc(fileName)
        .update({'message': imageUrl});

    print(
        '================================>>>>>>>>>>>>>>>>>>>>>>>>>>>>$imageUrl');
  }
}

/// Loading Image
class Loading extends StatelessWidget {
  final message;
  const Loading({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 168.h,
      width: 144.w,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(100),
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Center(
        child: Stack(
          children: [
            Center(
              child: GestureDetector(
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => ShowImage(
                          url: message['message'],
                        ));
                  },
                  child: Hero(
                    tag: message['message'],
                    child: Container(
                      height: 168.h,
                      width: 144.w,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            message['message'],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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

class ShowImage extends StatelessWidget {
  final url;
  const ShowImage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          InteractiveViewer(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: NetworkImage('${url}'),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 45),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Hero(
                tag: '$url',
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
