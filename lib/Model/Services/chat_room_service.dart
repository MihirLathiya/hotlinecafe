import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> chatRoomId(String user1, String user2) async {
  if (int.parse(user1) > int.parse(user2)) {
    return '$user2$user1';
  } else {
    return '$user1$user2';
  }
}

Future<String?> uploadFile({File? file, String? filename}) async {
  print("File path:$file");
  try {
    var response = await FirebaseStorage.instance
        .ref("user_image/$filename")
        .putFile(file!);
    var result =
        await response.storage.ref("user_image/$filename").getDownloadURL();
    return result;
  } catch (e) {
    print("ERROR===>>$e");
  }
  return null;
}
