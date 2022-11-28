import 'package:get/get.dart';
import 'package:hotlinecafee/model/repo/notification_repo.dart';
import 'package:hotlinecafee/model/response_model/notification_res_model.dart';

import '../model/apis/api_response.dart';

class NotificationViewModel extends GetxController {
  ApiResponse _notificationApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get notificationApiResponse => _notificationApiResponse;

  Future<void> notificationViewModel({Map<String, dynamic>? model}) async {
    _notificationApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      NotificationResponseModel response =
          await NotificationRepo().notificationRepo(body: model);
      print("NotificationResponseModel=response==>$response");

      _notificationApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("NotificationResponseModel=e==>$e");
      // CommonSnackBar.commonSnackBar(message: "Number Already Used.");
      _notificationApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
