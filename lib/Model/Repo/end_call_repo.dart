import 'package:hotlinecafee/Model/Response_model/end_call_res_model.dart';
import 'package:hotlinecafee/Model/Services/base_service.dart';
import 'package:hotlinecafee/Model/services/api_service.dart';

class EndCallRepo extends BaseService {
  Future<EndCallResponseModel> endCallRateRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: call_end, body: body, apitype: APIType.aPost);

    EndCallResponseModel endCallResponseModel =
        await EndCallResponseModel.fromJson(response);
    return endCallResponseModel;
  }
}
