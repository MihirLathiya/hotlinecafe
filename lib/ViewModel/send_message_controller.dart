import 'package:get/get.dart';

class SendMessageController extends GetxController {
  var isSend = false.obs;

  isSendMessage() {
    isSend.value = true;
  }

  isNotSendMessage() {
    isSend.value = false;
  }
}
