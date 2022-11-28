import 'package:hotlinecafee/Model/Response_model/gift_history_res_model.dart';

import '../services/api_service.dart';
import '../services/base_service.dart';

class GiftHistoryRepo extends BaseService {
  Future<GiftHistoryResponseModel> giftHistoryRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: send_gift_list, body: body, apitype: APIType.aPost);

    GiftHistoryResponseModel giftHistoryResponseModel =
        await GiftHistoryResponseModel.fromJson(response);
    return giftHistoryResponseModel;
  }
}
