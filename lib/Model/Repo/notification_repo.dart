import 'package:hotlinecafee/model/response_model/notification_res_model.dart';

import '../services/api_service.dart';
import '../services/base_service.dart';

class NotificationRepo extends BaseService {
  Future<NotificationResponseModel> notificationRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: notification, body: body, apitype: APIType.aPost);
    NotificationResponseModel notificationResponseModel =
        NotificationResponseModel.fromJson(response);
    // log('LOCATION$response');
    return notificationResponseModel;
  }
}
