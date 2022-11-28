import 'package:hotlinecafee/Model/Response_model/get_call_rate_res_model.dart';
import 'package:hotlinecafee/Model/services/api_service.dart';
import 'package:hotlinecafee/Model/services/base_service.dart';

class GetCallRateRepo extends BaseService {
  Future<GetCallRateResponseModel> getCallRateRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService().getResponse(
        url: 'https://irisinformatics.net/dating/wb/call_rate',
        body: body,
        apitype: APIType.aPost);

    GetCallRateResponseModel sendGiftResponseModel =
        await GetCallRateResponseModel.fromJson(response);
    return sendGiftResponseModel;
  }
}
