import 'package:get/get.dart';

// class LiveController extends GetxController {
//   var isBrodCaster = true.obs;
//
//   bordCaster() {
//     isBrodCaster.value = true;
//   }
//
//   audience() {
//     isBrodCaster.value = false;
//   }
// }

class CountController extends GetxController {
  var count = 0.obs;
  var min = 0.obs;
  var hour = 0.obs;

  counterIncrease() {
    count.value++;
    if (count.value == 60) {
      count.value = 0;
      min.value += 1;
    }
    if (min.value == 60) {
      min.value = 0;
      hour.value += 1;
    }
  }
}

class Count1Controller extends GetxController {
  var count = 3.obs;

  counterIncrease() {
    count.value--;
  }

  defaultValue() {
    count.value = 3;
  }
}
