import 'package:hotlinecafee/Model/services/base_service.dart';
import 'package:hotlinecafee/model/response_model/send_gift_res_model.dart';

import '../services/api_service.dart';

class GiftRepo extends BaseService {
  Future<SendGiftResponseModel> sendGiftRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: send_gift, body: body, apitype: APIType.aPost);

    SendGiftResponseModel sendGiftResponseModel =
        await SendGiftResponseModel.fromJson(response);
    return sendGiftResponseModel;
  }
}
