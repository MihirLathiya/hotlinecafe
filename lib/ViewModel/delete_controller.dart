import 'package:get/get.dart';

class StateController extends GetxController {
  var state = 'Online';

  changeState(value) {
    state = value;
  }
}
