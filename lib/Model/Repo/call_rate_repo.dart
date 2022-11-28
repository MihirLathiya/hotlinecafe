import 'package:hotlinecafee/model/response_model/call_rate_res_model.dart';
import 'package:hotlinecafee/model/services/api_service.dart';
import 'package:hotlinecafee/model/services/base_service.dart';

class CallRateRepo extends BaseService {
  Future<CallRateResponseModel> callRateRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: update_call_rate, body: body, apitype: APIType.aPost);

    CallRateResponseModel callRateResponseModel =
        await CallRateResponseModel.fromJson(response);
    return callRateResponseModel;
  }
}
