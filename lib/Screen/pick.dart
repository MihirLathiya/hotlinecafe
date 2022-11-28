import 'dart:developer';

import 'package:flutter/material.dart';

String name = 'TestLive4';
String token =
    '007eJxTYEjfJDIjs48zJf6T2mXvtK81pfP5/9/sPGC6R4s3blZ2zgIFhsTkZOOkVDOzpEQLIxMTQwNLy8RU4yQjizTzVAszs0SLADHX5PPpbsly944zMEIhiM/JEJJaXOKTWZZqwsAAAAgLIqo=';
String name1 = 'TestLive5';
String token1 =
    '007eJxTYMj7JN+5uEvT8qqemsrs3WvbzSalnC600XW9wsr575zWa2kFhsTkZOOkVDOzpEQLIxMTQwNLy8RU4yQjizTzVAszs0SLFWKuyRoZbsn+Fe8ZGKEQxOdkCEktLvHJLEs1ZWAAAJvEIJw=';
Future<String> chatRoomId(String user1, String user2) async {
  if (user1[0].toLowerCase().codeUnitAt(0) >
      user2.toLowerCase().codeUnitAt(0)) {
    return '$user1';
  } else {
    return '$user1';
  }
}

class ShowButton extends StatelessWidget {
  const ShowButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                String finalName =
                    await chatRoomId('$name%$token', '$name1%$token1');
                // String finalToken = await chatRoomId(token, token1);

                log('FINAL NAME :- ${finalName.split('%')[0]}');
                log('FINAL Token :- ${finalName.split('%')[1]}');

                // Get.to(() => CallUserScreen(
                //       channelName: finalName,
                //       channelToken: finalToken,
                //       followers: '12',
                //       userImage: '123',
                //       userType: true,
                //       userName: 'kl',
                //     ));
              },
              child: Icon(Icons.add),
            ),
            // ExpansionTile(
            //
            // )
          ],
        ),
      ),
    );
  }
}
